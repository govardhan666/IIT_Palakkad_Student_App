import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/services/timetable_generator.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/timetable_entry.dart';
import '../bloc/course_bloc.dart';
import '../bloc/course_event.dart';
import '../bloc/course_state.dart';
import '../widgets/timetable_grid.dart';
import '../widgets/course_list.dart';
import '../widgets/semester_selector.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        actions: [
          // View mode toggle
          BlocBuilder<CourseBloc, CourseState>(
            builder: (context, state) {
              if (state is CourseLoaded) {
                return IconButton(
                  icon: Icon(
                    state.viewMode == TimetableViewMode.grid
                        ? Icons.list_rounded
                        : Icons.grid_view_rounded,
                  ),
                  tooltip: state.viewMode == TimetableViewMode.grid
                      ? 'Switch to list view'
                      : 'Switch to grid view',
                  onPressed: () {
                    context.read<CourseBloc>().add(const CourseViewToggled());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh courses',
            onPressed: () {
              context.read<CourseBloc>().add(const CourseRefreshRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseInitial) {
            // Auto-load on first build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<CourseBloc>().add(const CourseLoadRequested());
            });
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CourseLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    state.message ?? 'Loading...',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            );
          }

          if (state is CourseError) {
            return _buildErrorView(context, state);
          }

          if (state is CourseEmpty) {
            return _buildEmptyView(context, state);
          }

          if (state is CourseLoaded) {
            return _buildLoadedView(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, CourseError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to Load Courses',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<CourseBloc>().add(const CourseLoadRequested());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context, CourseEmpty state) {
    return Column(
      children: [
        // Semester selector
        if (state.semesters.isNotEmpty)
          SemesterSelector(
            semesters: state.semesters,
            selectedSemester: state.selectedSemester,
            onSemesterChanged: (semester) {
              context.read<CourseBloc>().add(CourseSemesterChanged(semester.id));
            },
          ),

        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy_rounded,
                  size: 80,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 24),
                Text(
                  'No Courses Found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'No courses registered for this semester',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadedView(BuildContext context, CourseLoaded state) {
    return Column(
      children: [
        // Semester selector
        if (state.semesters.isNotEmpty)
          SemesterSelector(
            semesters: state.semesters,
            selectedSemester: state.selectedSemester,
            onSemesterChanged: (semester) {
              context.read<CourseBloc>().add(CourseSemesterChanged(semester.id));
            },
          ),

        // Summary bar
        _buildSummaryBar(context, state),

        // Timetable content
        Expanded(
          child: state.viewMode == TimetableViewMode.grid
              ? TimetableGrid(
                  timetable: state.timetable,
                  courses: state.courses,
                )
              : CourseListView(
                  courses: state.courses,
                  timetable: state.timetable,
                ),
        ),
      ],
    );
  }

  Widget _buildSummaryBar(BuildContext context, CourseLoaded state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
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
            Icons.school_rounded,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            '${state.courses.length} Courses',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(width: 16),
          Icon(
            Icons.star_rounded,
            size: 16,
            color: AppColors.accent,
          ),
          const SizedBox(width: 4),
          Text(
            '${state.totalCredits} Credits',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
