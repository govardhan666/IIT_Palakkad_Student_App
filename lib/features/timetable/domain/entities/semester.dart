/// Entity representing an academic semester
class Semester {
  final String id;
  final String name;
  final String year;
  final String term; // e.g., "Monsoon", "Winter"

  const Semester({
    required this.id,
    required this.name,
    required this.year,
    required this.term,
  });

  /// Display name for the semester
  String get displayName => '$term $year';

  /// Full name with term info
  String get fullName => name.isNotEmpty ? name : '$term Semester $year';

  @override
  String toString() => 'Semester($id: $displayName)';

  @override
  bool operator ==(Object other) => other is Semester && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
