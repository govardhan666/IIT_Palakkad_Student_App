/// WiFi credentials entity
class WifiCredentials {
  final String username;
  final String password;
  final bool autoLogin;

  const WifiCredentials({
    required this.username,
    required this.password,
    this.autoLogin = false,
  });

  WifiCredentials copyWith({
    String? username,
    String? password,
    bool? autoLogin,
  }) {
    return WifiCredentials(
      username: username ?? this.username,
      password: password ?? this.password,
      autoLogin: autoLogin ?? this.autoLogin,
    );
  }

  bool get hasCredentials => username.isNotEmpty && password.isNotEmpty;
}

/// WiFi connection status
enum WifiConnectionStatus {
  disconnected,
  connecting,
  connected,
  failed,
  alreadyLoggedIn,
}

/// WiFi login result
class WifiLoginResult {
  final WifiConnectionStatus status;
  final String? message;
  final String? ipAddress;
  final DateTime? connectedAt;

  const WifiLoginResult({
    required this.status,
    this.message,
    this.ipAddress,
    this.connectedAt,
  });

  factory WifiLoginResult.success({String? ipAddress}) {
    return WifiLoginResult(
      status: WifiConnectionStatus.connected,
      message: 'Successfully connected to campus WiFi',
      ipAddress: ipAddress,
      connectedAt: DateTime.now(),
    );
  }

  factory WifiLoginResult.alreadyLoggedIn({String? ipAddress}) {
    return WifiLoginResult(
      status: WifiConnectionStatus.alreadyLoggedIn,
      message: 'Already logged in to campus WiFi',
      ipAddress: ipAddress,
      connectedAt: DateTime.now(),
    );
  }

  factory WifiLoginResult.failed(String message) {
    return WifiLoginResult(
      status: WifiConnectionStatus.failed,
      message: message,
    );
  }

  factory WifiLoginResult.disconnected() {
    return const WifiLoginResult(
      status: WifiConnectionStatus.disconnected,
      message: 'Not connected to campus WiFi',
    );
  }

  bool get isSuccess =>
      status == WifiConnectionStatus.connected ||
      status == WifiConnectionStatus.alreadyLoggedIn;
}
