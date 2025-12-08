import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/auth_session_model.dart';

/// Exception thrown when authentication fails
class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Remote data source for authentication with records.iitpkd.ac.in
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConstants.recordsPortal,
              connectTimeout: AppConstants.apiTimeout,
              receiveTimeout: AppConstants.apiTimeout,
              followRedirects: false,
              validateStatus: (status) => status != null && status < 500,
            ));

  /// Authenticate with username and password
  /// Returns session cookies on successful login
  Future<AuthSessionModel> login(String username, String password) async {
    try {
      // First, get the login page to obtain any CSRF token if needed
      final loginPageResponse = await _dio.get('/login');

      // Extract cookies from initial request
      final initialCookies = loginPageResponse.headers['set-cookie'] ?? [];

      // Prepare login form data
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      // Perform login POST request
      final response = await _dio.post(
        '/login',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Cookie': initialCookies.join('; '),
          },
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Check for successful login
      // A successful login typically redirects (302) or returns 200
      if (response.statusCode == 302 || response.statusCode == 200) {
        // Extract session cookies from response
        final cookies = response.headers['set-cookie'] ?? [];

        if (cookies.isEmpty && initialCookies.isEmpty) {
          throw AuthException('No session cookies received');
        }

        // Combine all cookies into session token
        final allCookies = [...initialCookies, ...cookies];
        final sessionToken = _extractSessionToken(allCookies);

        // Check if login was actually successful by looking for error indicators
        final responseBody = response.data?.toString() ?? '';
        if (_containsLoginError(responseBody)) {
          throw AuthException('Invalid username or password');
        }

        return AuthSessionModel(
          username: username,
          sessionToken: sessionToken,
          loginTime: DateTime.now(),
          // Session typically valid for 24 hours
          expiryTime: DateTime.now().add(const Duration(hours: 24)),
        );
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw AuthException('Invalid username or password', statusCode: response.statusCode);
      } else {
        throw AuthException(
          'Login failed with status: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw AuthException('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw AuthException('Unable to connect to the server. Please check your internet connection.');
      } else {
        throw AuthException('Network error: ${e.message}');
      }
    }
  }

  /// Validate if the session is still active
  Future<bool> validateSession(String sessionToken) async {
    try {
      final response = await _dio.get(
        '/',
        options: Options(
          headers: {'Cookie': sessionToken},
          followRedirects: false,
        ),
      );

      // If we're redirected to login page, session is invalid
      if (response.statusCode == 302) {
        final location = response.headers['location']?.first ?? '';
        if (location.contains('login')) {
          return false;
        }
      }

      // Check response for logged-in indicators
      final body = response.data?.toString() ?? '';
      return !body.contains('login') || body.contains('logout');
    } catch (e) {
      return false;
    }
  }

  /// Extract session token from cookie headers
  String _extractSessionToken(List<String> cookies) {
    // Combine all relevant cookies
    final sessionCookies = cookies.map((cookie) {
      // Extract just the cookie name=value part
      final parts = cookie.split(';');
      return parts.first.trim();
    }).toList();

    return sessionCookies.join('; ');
  }

  /// Check if response contains login error messages
  bool _containsLoginError(String responseBody) {
    final errorIndicators = [
      'invalid',
      'incorrect',
      'wrong password',
      'authentication failed',
      'login failed',
      'error',
    ];

    final lowerBody = responseBody.toLowerCase();
    return errorIndicators.any((indicator) => lowerBody.contains(indicator));
  }
}
