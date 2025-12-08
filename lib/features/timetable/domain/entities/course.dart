/// Entity representing a registered course
class Course {
  final String code;
  final String name;
  final String slot;
  final int credits;
  final String instructor;
  final String? venue;

  const Course({
    required this.code,
    required this.name,
    required this.slot,
    required this.credits,
    required this.instructor,
    this.venue,
  });

  /// Parse slot string to get individual slots
  /// e.g., "F+I" -> ["F", "I"]
  List<String> get individualSlots {
    // Remove any bracket content like [Wed]
    final cleanSlot = slot.replaceAll(RegExp(r'\[.*?\]'), '');
    return cleanSlot.split('+').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
  }

  /// Check if this course has a lab component
  bool get hasLab {
    return individualSlots.any((s) => s.startsWith('PA') || s.startsWith('PM'));
  }

  @override
  String toString() => 'Course($code: $name, Slot: $slot)';

  @override
  bool operator ==(Object other) =>
      other is Course && code == other.code && slot == other.slot;

  @override
  int get hashCode => code.hashCode ^ slot.hashCode;
}
