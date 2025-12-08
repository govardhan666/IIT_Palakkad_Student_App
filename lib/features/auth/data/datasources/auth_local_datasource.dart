import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth_session_model.dart';

/// Storage keys for auth data
class AuthStorageKeys {
  static const String session = 'auth_session';
  static const String username = 'auth_username';
  static const String password = 'auth_password';
  static const String rememberMe = 'auth_remember_me';
}

/// Local data source for secure credential storage
class AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  AuthLocalDataSource({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock_this_device,
              ),
            );

  /// Save session to secure storage
  Future<void> saveSession(AuthSessionModel session) async {
    final json = jsonEncode(session.toJson());
    await _secureStorage.write(key: AuthStorageKeys.session, value: json);
  }

  /// Retrieve saved session
  Future<AuthSessionModel?> getSession() async {
    final json = await _secureStorage.read(key: AuthStorageKeys.session);
    if (json == null) return null;

    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return AuthSessionModel.fromJson(map);
    } catch (e) {
      // Invalid session data, clear it
      await clearSession();
      return null;
    }
  }

  /// Clear saved session
  Future<void> clearSession() async {
    await _secureStorage.delete(key: AuthStorageKeys.session);
  }

  /// Save credentials for auto-login
  Future<void> saveCredentials(String username, String password) async {
    await _secureStorage.write(key: AuthStorageKeys.username, value: username);
    await _secureStorage.write(key: AuthStorageKeys.password, value: password);
    await _secureStorage.write(key: AuthStorageKeys.rememberMe, value: 'true');
  }

  /// Get stored credentials
  Future<({String? username, String? password})?> getCredentials() async {
    final rememberMe = await _secureStorage.read(key: AuthStorageKeys.rememberMe);
    if (rememberMe != 'true') return null;

    final username = await _secureStorage.read(key: AuthStorageKeys.username);
    final password = await _secureStorage.read(key: AuthStorageKeys.password);

    if (username == null || password == null) return null;

    return (username: username, password: password);
  }

  /// Clear stored credentials
  Future<void> clearCredentials() async {
    await _secureStorage.delete(key: AuthStorageKeys.username);
    await _secureStorage.delete(key: AuthStorageKeys.password);
    await _secureStorage.delete(key: AuthStorageKeys.rememberMe);
  }

  /// Clear all auth data
  Future<void> clearAll() async {
    await clearSession();
    await clearCredentials();
  }

  /// Check if remember me is enabled
  Future<bool> isRememberMeEnabled() async {
    final value = await _secureStorage.read(key: AuthStorageKeys.rememberMe);
    return value == 'true';
  }
}
