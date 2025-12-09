import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/grade.dart';

/// Screen displaying student grades/results
class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  bool _isLoading = false;
  String? _error;
  AcademicRecord? _record;

  // Demo data for display
  final AcademicRecord _demoRecord = const AcademicRecord(
    cgpa: 8.54,
    totalCredits: 120,
    totalCreditsEarned: 118,
    semesters: [
      SemesterResult(
        semesterName: 'Monsoon 2024',
        semesterId: '1',
        sgpa: 8.75,
        totalCredits: 24,
        courses: [
          Grade(courseCode: 'CS2001', courseName: 'Data Structures and Algorithms', credits: 4, grade: 'A', gradePoints: 9.0),
          Grade(courseCode: 'CS2002', courseName: 'Computer Organization', credits: 4, grade: 'S', gradePoints: 10.0),
          Grade(courseCode: 'MA2001', courseName: 'Probability and Statistics', credits: 4, grade: 'B', gradePoints: 8.0),
          Grade(courseCode: 'HS2001', courseName: 'Economics', credits: 3, grade: 'A', gradePoints: 9.0),
          Grade(courseCode: 'CS2003', courseName: 'Database Systems', credits: 4, grade: 'A', gradePoints: 9.0),
          Grade(courseCode: 'CS2004L', courseName: 'DSA Lab', credits: 2, grade: 'S', gradePoints: 10.0),
        ],
      ),
      SemesterResult(
        semesterName: 'Winter 2024',
        semesterId: '2',
        sgpa: 8.33,
        totalCredits: 22,
        courses: [
          Grade(courseCode: 'CS3001', courseName: 'Operating Systems', credits: 4, grade: 'B', gradePoints: 8.0),
          Grade(courseCode: 'CS3002', courseName: 'Computer Networks', credits: 4, grade: 'A', gradePoints: 9.0),
          Grade(courseCode: 'CS3003', courseName: 'Theory of Computation', credits: 3, grade: 'B', gradePoints: 8.0),
          Grade(courseCode: 'CS3004', courseName: 'Software Engineering', credits: 3, grade: 'A', gradePoints: 9.0),
          Grade(courseCode: 'CS3005L', courseName: 'OS Lab', credits: 2, grade: 'A', gradePoints: 9.0),
        ],
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _loadGrades();
  }

  Future<void> _loadGrades() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Simulate loading
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoading = false;
      _record = _demoRecord; // Using demo data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadGrades,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildError()
              : _record != null
                  ? _buildContent()
                  : _buildEmpty(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadGrades,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Text('No grades available'),
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: _loadGrades,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // CGPA Card
          _buildCGPACard(),
          const SizedBox(height: 20),

          // Semester Results
          Text(
            'Semester Results',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          // Expandable semester list
          ..._record!.semesters.map((semester) => _buildSemesterCard(semester)),
        ],
      ),
    );
  }

  Widget _buildCGPACard() {
    return Card(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CGPA',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _record!.cgpa.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.school,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Total Credits',
                    _record!.totalCredits.toString(),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white24,
                ),
                Expanded(
                  child: _buildStatItem(
                    'Credits Earned',
                    _record!.totalCreditsEarned.toString(),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white24,
                ),
                Expanded(
                  child: _buildStatItem(
                    'Semesters',
                    _record!.semesters.length.toString(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSemesterCard(SemesterResult semester) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          semester.semesterName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            _buildSGPABadge(semester.sgpa),
            const SizedBox(width: 8),
            Text(
              '${semester.totalCredits} Credits',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        children: [
          const Divider(height: 1),
          ...semester.courses.map((course) => _buildCourseRow(course)),
        ],
      ),
    );
  }

  Widget _buildSGPABadge(double sgpa) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getSGPAColor(sgpa).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'SGPA: ${sgpa.toStringAsFixed(2)}',
        style: TextStyle(
          color: _getSGPAColor(sgpa),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getSGPAColor(double sgpa) {
    if (sgpa >= 9.0) return AppColors.success;
    if (sgpa >= 8.0) return const Color(0xFF4285F4);
    if (sgpa >= 7.0) return AppColors.accent;
    if (sgpa >= 6.0) return Colors.orange;
    return AppColors.error;
  }

  Widget _buildCourseRow(Grade course) {
    return ListTile(
      dense: true,
      leading: _buildGradeBadge(course.grade),
      title: Text(
        course.courseCode,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Text(
        course.courseName,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${course.credits} Cr',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          Text(
            'GP: ${course.gradePoints.toStringAsFixed(1)}',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeBadge(String grade) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: _getGradeColor(grade).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getGradeColor(grade).withOpacity(0.3),
        ),
      ),
      child: Center(
        child: Text(
          grade,
          style: TextStyle(
            color: _getGradeColor(grade),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'S':
        return const Color(0xFF10B981);
      case 'A':
        return const Color(0xFF3B82F6);
      case 'B':
        return const Color(0xFF14B8A6);
      case 'C':
        return const Color(0xFFF59E0B);
      case 'D':
        return const Color(0xFFF97316);
      case 'E':
        return const Color(0xFFEF4444);
      case 'F':
      case 'U':
        return const Color(0xFFDC2626);
      default:
        return AppColors.textSecondary;
    }
  }
}
