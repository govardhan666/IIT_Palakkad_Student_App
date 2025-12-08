import 'package:flutter/foundation.dart';

/// Base class for all course events
@immutable
abstract class CourseEvent {
  const CourseEvent();
}

/// Event to load courses and semesters
class CourseLoadRequested extends CourseEvent {
  const CourseLoadRequested();
}

/// Event to change selected semester
class CourseSemesterChanged extends CourseEvent {
  final String semesterId;

  const CourseSemesterChanged(this.semesterId);
}

/// Event to refresh courses
class CourseRefreshRequested extends CourseEvent {
  const CourseRefreshRequested();
}

/// Event to toggle between timetable and list view
class CourseViewToggled extends CourseEvent {
  const CourseViewToggled();
}

/// Event to clear any error state
class CourseErrorCleared extends CourseEvent {
  const CourseErrorCleared();
}
