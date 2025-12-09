import '../../domain/entities/semester.dart';

/// Data model for Semester with JSON serialization
class SemesterModel extends Semester {
  const SemesterModel({
    required super.id,
    required super.name,
    required super.year,
    required super.term,
  });

  /// Create from JSON map
  factory SemesterModel.fromJson(Map<String, dynamic> json) {
    return SemesterModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      year: json['year'] as String? ?? '',
      term: json['term'] as String? ?? '',
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'year': year,
      'term': term,
    };
  }

  /// Create from HTML select option
  /// Parses strings like "Monsoon 2024-25" or "Winter 2023-24"
  factory SemesterModel.fromOption({
    required String value,
    required String text,
  }) {
    final parts = text.trim().split(' ');
    String term = '';
    String year = '';

    if (parts.isNotEmpty) {
      term = parts[0]; // "Monsoon" or "Winter"
    }
    if (parts.length > 1) {
      year = parts.sublist(1).join(' '); // "2024-25"
    }

    return SemesterModel(
      id: value.trim(),
      name: text.trim(),
      year: year,
      term: term,
    );
  }

  /// Create from domain entity
  factory SemesterModel.fromEntity(Semester entity) {
    return SemesterModel(
      id: entity.id,
      name: entity.name,
      year: entity.year,
      term: entity.term,
    );
  }
}
