import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

/// Quick access item data
class QuickAccessItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const QuickAccessItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}

/// Widget displaying 2x2 quick access grid
class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key});

  static const List<QuickAccessItem> _items = [
    QuickAccessItem(
      title: 'Results',
      icon: Icons.assessment_rounded,
      color: Color(0xFF4285F4), // Blue
      route: '/grades',
    ),
    QuickAccessItem(
      title: 'Exams',
      icon: Icons.edit_document,
      color: Color(0xFFEA4335), // Red
      route: '/exams',
    ),
    QuickAccessItem(
      title: 'Faculty',
      icon: Icons.people_rounded,
      color: Color(0xFF34A853), // Green
      route: '/faculty',
    ),
    QuickAccessItem(
      title: 'WiFi',
      icon: Icons.wifi_rounded,
      color: Color(0xFFFBBC05), // Yellow
      route: '/wifi',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Quick Access',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: _items.map((item) => _buildGridItem(context, item)).toList(),
        ),
      ],
    );
  }

  Widget _buildGridItem(BuildContext context, QuickAccessItem item) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () => context.push(item.route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
