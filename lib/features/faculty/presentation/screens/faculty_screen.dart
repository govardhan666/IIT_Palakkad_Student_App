import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/faculty.dart';

/// Screen displaying faculty directory
class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedDepartment = 'All';
  String _searchQuery = '';

  // Demo faculty data
  final List<Faculty> _allFaculty = const [
    Faculty(
      id: '1',
      name: 'Dr. Sahely Bhadra',
      department: 'Computer Science and Engineering',
      designation: 'Associate Professor',
      email: 'sahely@iitpkd.ac.in',
      researchAreas: ['Machine Learning', 'Data Mining', 'Deep Learning'],
    ),
    Faculty(
      id: '2',
      name: 'Dr. Deepak Rajendraprasad',
      department: 'Mathematics',
      designation: 'Associate Professor',
      email: 'deepakr@iitpkd.ac.in',
      researchAreas: ['Graph Theory', 'Combinatorics'],
    ),
    Faculty(
      id: '3',
      name: 'Dr. Sandeep Chandran',
      department: 'Computer Science and Engineering',
      designation: 'Assistant Professor',
      email: 'sandeep@iitpkd.ac.in',
      researchAreas: ['Computer Architecture', 'VLSI Design'],
    ),
    Faculty(
      id: '4',
      name: 'Dr. Jasine Babu',
      department: 'Computer Science and Engineering',
      designation: 'Assistant Professor',
      email: 'jasine@iitpkd.ac.in',
      researchAreas: ['Algorithms', 'Graph Algorithms'],
    ),
    Faculty(
      id: '5',
      name: 'Dr. Mrinal K Das',
      department: 'Electrical Engineering',
      designation: 'Associate Professor',
      email: 'mrinal@iitpkd.ac.in',
      researchAreas: ['Power Systems', 'Renewable Energy'],
    ),
    Faculty(
      id: '6',
      name: 'Dr. Raghu Nandan Sengupta',
      department: 'Mechanical Engineering',
      designation: 'Professor',
      email: 'raghu@iitpkd.ac.in',
      researchAreas: ['Fluid Mechanics', 'Heat Transfer'],
    ),
    Faculty(
      id: '7',
      name: 'Dr. Syed Murtuza Baqer',
      department: 'Physics',
      designation: 'Assistant Professor',
      email: 'murtuza@iitpkd.ac.in',
      researchAreas: ['Quantum Physics', 'Optics'],
    ),
    Faculty(
      id: '8',
      name: 'Dr. Priya M',
      department: 'Chemistry',
      designation: 'Assistant Professor',
      email: 'priyam@iitpkd.ac.in',
      researchAreas: ['Organic Chemistry', 'Catalysis'],
    ),
  ];

  List<String> get _departments {
    final depts = _allFaculty.map((f) => f.department).toSet().toList();
    depts.sort();
    return ['All', ...depts];
  }

  List<Faculty> get _filteredFaculty {
    return _allFaculty.where((faculty) {
      final matchesDept = _selectedDepartment == 'All' ||
          faculty.department == _selectedDepartment;
      final matchesSearch = _searchQuery.isEmpty ||
          faculty.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faculty.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faculty.department.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesDept && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty'),
      ),
      body: Column(
        children: [
          // Search and filter
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search faculty...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppColors.scaffoldBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
                const SizedBox(height: 12),
                // Department filter
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _departments.length,
                    itemBuilder: (context, index) {
                      final dept = _departments[index];
                      final isSelected = dept == _selectedDepartment;
                      return Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? 0 : 4,
                          right: 4,
                        ),
                        child: ChoiceChip(
                          label: Text(
                            dept == 'All' ? 'All Departments' : _getShortDept(dept),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() => _selectedDepartment = dept);
                          },
                          selectedColor: AppColors.primary.withOpacity(0.1),
                          labelStyle: TextStyle(
                            color: isSelected ? AppColors.primary : AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Results count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '${_filteredFaculty.length} Faculty Members',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),

          // Faculty list
          Expanded(
            child: _filteredFaculty.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredFaculty.length,
                    itemBuilder: (context, index) {
                      return _buildFacultyCard(_filteredFaculty[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            'No faculty found',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyCard(Faculty faculty) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getDepartmentColor(faculty.department),
          child: Text(
            faculty.initials,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          faculty.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              faculty.designation,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getDepartmentColor(faculty.department).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                faculty.shortDepartment,
                style: TextStyle(
                  color: _getDepartmentColor(faculty.department),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email
                InkWell(
                  onTap: () => _launchEmail(faculty.email),
                  child: Row(
                    children: [
                      Icon(Icons.email, size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        faculty.email,
                        style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),

                // Research areas
                if (faculty.researchAreas.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Research Areas',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: faculty.researchAreas.map((area) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldBackground,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          area,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getShortDept(String dept) {
    final deptMap = {
      'Computer Science and Engineering': 'CSE',
      'Electrical Engineering': 'EE',
      'Mechanical Engineering': 'ME',
      'Civil Engineering': 'CE',
      'Mathematics': 'Math',
      'Physics': 'Physics',
      'Chemistry': 'Chem',
      'Humanities and Social Sciences': 'HSS',
    };
    return deptMap[dept] ?? dept;
  }

  Color _getDepartmentColor(String dept) {
    final colors = {
      'Computer Science and Engineering': const Color(0xFF4285F4),
      'Electrical Engineering': const Color(0xFFFBBC05),
      'Mechanical Engineering': const Color(0xFFEA4335),
      'Civil Engineering': const Color(0xFF34A853),
      'Mathematics': const Color(0xFF9C27B0),
      'Physics': const Color(0xFF00BCD4),
      'Chemistry': const Color(0xFFFF9800),
      'Humanities and Social Sciences': const Color(0xFF795548),
    };
    return colors[dept] ?? AppColors.primary;
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
