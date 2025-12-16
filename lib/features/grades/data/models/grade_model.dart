import '../../domain/entities/grade.dart';

/// Grade model with JSON serialization
class GradeModel extends Grade {
  const GradeModel({
    required super.courseCode,
    required super.courseName,
    required super.credits,
    required super.grade,
    required super.gradePoints,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      courseCode: json['courseCode'] as String? ?? '',
      courseName: json['courseName'] as String? ?? '',
      credits: json['credits'] as int? ?? 0,
      grade: json['grade'] as String? ?? '',
      gradePoints: (json['gradePoints'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseCode': courseCode,
      'courseName': courseName,
      'credits': credits,
      'grade': grade,
      'gradePoints': gradePoints,
    };
  }

  factory GradeModel.fromTableRow({
    required String courseCode,
    required String courseName,
    required String credits,
    required String grade,
    required String gradePoints,
  }) {
    return GradeModel(
      courseCode: courseCode.trim(),
      courseName: courseName.trim(),
      credits: int.tryParse(credits.trim()) ?? 0,
      grade: grade.trim().toUpperCase(),
      gradePoints: double.tryParse(gradePoints.trim()) ?? 0.0,
    );
  }
}

/// Semester result model
class SemesterResultModel extends SemesterResult {
  const SemesterResultModel({
    required super.semesterName,
    required super.semesterId,
    required super.sgpa,
    required super.totalCredits,
    required List<GradeModel> super.courses,
  });

  factory SemesterResultModel.fromJson(Map<String, dynamic> json) {
    return SemesterResultModel(
      semesterName: json['semesterName'] as String? ?? '',
      semesterId: json['semesterId'] as String? ?? '',
      sgpa: (json['sgpa'] as num?)?.toDouble() ?? 0.0,
      totalCredits: json['totalCredits'] as int? ?? 0,
      courses: (json['courses'] as List<dynamic>?)
              ?.map((c) => GradeModel.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'semesterName': semesterName,
      'semesterId': semesterId,
      'sgpa': sgpa,
      'totalCredits': totalCredits,
      'courses': courses.map((c) => (c as GradeModel).toJson()).toList(),
    };
  }
}

/// Academic record model
class AcademicRecordModel extends AcademicRecord {
  const AcademicRecordModel({
    required super.cgpa,
    required super.totalCredits,
    required super.totalCreditsEarned,
    required List<SemesterResultModel> super.semesters,
  });

  factory AcademicRecordModel.fromJson(Map<String, dynamic> json) {
    return AcademicRecordModel(
      cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0.0,
      totalCredits: json['totalCredits'] as int? ?? 0,
      totalCreditsEarned: json['totalCreditsEarned'] as int? ?? 0,
      semesters: (json['semesters'] as List<dynamic>?)
              ?.map((s) => SemesterResultModel.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cgpa': cgpa,
      'totalCredits': totalCredits,
      'totalCreditsEarned': totalCreditsEarned,
      'semesters': semesters.map((s) => (s as SemesterResultModel).toJson()).toList(),
    };
  }
}
