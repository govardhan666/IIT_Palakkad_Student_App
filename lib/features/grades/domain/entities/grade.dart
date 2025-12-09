/// Grade entity representing a course grade
class Grade {
  final String courseCode;
  final String courseName;
  final int credits;
  final String grade;
  final double gradePoints;

  const Grade({
    required this.courseCode,
    required this.courseName,
    required this.credits,
    required this.grade,
    required this.gradePoints,
  });

  /// Get color for grade display
  String get gradeColor {
    switch (grade.toUpperCase()) {
      case 'S':
        return 'green';
      case 'A':
        return 'blue';
      case 'B':
        return 'teal';
      case 'C':
        return 'orange';
      case 'D':
        return 'amber';
      case 'E':
        return 'red';
      case 'F':
      case 'U':
        return 'darkRed';
      case 'I':
        return 'grey';
      default:
        return 'grey';
    }
  }

  /// Get grade description
  String get gradeDescription {
    switch (grade.toUpperCase()) {
      case 'S':
        return 'Outstanding';
      case 'A':
        return 'Excellent';
      case 'B':
        return 'Very Good';
      case 'C':
        return 'Good';
      case 'D':
        return 'Average';
      case 'E':
        return 'Below Average';
      case 'F':
        return 'Fail';
      case 'U':
        return 'Unsuccessful';
      case 'I':
        return 'Incomplete';
      case 'W':
        return 'Withdrawn';
      default:
        return '';
    }
  }
}

/// Semester result containing SGPA and course grades
class SemesterResult {
  final String semesterName;
  final String semesterId;
  final double sgpa;
  final int totalCredits;
  final List<Grade> courses;

  const SemesterResult({
    required this.semesterName,
    required this.semesterId,
    required this.sgpa,
    required this.totalCredits,
    required this.courses,
  });

  /// Calculate total credits earned
  int get creditsEarned {
    return courses
        .where((c) => c.grade != 'F' && c.grade != 'U' && c.grade != 'I')
        .fold(0, (sum, c) => sum + c.credits);
  }
}

/// Overall academic record
class AcademicRecord {
  final double cgpa;
  final int totalCredits;
  final int totalCreditsEarned;
  final List<SemesterResult> semesters;

  const AcademicRecord({
    required this.cgpa,
    required this.totalCredits,
    required this.totalCreditsEarned,
    required this.semesters,
  });
}
