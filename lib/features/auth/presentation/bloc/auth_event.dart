import 'package:flutter/foundation.dart';

/// Base class for all authentication events
@immutable
abstract class AuthEvent {
  const AuthEvent();
}

/// Event to check authentication status on app start
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Event to attempt login with credentials
class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;
  final bool rememberMe;

  const AuthLoginRequested({
    required this.username,
    required this.password,
    this.rememberMe = true,
  });
}

/// Event to perform auto-login with stored credentials
class AuthAutoLoginRequested extends AuthEvent {
  const AuthAutoLoginRequested();
}

/// Event to logout
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// Event to clear any error state
class AuthErrorCleared extends AuthEvent {
  const AuthErrorCleared();
}
