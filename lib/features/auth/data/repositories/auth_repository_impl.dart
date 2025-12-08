import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_session_model.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthSessionModel? _currentSession;

  AuthRepositoryImpl({
    AuthRemoteDataSource? remoteDataSource,
    AuthLocalDataSource? localDataSource,
  })  : _remoteDataSource = remoteDataSource ?? AuthRemoteDataSource(),
        _localDataSource = localDataSource ?? AuthLocalDataSource();

  @override
  Future<AuthResult> login(String username, String password) async {
    try {
      // Attempt login with remote server
      final session = await _remoteDataSource.login(username, password);

      // Cache session locally
      _currentSession = session;
      await _localDataSource.saveSession(session);
      await _localDataSource.saveCredentials(username, password);

      return AuthResult.success(session);
    } on AuthException catch (e) {
      return AuthResult.failure(e.message);
    } catch (e) {
      return AuthResult.failure('An unexpected error occurred. Please try again.');
    }
  }

  @override
  Future<void> logout() async {
    _currentSession = null;
    await _localDataSource.clearAll();
  }

  @override
  Future<bool> isLoggedIn() async {
    // Check in-memory cache first
    if (_currentSession != null && _currentSession!.isValid) {
      return true;
    }

    // Try to load from storage
    final storedSession = await _localDataSource.getSession();
    if (storedSession == null) {
      return false;
    }

    // Check if session is still valid locally
    if (!storedSession.isValid) {
      await _localDataSource.clearSession();
      return false;
    }

    // Validate session with server
    final isValid = await _remoteDataSource.validateSession(storedSession.sessionToken);
    if (!isValid) {
      await _localDataSource.clearSession();
      return false;
    }

    // Session is valid, cache it
    _currentSession = storedSession;
    return true;
  }

  @override
  Future<({String? username, String? password})?> getStoredCredentials() async {
    return _localDataSource.getCredentials();
  }

  @override
  Future<bool> validateSession() async {
    final session = _currentSession ?? await _localDataSource.getSession();
    if (session == null) return false;

    return _remoteDataSource.validateSession(session.sessionToken);
  }

  /// Get current session if available
  AuthSession? get currentSession => _currentSession;

  /// Get session token for API calls
  Future<String?> getSessionToken() async {
    if (_currentSession != null) {
      return _currentSession!.sessionToken;
    }

    final storedSession = await _localDataSource.getSession();
    return storedSession?.sessionToken;
  }
}
