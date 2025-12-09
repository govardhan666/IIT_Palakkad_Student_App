import '../../domain/entities/course.dart';

/// Data model for Course with JSON serialization
class CourseModel extends Course {
  const CourseModel({
    required super.code,
    required super.name,
    required super.slot,
    required super.credits,
    required super.instructor,
    super.venue,
  });

  /// Create from JSON map (for storage/API)
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slot: json['slot'] as String? ?? '',
      credits: json['credits'] as int? ?? 0,
      instructor: json['instructor'] as String? ?? '',
      venue: json['venue'] as String?,
    );
  }

  /// Convert to JSON map (for storage)
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'slot': slot,
      'credits': credits,
      'instructor': instructor,
      'venue': venue,
    };
  }

  /// Create from domain entity
  factory CourseModel.fromEntity(Course entity) {
    return CourseModel(
      code: entity.code,
      name: entity.name,
      slot: entity.slot,
      credits: entity.credits,
      instructor: entity.instructor,
      venue: entity.venue,
    );
  }

  /// Create from HTML table row data
  factory CourseModel.fromTableRow({
    required String code,
    required String name,
    required String slot,
    required String credits,
    required String instructor,
    String? venue,
  }) {
    return CourseModel(
      code: code.trim(),
      name: name.trim(),
      slot: slot.trim(),
      credits: int.tryParse(credits.trim()) ?? 0,
      instructor: instructor.trim(),
      venue: venue?.trim(),
    );
  }
}
