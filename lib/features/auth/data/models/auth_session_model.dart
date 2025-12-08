import '../../domain/entities/auth_session.dart';

/// Data model for AuthSession with JSON serialization support
class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.username,
    required super.sessionToken,
    required super.loginTime,
    super.expiryTime,
  });

  /// Create from JSON map (for storage retrieval)
  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      username: json['username'] as String,
      sessionToken: json['sessionToken'] as String,
      loginTime: DateTime.parse(json['loginTime'] as String),
      expiryTime: json['expiryTime'] != null
          ? DateTime.parse(json['expiryTime'] as String)
          : null,
    );
  }

  /// Convert to JSON map (for storage)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'sessionToken': sessionToken,
      'loginTime': loginTime.toIso8601String(),
      'expiryTime': expiryTime?.toIso8601String(),
    };
  }

  /// Create from domain entity
  factory AuthSessionModel.fromEntity(AuthSession entity) {
    return AuthSessionModel(
      username: entity.username,
      sessionToken: entity.sessionToken,
      loginTime: entity.loginTime,
      expiryTime: entity.expiryTime,
    );
  }
}
