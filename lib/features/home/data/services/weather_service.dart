import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/weather_model.dart';

/// Service for fetching weather data
class WeatherService {
  final Dio _dio;
  static const String _cacheKey = 'cached_weather';
  static const String _cacheTimeKey = 'weather_cache_time';

  // IIT Palakkad coordinates
  static const double latitude = 10.8676;
  static const double longitude = 76.6524;

  WeatherService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  /// Fetch current weather for IIT Palakkad
  Future<WeatherModel?> fetchWeather() async {
    try {
      // Try to get from cache first (valid for 30 minutes)
      final cached = await _getCachedWeather();
      if (cached != null) {
        return cached;
      }

      // Fetch from wttr.in
      final response = await _dio.get(
        '${AppConstants.weatherApiBase}/$latitude,$longitude',
        queryParameters: {'format': 'j1'},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final weather = WeatherModel.fromWttrJson(
          data is String ? jsonDecode(data) : data,
        );

        // Cache the result
        await _cacheWeather(weather);

        return weather;
      }
    } catch (e) {
      // Try to return cached data on error
      final cached = await _getCachedWeather(ignoreExpiry: true);
      if (cached != null) {
        return cached;
      }
    }
    return null;
  }

  /// Get cached weather data
  Future<WeatherModel?> _getCachedWeather({bool ignoreExpiry = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheTimeStr = prefs.getString(_cacheTimeKey);
      final cachedData = prefs.getString(_cacheKey);

      if (cachedData == null) return null;

      if (!ignoreExpiry && cacheTimeStr != null) {
        final cacheTime = DateTime.parse(cacheTimeStr);
        final now = DateTime.now();
        // Cache valid for 30 minutes
        if (now.difference(cacheTime).inMinutes > 30) {
          return null;
        }
      }

      final json = jsonDecode(cachedData) as Map<String, dynamic>;
      return WeatherModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Cache weather data
  Future<void> _cacheWeather(WeatherModel weather) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(weather.toJson()));
      await prefs.setString(_cacheTimeKey, DateTime.now().toIso8601String());
    } catch (e) {
      // Ignore cache errors
    }
  }
}
