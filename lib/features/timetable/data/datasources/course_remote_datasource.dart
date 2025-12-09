import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import '../../../../core/constants/app_constants.dart';
import '../models/course_model.dart';
import '../models/semester_model.dart';

/// Exception thrown when course fetching fails
class CourseException implements Exception {
  final String message;
  final int? statusCode;

  CourseException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Remote data source for fetching courses from records portal
class CourseRemoteDataSource {
  final Dio _dio;

  CourseRemoteDataSource({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConstants.recordsPortal,
              connectTimeout: AppConstants.apiTimeout,
              receiveTimeout: AppConstants.apiTimeout,
              followRedirects: true,
            ));

  /// Fetch available semesters and courses for the current/selected semester
  Future<({List<SemesterModel> semesters, List<CourseModel> courses, String? currentSemester})>
      fetchCoursesPage(String sessionToken, {String? semesterId}) async {
    try {
      String url = '/course_registration_reports/student_courses';
      if (semesterId != null && semesterId.isNotEmpty) {
        url += '?semester_id=$semesterId';
      }

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Cookie': sessionToken,
          },
        ),
      );

      if (response.statusCode == 200) {
        final htmlContent = response.data.toString();
        return _parseCoursesPage(htmlContent);
      } else if (response.statusCode == 302 || response.statusCode == 401) {
        throw CourseException('Session expired. Please login again.', statusCode: response.statusCode);
      } else {
        throw CourseException('Failed to fetch courses: ${response.statusCode}', statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CourseException('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw CourseException('Unable to connect. Please check your internet connection.');
      } else {
        throw CourseException('Network error: ${e.message}');
      }
    }
  }

  /// Parse the HTML page to extract semesters and courses
  ({List<SemesterModel> semesters, List<CourseModel> courses, String? currentSemester})
      _parseCoursesPage(String htmlContent) {
    final document = html_parser.parse(htmlContent);

    // Parse semesters from dropdown/select element
    final semesters = _parseSemesters(document);

    // Get currently selected semester
    final currentSemester = _getCurrentSemester(document);

    // Parse courses from table
    final courses = _parseCourses(document);

    return (semesters: semesters, courses: courses, currentSemester: currentSemester);
  }

  /// Parse semester options from the page
  List<SemesterModel> _parseSemesters(dynamic document) {
    final semesters = <SemesterModel>[];

    // Look for select element with semester options
    // Common patterns: <select name="semester_id">, <select id="semester">
    final selectElements = document.querySelectorAll('select');

    for (final select in selectElements) {
      final name = select.attributes['name'] ?? select.attributes['id'] ?? '';
      if (name.toLowerCase().contains('semester')) {
        final options = select.querySelectorAll('option');
        for (final option in options) {
          final value = option.attributes['value'] ?? '';
          final text = option.text.trim();
          if (value.isNotEmpty && text.isNotEmpty) {
            semesters.add(SemesterModel.fromOption(value: value, text: text));
          }
        }
        break;
      }
    }

    // If no select found, try to parse from other elements
    if (semesters.isEmpty) {
      // Look for semester links or other patterns
      final links = document.querySelectorAll('a[href*="semester"]');
      for (final link in links) {
        final href = link.attributes['href'] ?? '';
        final text = link.text.trim();
        final match = RegExp(r'semester_id=(\d+)').firstMatch(href);
        if (match != null && text.isNotEmpty) {
          semesters.add(SemesterModel.fromOption(
            value: match.group(1)!,
            text: text,
          ));
        }
      }
    }

    return semesters;
  }

  /// Get the currently selected semester
  String? _getCurrentSemester(dynamic document) {
    final selectElements = document.querySelectorAll('select');
    for (final select in selectElements) {
      final name = select.attributes['name'] ?? select.attributes['id'] ?? '';
      if (name.toLowerCase().contains('semester')) {
        final selectedOption = select.querySelector('option[selected]');
        if (selectedOption != null) {
          return selectedOption.attributes['value'];
        }
      }
    }
    return null;
  }

  /// Parse courses from the HTML table
  List<CourseModel> _parseCourses(dynamic document) {
    final courses = <CourseModel>[];

    // Find the courses table
    // Common patterns: table with headers containing "Course", "Slot", "Credits"
    final tables = document.querySelectorAll('table');

    for (final table in tables) {
      final headerRow = table.querySelector('tr');
      if (headerRow == null) continue;

      final headers = headerRow.querySelectorAll('th, td');
      final headerTexts = headers.map((h) => h.text.toLowerCase().trim()).toList();

      // Check if this looks like a courses table
      if (!_isCourseTable(headerTexts)) continue;

      // Find column indices
      final codeIndex = _findColumnIndex(headerTexts, ['code', 'course code', 'course_code']);
      final nameIndex = _findColumnIndex(headerTexts, ['name', 'course name', 'course_name', 'title']);
      final slotIndex = _findColumnIndex(headerTexts, ['slot', 'slots', 'time slot']);
      final creditsIndex = _findColumnIndex(headerTexts, ['credits', 'credit']);
      final instructorIndex = _findColumnIndex(headerTexts, ['instructor', 'faculty', 'teacher', 'prof']);
      final venueIndex = _findColumnIndex(headerTexts, ['venue', 'room', 'location']);

      // Parse data rows
      final rows = table.querySelectorAll('tr');
      for (int i = 1; i < rows.length; i++) {
        final cells = rows[i].querySelectorAll('td');
        if (cells.isEmpty) continue;

        try {
          final course = CourseModel.fromTableRow(
            code: _getCellText(cells, codeIndex),
            name: _getCellText(cells, nameIndex),
            slot: _getCellText(cells, slotIndex),
            credits: _getCellText(cells, creditsIndex),
            instructor: _getCellText(cells, instructorIndex),
            venue: venueIndex >= 0 ? _getCellText(cells, venueIndex) : null,
          );

          // Only add if we have at least code and name
          if (course.code.isNotEmpty && course.name.isNotEmpty) {
            courses.add(course);
          }
        } catch (e) {
          // Skip malformed rows
          continue;
        }
      }

      // If we found courses, don't check other tables
      if (courses.isNotEmpty) break;
    }

    return courses;
  }

  /// Check if the table headers indicate a courses table
  bool _isCourseTable(List<dynamic> headers) {
    final headerText = headers.join(' ');
    return headerText.contains('course') ||
           headerText.contains('slot') ||
           headerText.contains('credit');
  }

  /// Find column index by possible header names
  int _findColumnIndex(List<dynamic> headers, List<String> possibleNames) {
    for (int i = 0; i < headers.length; i++) {
      final header = headers[i].toString().toLowerCase();
      for (final name in possibleNames) {
        if (header.contains(name)) {
          return i;
        }
      }
    }
    return -1;
  }

  /// Get text from cell at index, handling out of bounds
  String _getCellText(List<dynamic> cells, int index) {
    if (index < 0 || index >= cells.length) return '';
    return cells[index].text.trim();
  }
}
