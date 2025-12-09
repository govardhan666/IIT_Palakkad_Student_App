import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import '../../../../core/constants/app_constants.dart';
import '../models/grade_model.dart';

/// Remote datasource for fetching grades from records portal
class GradesRemoteDataSource {
  final Dio _dio;

  GradesRemoteDataSource({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConstants.recordsPortal,
              connectTimeout: AppConstants.apiTimeout,
              receiveTimeout: AppConstants.apiTimeout,
              followRedirects: true,
            ));

  /// Fetch academic record from grades portal
  Future<AcademicRecordModel> fetchGrades(String sessionToken) async {
    try {
      final response = await _dio.get(
        '/grades/view_results',
        options: Options(
          headers: {'Cookie': sessionToken},
        ),
      );

      if (response.statusCode == 200) {
        return _parseGradesPage(response.data.toString());
      } else {
        throw Exception('Failed to fetch grades: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      }
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Parse grades HTML page
  AcademicRecordModel _parseGradesPage(String htmlContent) {
    final document = html_parser.parse(htmlContent);

    // Parse CGPA
    double cgpa = 0.0;
    int totalCredits = 0;
    int totalCreditsEarned = 0;

    // Look for CGPA in various formats
    final cgpaElements = document.querySelectorAll('*');
    for (final element in cgpaElements) {
      final text = element.text.toLowerCase();
      if (text.contains('cgpa') || text.contains('cumulative')) {
        final match = RegExp(r'(\d+\.?\d*)').firstMatch(element.text);
        if (match != null) {
          final value = double.tryParse(match.group(1)!) ?? 0.0;
          if (value > 0 && value <= 10) {
            cgpa = value;
            break;
          }
        }
      }
    }

    // Parse semester results
    final semesters = <SemesterResultModel>[];
    final tables = document.querySelectorAll('table');

    for (final table in tables) {
      final result = _parseSemesterTable(table);
      if (result != null) {
        semesters.add(result);
        totalCredits += result.totalCredits;
        totalCreditsEarned += result.creditsEarned;
      }
    }

    // If no CGPA found, calculate from semesters
    if (cgpa == 0 && semesters.isNotEmpty) {
      double totalPoints = 0;
      int totalCreds = 0;
      for (final sem in semesters) {
        for (final course in sem.courses) {
          totalPoints += course.gradePoints * course.credits;
          totalCreds += course.credits;
        }
      }
      if (totalCreds > 0) {
        cgpa = totalPoints / totalCreds;
      }
    }

    return AcademicRecordModel(
      cgpa: cgpa,
      totalCredits: totalCredits,
      totalCreditsEarned: totalCreditsEarned,
      semesters: semesters,
    );
  }

  /// Parse a semester table
  SemesterResultModel? _parseSemesterTable(dynamic table) {
    final rows = table.querySelectorAll('tr');
    if (rows.isEmpty) return null;

    // Check if this is a grades table
    final headerRow = rows.first;
    final headers = headerRow.querySelectorAll('th, td');
    final headerTexts = headers.map((h) => h.text.toLowerCase().trim()).toList();

    // Look for course/grade related headers
    final hasCodeColumn = headerTexts.any((h) =>
        h.contains('code') || h.contains('course'));
    final hasGradeColumn = headerTexts.any((h) =>
        h.contains('grade') || h.contains('letter'));

    if (!hasCodeColumn && !hasGradeColumn) return null;

    // Find column indices
    final codeIndex = _findColumnIndex(headerTexts, ['code', 'course code', 'course_code']);
    final nameIndex = _findColumnIndex(headerTexts, ['name', 'course name', 'title', 'course title']);
    final creditsIndex = _findColumnIndex(headerTexts, ['credits', 'credit', 'cr']);
    final gradeIndex = _findColumnIndex(headerTexts, ['grade', 'letter', 'letter grade']);
    final pointsIndex = _findColumnIndex(headerTexts, ['points', 'grade points', 'gp']);

    // Parse courses
    final courses = <GradeModel>[];
    String semesterName = '';
    double sgpa = 0.0;
    int totalCredits = 0;

    for (int i = 1; i < rows.length; i++) {
      final cells = rows[i].querySelectorAll('td');
      if (cells.isEmpty) continue;

      // Check for semester name row
      final rowText = rows[i].text.toLowerCase();
      if (rowText.contains('semester') || rowText.contains('term')) {
        final semMatch = RegExp(r'(semester\s*\d+|monsoon|winter|spring|fall)\s*(\d{4})?', caseSensitive: false)
            .firstMatch(rows[i].text);
        if (semMatch != null) {
          semesterName = semMatch.group(0)?.trim() ?? '';
        }
        continue;
      }

      // Check for SGPA row
      if (rowText.contains('sgpa') || rowText.contains('spi')) {
        final sgpaMatch = RegExp(r'(\d+\.?\d*)').firstMatch(rows[i].text);
        if (sgpaMatch != null) {
          sgpa = double.tryParse(sgpaMatch.group(1)!) ?? 0.0;
        }
        continue;
      }

      // Parse course row
      try {
        final course = GradeModel.fromTableRow(
          courseCode: _getCellText(cells, codeIndex),
          courseName: _getCellText(cells, nameIndex),
          credits: _getCellText(cells, creditsIndex),
          grade: _getCellText(cells, gradeIndex),
          gradePoints: _getCellText(cells, pointsIndex),
        );

        if (course.courseCode.isNotEmpty && course.grade.isNotEmpty) {
          courses.add(course);
          totalCredits += course.credits;
        }
      } catch (e) {
        continue;
      }
    }

    if (courses.isEmpty) return null;

    // Calculate SGPA if not found
    if (sgpa == 0 && courses.isNotEmpty) {
      double totalPoints = 0;
      int totalCreds = 0;
      for (final course in courses) {
        totalPoints += course.gradePoints * course.credits;
        totalCreds += course.credits;
      }
      if (totalCreds > 0) {
        sgpa = totalPoints / totalCreds;
      }
    }

    return SemesterResultModel(
      semesterName: semesterName.isNotEmpty ? semesterName : 'Semester ${courses.length}',
      semesterId: DateTime.now().millisecondsSinceEpoch.toString(),
      sgpa: sgpa,
      totalCredits: totalCredits,
      courses: courses,
    );
  }

  int _findColumnIndex(List<dynamic> headers, List<String> possibleNames) {
    for (int i = 0; i < headers.length; i++) {
      final header = headers[i].toString().toLowerCase();
      for (final name in possibleNames) {
        if (header.contains(name)) return i;
      }
    }
    return -1;
  }

  String _getCellText(List<dynamic> cells, int index) {
    if (index < 0 || index >= cells.length) return '';
    return cells[index].text.trim();
  }
}
