import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/semester.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_local_datasource.dart';
import '../datasources/course_remote_datasource.dart';
import '../models/course_model.dart';
import '../models/semester_model.dart';

/// Implementation of CourseRepository
class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource _remoteDataSource;
  final CourseLocalDataSource _localDataSource;
  final AuthRepositoryImpl _authRepository;

  // Cached data
  List<SemesterModel>? _cachedSemesters;
  List<CourseModel>? _cachedCourses;
  String? _currentSemesterId;

  CourseRepositoryImpl({
    CourseRemoteDataSource? remoteDataSource,
    CourseLocalDataSource? localDataSource,
    required AuthRepositoryImpl authRepository,
  })  : _remoteDataSource = remoteDataSource ?? CourseRemoteDataSource(),
        _localDataSource = localDataSource ?? CourseLocalDataSource(),
        _authRepository = authRepository;

  @override
  Future<CourseResult> fetchSemesters() async {
    try {
      final sessionToken = await _authRepository.getSessionToken();
      if (sessionToken == null) {
        return CourseResult.failure('Not authenticated. Please login again.');
      }

      final result = await _remoteDataSource.fetchCoursesPage(sessionToken);

      _cachedSemesters = result.semesters;
      _cachedCourses = result.courses;
      _currentSemesterId = result.currentSemester;

      // Cache locally
      if (result.semesters.isNotEmpty) {
        await _localDataSource.saveSemesters(result.semesters);
      }
      if (result.courses.isNotEmpty && result.currentSemester != null) {
        await _localDataSource.saveCourses(result.courses, result.currentSemester!);
      }

      return CourseResult.success(
        semesters: result.semesters,
        courses: result.courses,
      );
    } on CourseException catch (e) {
      // Try to load from cache on network error
      if (e.message.contains('connection') || e.message.contains('timeout')) {
        final cachedSemesters = await _localDataSource.getSemesters();
        final cachedCourses = await _localDataSource.getCourses();
        if (cachedSemesters != null || cachedCourses != null) {
          return CourseResult.success(
            semesters: cachedSemesters,
            courses: cachedCourses,
          );
        }
      }
      return CourseResult.failure(e.message);
    } catch (e) {
      return CourseResult.failure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<CourseResult> fetchCourses(String semesterId) async {
    try {
      final sessionToken = await _authRepository.getSessionToken();
      if (sessionToken == null) {
        return CourseResult.failure('Not authenticated. Please login again.');
      }

      final result = await _remoteDataSource.fetchCoursesPage(
        sessionToken,
        semesterId: semesterId,
      );

      _cachedCourses = result.courses;
      _currentSemesterId = semesterId;

      // Cache locally
      if (result.courses.isNotEmpty) {
        await _localDataSource.saveCourses(result.courses, semesterId);
      }

      return CourseResult.success(courses: result.courses);
    } on CourseException catch (e) {
      return CourseResult.failure(e.message);
    } catch (e) {
      return CourseResult.failure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<Course>?> getCachedCourses() async {
    if (_cachedCourses != null) {
      return _cachedCourses;
    }
    return _localDataSource.getCourses();
  }

  @override
  Future<void> cacheCourses(List<Course> courses, String semesterId) async {
    final models = courses.map((c) => CourseModel.fromEntity(c)).toList();
    _cachedCourses = models;
    _currentSemesterId = semesterId;
    await _localDataSource.saveCourses(models, semesterId);
  }

  @override
  Future<void> clearCache() async {
    _cachedSemesters = null;
    _cachedCourses = null;
    _currentSemesterId = null;
    await _localDataSource.clearCache();
  }

  /// Get cached semesters
  List<Semester>? get cachedSemesters => _cachedSemesters;

  /// Get current semester ID
  String? get currentSemesterId => _currentSemesterId;

  /// Load cached data on startup
  Future<void> loadCachedData() async {
    _cachedSemesters = await _localDataSource.getSemesters();
    _cachedCourses = await _localDataSource.getCourses();
    _currentSemesterId = await _localDataSource.getCurrentSemesterId();
  }
}
