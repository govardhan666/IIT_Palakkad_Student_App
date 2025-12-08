import 'package:flutter/foundation.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/semester.dart';
import '../../domain/entities/timetable_entry.dart';

/// View mode for the timetable screen
enum TimetableViewMode { grid, list }

/// Base class for all course states
@immutable
abstract class CourseState {
  const CourseState();
}

/// Initial state
class CourseInitial extends CourseState {
  const CourseInitial();
}

/// Loading state
class CourseLoading extends CourseState {
  final String? message;

  const CourseLoading({this.message});
}

/// Loaded state with courses and timetable
class CourseLoaded extends CourseState {
  final List<Course> courses;
  final List<Semester> semesters;
  final Semester? selectedSemester;
  final WeeklyTimetable timetable;
  final TimetableViewMode viewMode;
  final int totalCredits;

  const CourseLoaded({
    required this.courses,
    required this.semesters,
    this.selectedSemester,
    required this.timetable,
    this.viewMode = TimetableViewMode.grid,
    this.totalCredits = 0,
  });

  /// Copy with new values
  CourseLoaded copyWith({
    List<Course>? courses,
    List<Semester>? semesters,
    Semester? selectedSemester,
    WeeklyTimetable? timetable,
    TimetableViewMode? viewMode,
    int? totalCredits,
  }) {
    return CourseLoaded(
      courses: courses ?? this.courses,
      semesters: semesters ?? this.semesters,
      selectedSemester: selectedSemester ?? this.selectedSemester,
      timetable: timetable ?? this.timetable,
      viewMode: viewMode ?? this.viewMode,
      totalCredits: totalCredits ?? this.totalCredits,
    );
  }
}

/// Error state
class CourseError extends CourseState {
  final String message;
  final List<Course>? cachedCourses;

  const CourseError({
    required this.message,
    this.cachedCourses,
  });
}

/// Empty state - no courses registered
class CourseEmpty extends CourseState {
  final List<Semester> semesters;
  final Semester? selectedSemester;

  const CourseEmpty({
    required this.semesters,
    this.selectedSemester,
  });
}
