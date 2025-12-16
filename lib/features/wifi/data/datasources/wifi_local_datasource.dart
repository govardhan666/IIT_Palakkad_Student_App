import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/wifi_credentials_model.dart';

/// Local datasource for WiFi credentials using secure storage
class WifiLocalDatasource {
  static const String _credentialsKey = 'wifi_credentials';
  static const String _autoLoginKey = 'wifi_auto_login';

  final FlutterSecureStorage _secureStorage;

  WifiLocalDatasource({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Save credentials securely
  Future<void> saveCredentials(WifiCredentialsModel credentials) async {
    final json = jsonEncode(credentials.toJson());
    await _secureStorage.write(key: _credentialsKey, value: json);
  }

  /// Get saved credentials
  Future<WifiCredentialsModel?> getCredentials() async {
    final json = await _secureStorage.read(key: _credentialsKey);
    if (json == null || json.isEmpty) {
      return null;
    }
    try {
      final data = jsonDecode(json) as Map<String, dynamic>;
      return WifiCredentialsModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  /// Delete credentials
  Future<void> deleteCredentials() async {
    await _secureStorage.delete(key: _credentialsKey);
  }

  /// Check if auto-login is enabled
  Future<bool> isAutoLoginEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoLoginKey) ?? false;
  }

  /// Set auto-login preference
  Future<void> setAutoLogin(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoLoginKey, enabled);
  }
}
