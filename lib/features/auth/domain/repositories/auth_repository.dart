import '../entities/auth_session.dart';

/// Result class for authentication operations
class AuthResult {
  final bool success;
  final String? errorMessage;
  final AuthSession? session;

  const AuthResult._({
    required this.success,
    this.errorMessage,
    this.session,
  });

  factory AuthResult.success(AuthSession session) {
    return AuthResult._(success: true, session: session);
  }

  factory AuthResult.failure(String message) {
    return AuthResult._(success: false, errorMessage: message);
  }
}

/// Abstract repository interface for authentication operations
abstract class AuthRepository {
  /// Login with username and password
  /// Returns AuthResult with session token on success
  Future<AuthResult> login(String username, String password);

  /// Logout and clear stored credentials
  Future<void> logout();

  /// Check if user is currently logged in with valid session
  Future<bool> isLoggedIn();

  /// Get stored credentials for auto-login
  Future<({String? username, String? password})?> getStoredCredentials();

  /// Validate existing session with the server
  Future<bool> validateSession();
}
