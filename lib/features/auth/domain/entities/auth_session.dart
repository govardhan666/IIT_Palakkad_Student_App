/// Entity representing an authenticated user session
class AuthSession {
  final String username;
  final String sessionToken;
  final DateTime loginTime;
  final DateTime? expiryTime;

  const AuthSession({
    required this.username,
    required this.sessionToken,
    required this.loginTime,
    this.expiryTime,
  });

  /// Check if the session is still valid
  bool get isValid {
    if (expiryTime == null) return true;
    return DateTime.now().isBefore(expiryTime!);
  }

  @override
  String toString() {
    return 'AuthSession(username: $username, loginTime: $loginTime, isValid: $isValid)';
  }
}
