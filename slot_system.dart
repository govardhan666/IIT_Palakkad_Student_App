/// IIT Palakkad Slot System Constants
/// Source: https://cse.iitpkd.ac.in/timetable/
/// 
/// This file contains the complete slot-to-time mapping for generating
/// student timetables from course registration data.

class SlotSystem {
  SlotSystem._();

  /// Days of the week
  static const List<String> days = [
    'Monday',
    'Tuesday', 
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  /// Complete schedule mapping: day -> list of (time, slot)
  static const Map<String, List<SlotTime>> schedule = {
    'Monday': [
      SlotTime('08:00', '08:50', 'A'),
      SlotTime('09:00', '09:50', 'B'),
      SlotTime('10:00', '10:50', 'C'),
      SlotTime('11:00', '11:50', 'D'),
      SlotTime('12:05', '12:55', 'H'),
      SlotTime('14:00', '15:15', 'I'),
      SlotTime('15:30', '16:45', 'J'),
      SlotTime('17:10', '18:00', 'R1'),
    ],
    'Tuesday': [
      SlotTime('08:00', '08:50', 'B'),
      SlotTime('09:00', '10:15', 'F'),
      SlotTime('10:30', '11:45', 'G'),
      SlotTime('12:00', '12:50', 'M'),
      SlotTime('14:00', '15:15', 'K'),
      SlotTime('15:30', '16:45', 'L'),
      SlotTime('17:10', '18:00', 'R2'),
    ],
    'Wednesday': [
      SlotTime('08:00', '08:50', 'C'),
      SlotTime('09:00', '09:50', 'D'),
      SlotTime('10:00', '10:50', 'E'),
      SlotTime('11:00', '11:50', 'A'),
      SlotTime('12:05', '12:55', 'H'),
      SlotTime('14:00', '14:50', 'Q'),
      SlotTime('15:00', '15:50', 'R3'),
      SlotTime('16:00', '16:50', 'CMN-A'),
      SlotTime('17:00', '17:50', 'CMN-B'),
    ],
    'Thursday': [
      SlotTime('08:00', '08:50', 'D'),
      SlotTime('09:00', '10:15', 'G'),
      SlotTime('10:30', '11:45', 'F'),
      SlotTime('12:00', '12:50', 'M'),
      SlotTime('14:00', '15:15', 'L'),
      SlotTime('15:30', '16:45', 'K'),
      SlotTime('17:10', '18:00', 'R4'),
    ],
    'Friday': [
      SlotTime('08:00', '08:50', 'E'),
      SlotTime('09:00', '09:50', 'A'),
      SlotTime('10:00', '10:50', 'B'),
      SlotTime('11:00', '11:50', 'C'),
      SlotTime('12:05', '12:55', 'H'),
      SlotTime('14:00', '15:15', 'J'),
      SlotTime('15:30', '16:45', 'I'),
      SlotTime('17:10', '18:00', 'R5'),
    ],
  };

  /// Lab slot definitions
  static const Map<String, LabSlot> labSlots = {
    'PM1': LabSlot('Monday', '09:00', '11:45', 'Morning Lab'),
    'PM2': LabSlot('Tuesday', '09:00', '11:45', 'Morning Lab'),
    'PM3': LabSlot('Wednesday', '09:00', '11:45', 'Morning Lab'),
    'PM4': LabSlot('Thursday', '09:00', '11:45', 'Morning Lab'),
    'PM5': LabSlot('Friday', '09:00', '11:45', 'Morning Lab'),
    'PA1': LabSlot('Monday', '14:00', '16:45', 'Afternoon Lab'),
    'PA2': LabSlot('Tuesday', '14:00', '16:45', 'Afternoon Lab'),
    'PA3': LabSlot('Wednesday', '14:00', '15:50', 'Afternoon Lab'),
    'PA4': LabSlot('Thursday', '14:00', '16:45', 'Afternoon Lab'),
    'PA5': LabSlot('Friday', '14:00', '16:45', 'Afternoon Lab'),
  };

  /// Slot credit information
  static const Map<String, SlotInfo> slotInfo = {
    'A': SlotInfo(credits: 3, sessionsPerWeek: 3, durationMins: 50),
    'B': SlotInfo(credits: 3, sessionsPerWeek: 3, durationMins: 50),
    'C': SlotInfo(credits: 3, sessionsPerWeek: 3, durationMins: 50),
    'D': SlotInfo(credits: 3, sessionsPerWeek: 3, durationMins: 50),
    'H': SlotInfo(credits: 3, sessionsPerWeek: 3, durationMins: 50),
    'E': SlotInfo(credits: 2, sessionsPerWeek: 2, durationMins: 50),
    'M': SlotInfo(credits: 2, sessionsPerWeek: 2, durationMins: 50),
    'F': SlotInfo(credits: 3, sessionsPerWeek: 2, durationMins: 75),
    'G': SlotInfo(credits: 3, sessionsPerWeek: 2, durationMins: 75),
    'I': SlotInfo(credits: 3, sessionsPerWeek: 2, durationMins: 75),
    'J': SlotInfo(credits: 3, sessionsPerWeek: 2, durationMins: 75),
    'K': SlotInfo(credits: 3, sessionsPerWeek: 2, durationMins: 75),
    'L': SlotInfo(credits: 3, sessionsPerWeek: 2, durationMins: 75),
    'Q': SlotInfo(credits: 1, sessionsPerWeek: 1, durationMins: 50),
    'R1': SlotInfo(credits: 1, sessionsPerWeek: 1, durationMins: 50),
    'R2': SlotInfo(credits: 1, sessionsPerWeek: 1, durationMins: 50),
    'R3': SlotInfo(credits: 1, sessionsPerWeek: 1, durationMins: 50),
    'R4': SlotInfo(credits: 1, sessionsPerWeek: 1, durationMins: 50),
    'R5': SlotInfo(credits: 1, sessionsPerWeek: 1, durationMins: 50),
  };

  /// Get all occurrences of a slot in the week
  /// Returns list of (day, startTime, endTime)
  static List<SlotOccurrence> getSlotOccurrences(String slot) {
    final occurrences = <SlotOccurrence>[];
    
    // Check if it's a lab slot
    if (labSlots.containsKey(slot)) {
      final lab = labSlots[slot]!;
      occurrences.add(SlotOccurrence(lab.day, lab.startTime, lab.endTime));
      return occurrences;
    }
    
    // Check regular slots
    for (final entry in schedule.entries) {
      final day = entry.key;
      for (final slotTime in entry.value) {
        if (slotTime.slot == slot) {
          occurrences.add(SlotOccurrence(day, slotTime.startTime, slotTime.endTime));
        }
      }
    }
    
    return occurrences;
  }

  /// Parse compound slot strings like "A+E[Wed]+R4" or "F+I[Fri]"
  static List<String> parseSlotString(String slotString) {
    // Remove brackets and their content for now, handle them separately
    final cleanSlot = slotString.replaceAll(RegExp(r'\[.*?\]'), '');
    return cleanSlot.split('+').map((s) => s.trim()).toList();
  }
}

/// Represents a time slot occurrence
class SlotTime {
  final String startTime;
  final String endTime;
  final String slot;

  const SlotTime(this.startTime, this.endTime, this.slot);
}

/// Represents a lab slot
class LabSlot {
  final String day;
  final String startTime;
  final String endTime;
  final String type;

  const LabSlot(this.day, this.startTime, this.endTime, this.type);
}

/// Slot credit and session information
class SlotInfo {
  final int credits;
  final int sessionsPerWeek;
  final int durationMins;

  const SlotInfo({
    required this.credits,
    required this.sessionsPerWeek,
    required this.durationMins,
  });
}

/// Represents when a slot occurs
class SlotOccurrence {
  final String day;
  final String startTime;
  final String endTime;

  const SlotOccurrence(this.day, this.startTime, this.endTime);
  
  @override
  String toString() => '$day $startTime-$endTime';
}


// ============================================================
// EXAMPLE USAGE:
// ============================================================
// 
// // Get all times when slot "A" occurs:
// final aTimes = SlotSystem.getSlotOccurrences('A');
// // Returns: [Monday 08:00-08:50, Wednesday 11:00-11:50, Friday 09:00-09:50]
//
// // Get lab slot info:
// final pa2 = SlotSystem.labSlots['PA2'];
// // Returns: Tuesday 14:00-16:45
//
// // Parse compound slot like "C+Q+R3":
// final slots = SlotSystem.parseSlotString('C+Q+R3');
// // Returns: ['C', 'Q', 'R3']
//
// // Get credit info:
// final info = SlotSystem.slotInfo['F'];
// // Returns: 3 credits, 2 sessions/week, 75 mins each
// ============================================================
