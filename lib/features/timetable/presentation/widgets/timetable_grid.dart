import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/services/timetable_generator.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/timetable_entry.dart';

/// Widget displaying the weekly timetable grid
class TimetableGrid extends StatelessWidget {
  final WeeklyTimetable timetable;
  final List<Course> courses;

  const TimetableGrid({
    super.key,
    required this.timetable,
    required this.courses,
  });

  static const List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  static const List<String> _fullDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

  @override
  Widget build(BuildContext context) {
    final timeSlots = TimetableGenerator.getGridTimeSlots(timetable);

    if (timeSlots.isEmpty) {
      return const Center(
        child: Text('No classes scheduled'),
      );
    }

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildGrid(context, timeSlots),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<GridTimeSlot> timeSlots) {
    const double timeColumnWidth = 60;
    const double dayColumnWidth = 100;
    const double rowHeight = 60;
    const double headerHeight = 40;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with days
        Row(
          children: [
            // Empty corner cell
            Container(
              width: timeColumnWidth,
              height: headerHeight,
              decoration: BoxDecoration(
                color: AppColors.primary,
                border: Border.all(color: AppColors.divider, width: 0.5),
              ),
            ),
            // Day headers
            ..._days.map((day) => Container(
                  width: dayColumnWidth,
                  height: headerHeight,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    border: Border.all(color: AppColors.divider, width: 0.5),
                  ),
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )),
          ],
        ),
        // Time slot rows
        ...timeSlots.map((slot) => _buildRow(
              context,
              slot,
              timeColumnWidth,
              dayColumnWidth,
              rowHeight,
            )),
      ],
    );
  }

  Widget _buildRow(
    BuildContext context,
    GridTimeSlot timeSlot,
    double timeColumnWidth,
    double dayColumnWidth,
    double rowHeight,
  ) {
    return Row(
      children: [
        // Time column
        Container(
          width: timeColumnWidth,
          height: rowHeight,
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            border: Border.all(color: AppColors.divider, width: 0.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Center(
            child: Text(
              timeSlot.displayTime,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // Day cells
        ..._fullDays.map((day) {
          final entry = TimetableGenerator.getEntryForSlot(timetable, day, timeSlot);
          final isContinuation = TimetableGenerator.isSlotContinuation(timetable, day, timeSlot);

          if (isContinuation) {
            // This slot is part of a longer class, don't render
            return const SizedBox.shrink();
          }

          if (entry != null) {
            final span = TimetableGenerator.getEntrySpan(entry, TimetableGenerator.getGridTimeSlots(timetable));
            return _buildCourseCell(
              context,
              entry,
              dayColumnWidth,
              rowHeight * span,
            );
          }

          return _buildEmptyCell(dayColumnWidth, rowHeight);
        }),
      ],
    );
  }

  Widget _buildEmptyCell(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
    );
  }

  Widget _buildCourseCell(
    BuildContext context,
    TimetableEntry entry,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () => _showCourseDetails(context, entry),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: entry.color.withOpacity(0.15),
          border: Border.all(color: entry.color, width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              entry.course.code,
              style: TextStyle(
                color: entry.color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (height > 50) ...[
              const SizedBox(height: 2),
              Text(
                entry.slotName,
                style: TextStyle(
                  color: entry.color.withOpacity(0.8),
                  fontSize: 9,
                ),
              ),
            ],
            if (height > 70 && entry.course.venue != null) ...[
              const SizedBox(height: 2),
              Text(
                entry.course.venue!,
                style: TextStyle(
                  color: entry.color.withOpacity(0.7),
                  fontSize: 8,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showCourseDetails(BuildContext context, TimetableEntry entry) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with color indicator
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: entry.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.course.code,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (entry.isLab)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'LAB',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              entry.course.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.access_time, 'Time', entry.timeRange),
            _buildDetailRow(Icons.calendar_today, 'Day', entry.day),
            _buildDetailRow(Icons.grid_view, 'Slot', entry.slotName),
            _buildDetailRow(Icons.person, 'Instructor', entry.course.instructor),
            _buildDetailRow(Icons.star, 'Credits', '${entry.course.credits}'),
            if (entry.course.venue != null)
              _buildDetailRow(Icons.location_on, 'Venue', entry.course.venue!),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
