import '../../domain/entities/wifi_credentials.dart';

/// WiFi credentials model with JSON serialization
class WifiCredentialsModel extends WifiCredentials {
  const WifiCredentialsModel({
    required super.username,
    required super.password,
    super.autoLogin,
  });

  factory WifiCredentialsModel.fromEntity(WifiCredentials credentials) {
    return WifiCredentialsModel(
      username: credentials.username,
      password: credentials.password,
      autoLogin: credentials.autoLogin,
    );
  }

  factory WifiCredentialsModel.fromJson(Map<String, dynamic> json) {
    return WifiCredentialsModel(
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      autoLogin: json['autoLogin'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'autoLogin': autoLogin,
    };
  }
}
