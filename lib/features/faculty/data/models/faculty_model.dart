import '../../domain/entities/faculty.dart';

/// Faculty model with JSON serialization
class FacultyModel extends Faculty {
  const FacultyModel({
    required super.id,
    required super.name,
    required super.department,
    required super.designation,
    required super.email,
    super.phone,
    super.profileImageUrl,
    super.researchAreas,
    super.website,
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      department: json['department'] as String? ?? '',
      designation: json['designation'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      researchAreas: (json['researchAreas'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      website: json['website'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'designation': designation,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'researchAreas': researchAreas,
      'website': website,
    };
  }
}
