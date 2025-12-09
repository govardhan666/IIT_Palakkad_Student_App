import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/course_model.dart';
import '../models/semester_model.dart';

/// Storage keys for course data
class CourseStorageKeys {
  static const String courses = 'cached_courses';
  static const String semesters = 'cached_semesters';
  static const String currentSemester = 'current_semester';
  static const String lastFetch = 'courses_last_fetch';
}

/// Local data source for caching course data
class CourseLocalDataSource {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// Save courses to local storage
  Future<void> saveCourses(List<CourseModel> courses, String semesterId) async {
    final prefs = await _prefs;
    final coursesJson = courses.map((c) => c.toJson()).toList();
    await prefs.setString(CourseStorageKeys.courses, jsonEncode(coursesJson));
    await prefs.setString(CourseStorageKeys.currentSemester, semesterId);
    await prefs.setString(
      CourseStorageKeys.lastFetch,
      DateTime.now().toIso8601String(),
    );
  }

  /// Get cached courses
  Future<List<CourseModel>?> getCourses() async {
    final prefs = await _prefs;
    final json = prefs.getString(CourseStorageKeys.courses);
    if (json == null) return null;

    try {
      final List<dynamic> list = jsonDecode(json);
      return list.map((e) => CourseModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      return null;
    }
  }

  /// Save semesters to local storage
  Future<void> saveSemesters(List<SemesterModel> semesters) async {
    final prefs = await _prefs;
    final semestersJson = semesters.map((s) => s.toJson()).toList();
    await prefs.setString(CourseStorageKeys.semesters, jsonEncode(semestersJson));
  }

  /// Get cached semesters
  Future<List<SemesterModel>?> getSemesters() async {
    final prefs = await _prefs;
    final json = prefs.getString(CourseStorageKeys.semesters);
    if (json == null) return null;

    try {
      final List<dynamic> list = jsonDecode(json);
      return list.map((e) => SemesterModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      return null;
    }
  }

  /// Get current semester ID
  Future<String?> getCurrentSemesterId() async {
    final prefs = await _prefs;
    return prefs.getString(CourseStorageKeys.currentSemester);
  }

  /// Set current semester ID
  Future<void> setCurrentSemesterId(String semesterId) async {
    final prefs = await _prefs;
    await prefs.setString(CourseStorageKeys.currentSemester, semesterId);
  }

  /// Check if cache is still valid (less than 24 hours old)
  Future<bool> isCacheValid() async {
    final prefs = await _prefs;
    final lastFetchStr = prefs.getString(CourseStorageKeys.lastFetch);
    if (lastFetchStr == null) return false;

    try {
      final lastFetch = DateTime.parse(lastFetchStr);
      final now = DateTime.now();
      return now.difference(lastFetch).inHours < 24;
    } catch (e) {
      return false;
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    final prefs = await _prefs;
    await prefs.remove(CourseStorageKeys.courses);
    await prefs.remove(CourseStorageKeys.semesters);
    await prefs.remove(CourseStorageKeys.currentSemester);
    await prefs.remove(CourseStorageKeys.lastFetch);
  }
}
