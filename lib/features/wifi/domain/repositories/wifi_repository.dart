import '../entities/wifi_credentials.dart';

/// Repository interface for WiFi operations
abstract class WifiRepository {
  /// Save WiFi credentials securely
  Future<void> saveCredentials(WifiCredentials credentials);

  /// Get saved WiFi credentials
  Future<WifiCredentials?> getCredentials();

  /// Delete saved credentials
  Future<void> deleteCredentials();

  /// Login to campus WiFi
  Future<WifiLoginResult> login(WifiCredentials credentials);

  /// Logout from campus WiFi
  Future<WifiLoginResult> logout();

  /// Check current connection status
  Future<WifiLoginResult> checkStatus();

  /// Get auto-login preference
  Future<bool> isAutoLoginEnabled();

  /// Set auto-login preference
  Future<void> setAutoLogin(bool enabled);
}
