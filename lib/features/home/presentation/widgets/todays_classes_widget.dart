import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../timetable/domain/entities/timetable_entry.dart';
import '../../../timetable/presentation/bloc/course_bloc.dart';
import '../../../timetable/presentation/bloc/course_state.dart';

/// Widget showing today's classes
class TodaysClassesWidget extends StatelessWidget {
  const TodaysClassesWidget({super.key});

  static const List<String> _dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String get _todayName {
    final now = DateTime.now();
    return _dayNames[now.weekday - 1];
  }

  bool get _isWeekend {
    final now = DateTime.now();
    return now.weekday > 5;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "Today's Classes",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => context.go('/timetable'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoaded) {
              return _buildClassesList(context, state.timetable);
            } else if (state is CourseLoading) {
              return _buildLoading();
            } else if (state is CourseError) {
              return _buildError(state.message);
            } else {
              return _buildEmpty();
            }
          },
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Card(
      child: SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Login to see your classes',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.event_busy, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'No courses loaded yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassesList(BuildContext context, WeeklyTimetable timetable) {
    if (_isWeekend) {
      return _buildWeekendCard(context);
    }

    final todayClasses = timetable.getEntriesForDay(_todayName);

    if (todayClasses.isEmpty) {
      return _buildNoClassesCard(context);
    }

    // Sort by start time
    todayClasses.sort((a, b) => a.startMinutes.compareTo(b.startMinutes));

    // Get current and upcoming classes
    final now = DateTime.now();
    final currentMinutes = now.hour * 60 + now.minute;

    TimetableEntry? currentClass;
    TimetableEntry? nextClass;
    final upcomingClasses = <TimetableEntry>[];

    for (final entry in todayClasses) {
      if (entry.startMinutes <= currentMinutes && entry.endMinutes > currentMinutes) {
        currentClass = entry;
      } else if (entry.startMinutes > currentMinutes) {
        if (nextClass == null) {
          nextClass = entry;
        }
        upcomingClasses.add(entry);
      }
    }

    return Card(
      child: Column(
        children: [
          // Current class
          if (currentClass != null)
            _buildClassTile(
              context,
              currentClass,
              isCurrentClass: true,
              currentMinutes: currentMinutes,
            ),

          // Next class
          if (nextClass != null) ...[
            if (currentClass != null) const Divider(height: 1),
            _buildClassTile(
              context,
              nextClass,
              isNextClass: true,
              currentMinutes: currentMinutes,
            ),
          ],

          // Show more upcoming if no current/next
          if (currentClass == null && nextClass == null && upcomingClasses.isEmpty)
            _buildAllClassesDone(context),

          // Additional upcoming classes (max 2 more)
          ...upcomingClasses.skip(1).take(2).map((entry) {
            return Column(
              children: [
                const Divider(height: 1),
                _buildClassTile(context, entry, currentMinutes: currentMinutes),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeekendCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.weekend,
                color: AppColors.success,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'It\'s the Weekend!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No classes today. Enjoy your day!',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoClassesCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.event_available,
                color: AppColors.info,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No Classes Today',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your schedule is clear for $_todayName',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllClassesDone(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.check_circle,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Done for Today!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You\'ve completed all your classes',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassTile(
    BuildContext context,
    TimetableEntry entry, {
    bool isCurrentClass = false,
    bool isNextClass = false,
    required int currentMinutes,
  }) {
    final timeUntil = entry.startMinutes - currentMinutes;
    final timeUntilText = _formatTimeUntil(timeUntil);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentClass ? entry.color.withOpacity(0.05) : null,
        border: isCurrentClass
            ? Border(
                left: BorderSide(color: entry.color, width: 3),
              )
            : null,
      ),
      child: Row(
        children: [
          // Color indicator
          Container(
            width: 8,
            height: 50,
            decoration: BoxDecoration(
              color: entry.color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          // Class info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isCurrentClass)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'NOW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else if (isNextClass)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Text(
                      entry.course.code,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: entry.color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: entry.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        entry.slotName,
                        style: TextStyle(
                          color: entry.color,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  entry.course.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Time info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                entry.timeRange,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              if (!isCurrentClass && timeUntil > 0)
                Text(
                  timeUntilText,
                  style: TextStyle(
                    color: isNextClass ? AppColors.accent : AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: isNextClass ? FontWeight.w600 : FontWeight.normal,
                  ),
                )
              else if (isCurrentClass)
                Text(
                  '${entry.endMinutes - currentMinutes} min left',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimeUntil(int minutes) {
    if (minutes < 0) return 'Started';
    if (minutes == 0) return 'Starting now';
    if (minutes < 60) return 'in $minutes min';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (mins == 0) return 'in $hours hr';
    return 'in ${hours}h ${mins}m';
  }
}
