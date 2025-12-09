import 'package:flutter/material.dart';
import 'course.dart';

/// Entity representing a single timetable entry (course at a specific time slot)
class TimetableEntry {
  final Course course;
  final String day;
  final String startTime;
  final String endTime;
  final String slotName;
  final bool isLab;
  final Color color;

  const TimetableEntry({
    required this.course,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.slotName,
    this.isLab = false,
    required this.color,
  });

  /// Parse time to minutes from midnight
  int get startMinutes => _parseTime(startTime);
  int get endMinutes => _parseTime(endTime);
  int get durationMinutes => endMinutes - startMinutes;

  int _parseTime(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  /// Display time range
  String get timeRange => '$startTime - $endTime';

  @override
  String toString() =>
      'TimetableEntry(${course.code} on $day $timeRange)';
}

/// Represents the full weekly timetable
class WeeklyTimetable {
  final Map<String, List<TimetableEntry>> entries;

  const WeeklyTimetable({required this.entries});

  /// Get entries for a specific day
  List<TimetableEntry> getEntriesForDay(String day) {
    return entries[day] ?? [];
  }

  /// Get all unique courses in the timetable
  Set<Course> get allCourses {
    final courses = <Course>{};
    for (final dayEntries in entries.values) {
      for (final entry in dayEntries) {
        courses.add(entry.course);
      }
    }
    return courses;
  }

  /// Check if timetable is empty
  bool get isEmpty {
    return entries.values.every((list) => list.isEmpty);
  }

  /// Total number of entries
  int get totalEntries {
    return entries.values.fold(0, (sum, list) => sum + list.length);
  }
}
