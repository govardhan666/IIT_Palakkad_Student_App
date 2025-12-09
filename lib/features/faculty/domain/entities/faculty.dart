/// Faculty entity
class Faculty {
  final String id;
  final String name;
  final String department;
  final String designation;
  final String email;
  final String? phone;
  final String? profileImageUrl;
  final List<String> researchAreas;
  final String? website;

  const Faculty({
    required this.id,
    required this.name,
    required this.department,
    required this.designation,
    required this.email,
    this.phone,
    this.profileImageUrl,
    this.researchAreas = const [],
    this.website,
  });

  /// Get initials for avatar
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  /// Get short department name
  String get shortDepartment {
    final deptMap = {
      'Computer Science and Engineering': 'CSE',
      'Electrical Engineering': 'EE',
      'Mechanical Engineering': 'ME',
      'Civil Engineering': 'CE',
      'Mathematics': 'MA',
      'Physics': 'PH',
      'Chemistry': 'CY',
      'Humanities and Social Sciences': 'HSS',
      'Data Science': 'DS',
    };
    return deptMap[department] ?? department;
  }
}
