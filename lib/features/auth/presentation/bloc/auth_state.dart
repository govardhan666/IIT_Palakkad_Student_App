import 'package:flutter/foundation.dart';
import '../../domain/entities/auth_session.dart';

/// Base class for all authentication states
@immutable
abstract class AuthState {
  const AuthState();
}

/// Initial state - checking auth status
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state - login/logout in progress
class AuthLoading extends AuthState {
  final String? message;

  const AuthLoading({this.message});
}

/// Authenticated state - user is logged in
class AuthAuthenticated extends AuthState {
  final AuthSession session;

  const AuthAuthenticated({required this.session});

  String get username => session.username;
}

/// Unauthenticated state - user is not logged in
class AuthUnauthenticated extends AuthState {
  /// Optional stored username for pre-filling login form
  final String? lastUsername;

  const AuthUnauthenticated({this.lastUsername});
}

/// Error state - authentication failed
class AuthError extends AuthState {
  final String message;
  final String? username;

  const AuthError({
    required this.message,
    this.username,
  });
}
