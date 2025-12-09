import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/semester.dart';

/// Widget for selecting a semester
class SemesterSelector extends StatelessWidget {
  final List<Semester> semesters;
  final Semester? selectedSemester;
  final ValueChanged<Semester> onSemesterChanged;

  const SemesterSelector({
    super.key,
    required this.semesters,
    this.selectedSemester,
    required this.onSemesterChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (semesters.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Text(
            'Semester:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildDropdown(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedSemester?.id,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
          ),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
          items: semesters.map((semester) {
            return DropdownMenuItem<String>(
              value: semester.id,
              child: Text(
                semester.displayName,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              final semester = semesters.firstWhere((s) => s.id == value);
              onSemesterChanged(semester);
            }
          },
        ),
      ),
    );
  }
}

/// Alternative chip-based semester selector for horizontal scrolling
class SemesterChipSelector extends StatelessWidget {
  final List<Semester> semesters;
  final Semester? selectedSemester;
  final ValueChanged<Semester> onSemesterChanged;

  const SemesterChipSelector({
    super.key,
    required this.semesters,
    this.selectedSemester,
    required this.onSemesterChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (semesters.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: semesters.length,
        itemBuilder: (context, index) {
          final semester = semesters[index];
          final isSelected = semester.id == selectedSemester?.id;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(semester.displayName),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onSemesterChanged(semester);
                }
              },
              selectedColor: AppColors.primary.withOpacity(0.15),
              backgroundColor: AppColors.scaffoldBackground,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.divider,
              ),
            ),
          );
        },
      ),
    );
  }
}
