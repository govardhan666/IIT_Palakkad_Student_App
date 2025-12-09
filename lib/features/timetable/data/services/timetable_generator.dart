import 'package:flutter/material.dart';
import '../../../../core/constants/slot_system.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/timetable_entry.dart';

/// Service for generating timetable from courses
class TimetableGenerator {
  /// Predefined colors for courses
  static const List<Color> _courseColors = [
    Color(0xFF4285F4), // Blue
    Color(0xFF34A853), // Green
    Color(0xFFFBBC05), // Yellow
    Color(0xFFEA4335), // Red
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFF9800), // Orange
    Color(0xFF795548), // Brown
    Color(0xFF607D8B), // Blue Grey
    Color(0xFFE91E63), // Pink
    Color(0xFF3F51B5), // Indigo
    Color(0xFF009688), // Teal
  ];

  /// Generate weekly timetable from list of courses
  static WeeklyTimetable generateTimetable(List<Course> courses) {
    final Map<String, List<TimetableEntry>> entries = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
    };

    // Assign colors to courses
    final courseColors = <String, Color>{};
    for (int i = 0; i < courses.length; i++) {
      courseColors[courses[i].code] = _courseColors[i % _courseColors.length];
    }

    // Process each course
    for (final course in courses) {
      final slots = SlotSystem.parseSlotString(course.slot);
      final color = courseColors[course.code]!;

      for (final slotName in slots) {
        final occurrences = SlotSystem.getSlotOccurrences(slotName);
        final isLab = slotName.startsWith('PA') || slotName.startsWith('PM');

        for (final occurrence in occurrences) {
          final entry = TimetableEntry(
            course: course,
            day: occurrence.day,
            startTime: occurrence.startTime,
            endTime: occurrence.endTime,
            slotName: slotName,
            isLab: isLab,
            color: color,
          );

          entries[occurrence.day]?.add(entry);
        }
      }
    }

    // Sort entries by start time for each day
    for (final day in entries.keys) {
      entries[day]!.sort((a, b) => a.startMinutes.compareTo(b.startMinutes));
    }

    return WeeklyTimetable(entries: entries);
  }

  /// Get all unique time slots for the timetable grid
  static List<GridTimeSlot> getGridTimeSlots(WeeklyTimetable timetable) {
    final slots = <String, GridTimeSlot>{};

    // Collect all unique time slots from entries
    for (final dayEntries in timetable.entries.values) {
      for (final entry in dayEntries) {
        final key = '${entry.startTime}-${entry.endTime}';
        if (!slots.containsKey(key)) {
          slots[key] = GridTimeSlot(
            startTime: entry.startTime,
            endTime: entry.endTime,
          );
        }
      }
    }

    // Add standard time slots if timetable is empty
    if (slots.isEmpty) {
      for (final day in SlotSystem.schedule.values) {
        for (final slot in day) {
          final key = '${slot.startTime}-${slot.endTime}';
          if (!slots.containsKey(key)) {
            slots[key] = GridTimeSlot(
              startTime: slot.startTime,
              endTime: slot.endTime,
            );
          }
        }
      }
    }

    final result = slots.values.toList();
    result.sort((a, b) => a.startMinutes.compareTo(b.startMinutes));
    return result;
  }

  /// Get entry for a specific day and time slot
  static TimetableEntry? getEntryForSlot(
    WeeklyTimetable timetable,
    String day,
    GridTimeSlot timeSlot,
  ) {
    final dayEntries = timetable.entries[day] ?? [];
    for (final entry in dayEntries) {
      // Check if entry overlaps with this time slot
      if (entry.startMinutes <= timeSlot.startMinutes &&
          entry.endMinutes > timeSlot.startMinutes) {
        return entry;
      }
      if (entry.startTime == timeSlot.startTime) {
        return entry;
      }
    }
    return null;
  }

  /// Check if a slot is a continuation of a previous entry (for spanning cells)
  static bool isSlotContinuation(
    WeeklyTimetable timetable,
    String day,
    GridTimeSlot timeSlot,
  ) {
    final dayEntries = timetable.entries[day] ?? [];
    for (final entry in dayEntries) {
      // Check if this time slot is within an entry but not the start
      if (entry.startMinutes < timeSlot.startMinutes &&
          entry.endMinutes > timeSlot.startMinutes) {
        return true;
      }
    }
    return false;
  }

  /// Calculate how many time slots an entry spans
  static int getEntrySpan(TimetableEntry entry, List<GridTimeSlot> allSlots) {
    int span = 1;
    for (final slot in allSlots) {
      if (slot.startMinutes > entry.startMinutes &&
          slot.startMinutes < entry.endMinutes) {
        span++;
      }
    }
    return span;
  }

  /// Get color for a course (consistent across the app)
  static Color getCourseColor(Course course, List<Course> allCourses) {
    final index = allCourses.indexWhere((c) => c.code == course.code);
    if (index >= 0) {
      return _courseColors[index % _courseColors.length];
    }
    return _courseColors[course.code.hashCode % _courseColors.length];
  }
}

/// Represents a time slot in the grid
class GridTimeSlot {
  final String startTime;
  final String endTime;

  const GridTimeSlot({
    required this.startTime,
    required this.endTime,
  });

  int get startMinutes => _parseTime(startTime);
  int get endMinutes => _parseTime(endTime);

  int _parseTime(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  String get displayTime {
    final startHour = int.parse(startTime.split(':')[0]);
    final startMin = startTime.split(':')[1];
    final period = startHour >= 12 ? 'PM' : 'AM';
    final hour12 = startHour > 12 ? startHour - 12 : (startHour == 0 ? 12 : startHour);
    return '$hour12:$startMin $period';
  }

  String get shortTime {
    final startHour = int.parse(startTime.split(':')[0]);
    final period = startHour >= 12 ? 'PM' : 'AM';
    final hour12 = startHour > 12 ? startHour - 12 : (startHour == 0 ? 12 : startHour);
    return '$hour12 $period';
  }

  @override
  bool operator ==(Object other) =>
      other is GridTimeSlot && startTime == other.startTime && endTime == other.endTime;

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}
