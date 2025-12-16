import 'package:dio/dio.dart';
import '../../domain/entities/wifi_credentials.dart';

/// Remote datasource for WiFi login operations
/// Handles login to IIT Palakkad campus WiFi captive portal
class WifiRemoteDatasource {
  final Dio _dio;

  // IIT Palakkad FortiGate captive portal endpoints
  static const String _loginUrl = 'http://172.16.0.1:1000/fgtauth';
  static const String _logoutUrl = 'http://172.16.0.1:1000/logout';
  static const String _statusUrl = 'http://172.16.0.1:1000/';

  WifiRemoteDatasource({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              validateStatus: (status) => status != null && status < 500,
              followRedirects: false,
            ));

  /// Login to campus WiFi
  Future<WifiLoginResult> login(WifiCredentials credentials) async {
    try {
      // First check if already connected
      final statusCheck = await checkStatus();
      if (statusCheck.status == WifiConnectionStatus.alreadyLoggedIn) {
        return statusCheck;
      }

      // Prepare login form data
      final formData = FormData.fromMap({
        'username': credentials.username,
        'password': credentials.password,
        'magic': '', // Some portals require this
        '4Tredir': '/',
      });

      // Attempt login
      final response = await _dio.post(
        _loginUrl,
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      // Check response for success indicators
      final responseBody = response.data?.toString() ?? '';

      if (response.statusCode == 200 || response.statusCode == 302) {
        // Check for success indicators in response
        if (responseBody.contains('Logged in') ||
            responseBody.contains('successful') ||
            responseBody.contains('welcome') ||
            response.statusCode == 302) {
          // Try to extract IP address
          String? ipAddress;
          final ipMatch = RegExp(r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})')
              .firstMatch(responseBody);
          if (ipMatch != null) {
            ipAddress = ipMatch.group(1);
          }
          return WifiLoginResult.success(ipAddress: ipAddress);
        }

        // Check for error messages
        if (responseBody.contains('Invalid') ||
            responseBody.contains('incorrect') ||
            responseBody.contains('failed')) {
          return WifiLoginResult.failed('Invalid username or password');
        }

        // Check if already logged in
        if (responseBody.contains('already') ||
            responseBody.contains('You are logged in')) {
          return WifiLoginResult.alreadyLoggedIn();
        }
      }

      // Generic success assumption for redirects
      if (response.statusCode == 302 || response.statusCode == 303) {
        return WifiLoginResult.success();
      }

      return WifiLoginResult.failed('Login failed. Please try again.');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return WifiLoginResult.failed('Connection timeout. Are you connected to campus WiFi?');
      }
      if (e.type == DioExceptionType.connectionError) {
        return WifiLoginResult.failed('Cannot reach WiFi portal. Please connect to campus network first.');
      }
      return WifiLoginResult.failed('Network error: ${e.message}');
    } catch (e) {
      return WifiLoginResult.failed('An unexpected error occurred');
    }
  }

  /// Logout from campus WiFi
  Future<WifiLoginResult> logout() async {
    try {
      await _dio.get(_logoutUrl);
      return WifiLoginResult.disconnected();
    } catch (e) {
      return WifiLoginResult.disconnected();
    }
  }

  /// Check current connection status
  Future<WifiLoginResult> checkStatus() async {
    try {
      final response = await _dio.get(
        _statusUrl,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      final responseBody = response.data?.toString() ?? '';

      // If we get redirected to login page, not logged in
      if (response.statusCode == 302 || response.statusCode == 303) {
        return WifiLoginResult.disconnected();
      }

      // Check if logged in
      if (responseBody.contains('logged in') ||
          responseBody.contains('Logged in') ||
          responseBody.contains('You are logged in') ||
          responseBody.contains('Logout')) {
        // Try to extract IP
        String? ipAddress;
        final ipMatch = RegExp(r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})')
            .firstMatch(responseBody);
        if (ipMatch != null) {
          ipAddress = ipMatch.group(1);
        }
        return WifiLoginResult.alreadyLoggedIn(ipAddress: ipAddress);
      }

      return WifiLoginResult.disconnected();
    } catch (e) {
      return WifiLoginResult.disconnected();
    }
  }
}
