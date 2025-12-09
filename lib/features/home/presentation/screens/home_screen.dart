import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/home_header.dart';
import '../widgets/weather_widget.dart';
import '../widgets/quick_access_grid.dart';
import '../widgets/todays_classes_widget.dart';
import '../widgets/for_you_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Trigger refresh of data
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: CustomScrollView(
            slivers: [
              // App bar with IIT PKD branding
              SliverAppBar(
                floating: true,
                backgroundColor: AppColors.scaffoldBackground,
                elevation: 0,
                title: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'IIT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'IIT Palakkad',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Search coming soon')),
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              // Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with greeting
                    const HomeHeader(),

                    // Weather widget
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionLabel(context, 'Weather at Campus'),
                          const SizedBox(height: 8),
                          const WeatherWidget(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Quick access grid
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: QuickAccessGrid(),
                    ),
                    const SizedBox(height: 20),

                    // Today's classes
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TodaysClassesWidget(),
                    ),
                    const SizedBox(height: 20),

                    // For you section
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: ForYouSection(),
                    ),
                    const SizedBox(height: 20),

                    // Bottom padding
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            size: 14,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
