import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../data/services/timetable_generator.dart';
import '../../domain/entities/semester.dart';
import '../../domain/repositories/course_repository.dart';
import 'course_event.dart';
import 'course_state.dart';

/// BLoC for managing course and timetable state
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository _courseRepository;

  CourseBloc({required CourseRepository courseRepository})
      : _courseRepository = courseRepository,
        super(const CourseInitial()) {
    on<CourseLoadRequested>(_onCourseLoadRequested);
    on<CourseSemesterChanged>(_onCourseSemesterChanged);
    on<CourseRefreshRequested>(_onCourseRefreshRequested);
    on<CourseViewToggled>(_onCourseViewToggled);
    on<CourseErrorCleared>(_onCourseErrorCleared);
  }

  /// Handle initial course load
  Future<void> _onCourseLoadRequested(
    CourseLoadRequested event,
    Emitter<CourseState> emit,
  ) async {
    emit(const CourseLoading(message: 'Loading courses...'));

    // First try to load from cache for faster UX
    final cachedCourses = await _courseRepository.getCachedCourses();
    if (cachedCourses != null && cachedCourses.isNotEmpty) {
      final timetable = TimetableGenerator.generateTimetable(cachedCourses);
      final totalCredits = cachedCourses.fold(0, (sum, c) => sum + c.credits);

      emit(CourseLoaded(
        courses: cachedCourses,
        semesters: [],
        timetable: timetable,
        totalCredits: totalCredits,
      ));
    }

    // Then fetch fresh data from server
    final result = await _courseRepository.fetchSemesters();

    if (result.success) {
      final courses = result.courses ?? [];
      final semesters = result.semesters ?? [];

      if (courses.isEmpty) {
        emit(CourseEmpty(
          semesters: semesters,
          selectedSemester: semesters.isNotEmpty ? semesters.first : null,
        ));
        return;
      }

      final timetable = TimetableGenerator.generateTimetable(courses);
      final totalCredits = courses.fold(0, (sum, c) => sum + c.credits);

      // Get current semester
      Semester? selectedSemester;
      if (_courseRepository is CourseRepositoryImpl) {
        final repo = _courseRepository as CourseRepositoryImpl;
        final currentId = repo.currentSemesterId;
        if (currentId != null) {
          selectedSemester = semesters.cast<Semester?>().firstWhere(
            (s) => s?.id == currentId,
            orElse: () => semesters.isNotEmpty ? semesters.first : null,
          );
        }
      }

      emit(CourseLoaded(
        courses: courses,
        semesters: semesters,
        selectedSemester: selectedSemester ?? (semesters.isNotEmpty ? semesters.first : null),
        timetable: timetable,
        totalCredits: totalCredits,
      ));
    } else {
      emit(CourseError(
        message: result.errorMessage ?? 'Failed to load courses',
        cachedCourses: cachedCourses,
      ));
    }
  }

  /// Handle semester change
  Future<void> _onCourseSemesterChanged(
    CourseSemesterChanged event,
    Emitter<CourseState> emit,
  ) async {
    final currentState = state;
    List<Semester> semesters = [];

    if (currentState is CourseLoaded) {
      semesters = currentState.semesters;
    } else if (currentState is CourseEmpty) {
      semesters = currentState.semesters;
    }

    emit(const CourseLoading(message: 'Loading semester courses...'));

    final result = await _courseRepository.fetchCourses(event.semesterId);

    if (result.success) {
      final courses = result.courses ?? [];

      if (courses.isEmpty) {
        final selectedSemester = semesters.cast<Semester?>().firstWhere(
          (s) => s?.id == event.semesterId,
          orElse: () => null,
        );
        emit(CourseEmpty(
          semesters: semesters,
          selectedSemester: selectedSemester,
        ));
        return;
      }

      final timetable = TimetableGenerator.generateTimetable(courses);
      final totalCredits = courses.fold(0, (sum, c) => sum + c.credits);
      final selectedSemester = semesters.cast<Semester?>().firstWhere(
        (s) => s?.id == event.semesterId,
        orElse: () => null,
      );

      emit(CourseLoaded(
        courses: courses,
        semesters: semesters,
        selectedSemester: selectedSemester,
        timetable: timetable,
        totalCredits: totalCredits,
      ));
    } else {
      emit(CourseError(message: result.errorMessage ?? 'Failed to load courses'));
    }
  }

  /// Handle refresh request
  Future<void> _onCourseRefreshRequested(
    CourseRefreshRequested event,
    Emitter<CourseState> emit,
  ) async {
    // Clear cache and reload
    await _courseRepository.clearCache();
    add(const CourseLoadRequested());
  }

  /// Handle view mode toggle
  void _onCourseViewToggled(
    CourseViewToggled event,
    Emitter<CourseState> emit,
  ) {
    if (state is CourseLoaded) {
      final currentState = state as CourseLoaded;
      final newMode = currentState.viewMode == TimetableViewMode.grid
          ? TimetableViewMode.list
          : TimetableViewMode.grid;
      emit(currentState.copyWith(viewMode: newMode));
    }
  }

  /// Clear error state
  void _onCourseErrorCleared(
    CourseErrorCleared event,
    Emitter<CourseState> emit,
  ) {
    if (state is CourseError) {
      emit(const CourseInitial());
    }
  }
}
