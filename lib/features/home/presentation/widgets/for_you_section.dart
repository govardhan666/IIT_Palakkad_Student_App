import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Campus announcement/update item
class CampusUpdate {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? actionLabel;
  final VoidCallback? onTap;

  const CampusUpdate({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.actionLabel,
    this.onTap,
  });
}

/// Widget displaying campus updates and announcements
class ForYouSection extends StatelessWidget {
  const ForYouSection({super.key});

  // Static campus updates (can be replaced with API data later)
  static final List<CampusUpdate> _updates = [
    CampusUpdate(
      title: 'Library Hours Extended',
      subtitle: 'Library now open until 11 PM on weekdays',
      icon: Icons.menu_book_rounded,
      color: const Color(0xFF4285F4),
    ),
    CampusUpdate(
      title: 'Mess Menu Updated',
      subtitle: 'New dishes added to the weekly rotation',
      icon: Icons.restaurant_rounded,
      color: const Color(0xFF34A853),
    ),
    CampusUpdate(
      title: 'Sports Day Registration',
      subtitle: 'Register for annual sports events by Dec 15',
      icon: Icons.sports_soccer_rounded,
      color: const Color(0xFFEA4335),
    ),
    CampusUpdate(
      title: 'Placement Season',
      subtitle: 'Campus placements starting from Jan 2025',
      icon: Icons.work_rounded,
      color: const Color(0xFFFBBC05),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'For You',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all announcements
                },
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _updates.length,
            itemBuilder: (context, index) {
              final update = _updates[index];
              return _buildUpdateCard(context, update, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateCard(BuildContext context, CampusUpdate update, int index) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(
        left: index == 0 ? 0 : 8,
        right: index == _updates.length - 1 ? 0 : 8,
      ),
      child: Card(
        elevation: 1,
        child: InkWell(
          onTap: update.onTap ?? () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: update.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    update.icon,
                    color: update.color,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  update.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    update.subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
