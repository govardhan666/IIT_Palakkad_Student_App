import '../entities/course.dart';
import '../entities/semester.dart';

/// Result class for course operations
class CourseResult {
  final bool success;
  final String? errorMessage;
  final List<Course>? courses;
  final List<Semester>? semesters;

  const CourseResult._({
    required this.success,
    this.errorMessage,
    this.courses,
    this.semesters,
  });

  factory CourseResult.success({
    List<Course>? courses,
    List<Semester>? semesters,
  }) {
    return CourseResult._(
      success: true,
      courses: courses,
      semesters: semesters,
    );
  }

  factory CourseResult.failure(String message) {
    return CourseResult._(success: false, errorMessage: message);
  }
}

/// Abstract repository interface for course operations
abstract class CourseRepository {
  /// Fetch available semesters from the portal
  Future<CourseResult> fetchSemesters();

  /// Fetch courses for a specific semester
  Future<CourseResult> fetchCourses(String semesterId);

  /// Get cached courses (from local storage)
  Future<List<Course>?> getCachedCourses();

  /// Cache courses locally
  Future<void> cacheCourses(List<Course> courses, String semesterId);

  /// Clear cached courses
  Future<void> clearCache();
}
