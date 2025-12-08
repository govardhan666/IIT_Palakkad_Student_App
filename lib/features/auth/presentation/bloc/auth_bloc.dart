import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC for managing authentication state
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepositoryImpl(),
        super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthAutoLoginRequested>(_onAuthAutoLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthErrorCleared>(_onAuthErrorCleared);
  }

  /// Handle auth status check on app start
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Checking authentication...'));

    try {
      final isLoggedIn = await _authRepository.isLoggedIn();

      if (isLoggedIn) {
        // Get current session from repository
        final repo = _authRepository as AuthRepositoryImpl;
        final session = repo.currentSession;

        if (session != null) {
          emit(AuthAuthenticated(session: session));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        // Check for stored username to pre-fill login form
        final credentials = await _authRepository.getStoredCredentials();
        emit(AuthUnauthenticated(lastUsername: credentials?.username));
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  /// Handle login request
  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Signing in...'));

    final result = await _authRepository.login(event.username, event.password);

    if (result.success && result.session != null) {
      emit(AuthAuthenticated(session: result.session!));
    } else {
      emit(AuthError(
        message: result.errorMessage ?? 'Login failed',
        username: event.username,
      ));
    }
  }

  /// Handle auto-login with stored credentials
  Future<void> _onAuthAutoLoginRequested(
    AuthAutoLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Signing in...'));

    try {
      final credentials = await _authRepository.getStoredCredentials();

      if (credentials == null ||
          credentials.username == null ||
          credentials.password == null) {
        emit(const AuthUnauthenticated());
        return;
      }

      final result = await _authRepository.login(
        credentials.username!,
        credentials.password!,
      );

      if (result.success && result.session != null) {
        emit(AuthAuthenticated(session: result.session!));
      } else {
        emit(AuthUnauthenticated(lastUsername: credentials.username));
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  /// Handle logout request
  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Signing out...'));

    await _authRepository.logout();

    emit(const AuthUnauthenticated());
  }

  /// Clear error state
  void _onAuthErrorCleared(
    AuthErrorCleared event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthError) {
      final errorState = state as AuthError;
      emit(AuthUnauthenticated(lastUsername: errorState.username));
    }
  }
}
