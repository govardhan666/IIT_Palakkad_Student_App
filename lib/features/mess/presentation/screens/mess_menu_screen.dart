import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/mess_menu_data.dart';
import '../../domain/entities/mess_menu.dart';

/// Mess menu screen with weekly menu display
class MessMenuScreen extends StatefulWidget {
  const MessMenuScreen({super.key});

  @override
  State<MessMenuScreen> createState() => _MessMenuScreenState();
}

class _MessMenuScreenState extends State<MessMenuScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedWeek;
  bool _showNonVeg = true;

  @override
  void initState() {
    super.initState();
    _selectedWeek = getCurrentWeekNumber();
    _tabController = TabController(
      length: 7,
      vsync: this,
      initialIndex: getCurrentDayIndex(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weekMenu = MessMenuData.getWeek(_selectedWeek);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mess Menu'),
        actions: [
          // Veg/Non-veg toggle
          IconButton(
            icon: Icon(
              _showNonVeg ? Icons.egg_alt : Icons.eco,
              color: _showNonVeg ? AppColors.error : AppColors.success,
            ),
            onPressed: () {
              setState(() => _showNonVeg = !_showNonVeg);
            },
            tooltip: _showNonVeg ? 'Show Veg Only' : 'Show All Items',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: weekMenu.days.map((day) {
            final isToday = day.dayOfWeek == DateTime.now().weekday &&
                _selectedWeek == getCurrentWeekNumber();
            return Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isToday)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(day.dayName.substring(0, 3)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          // Week selector
          _buildWeekSelector(),

          // Current meal highlight (if viewing current week)
          if (_selectedWeek == getCurrentWeekNumber()) _buildCurrentMealCard(),

          // Day content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: weekMenu.days.map((day) {
                return _buildDayMenu(day);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_month, size: 20),
          const SizedBox(width: 12),
          const Text('Week:'),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SegmentedButton<int>(
                segments: List.generate(4, (index) {
                  final weekNum = index + 1;
                  final isCurrent = weekNum == getCurrentWeekNumber();
                  return ButtonSegment(
                    value: weekNum,
                    label: Text(
                      isCurrent ? 'Week $weekNum (Current)' : 'Week $weekNum',
                    ),
                  );
                }),
                selected: {_selectedWeek},
                onSelectionChanged: (selection) {
                  setState(() => _selectedWeek = selection.first);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentMealCard() {
    final currentMeal = MessMenuData.getCurrentMealItem();
    if (currentMeal == null) return const SizedBox.shrink();

    final dayIndex = getCurrentDayIndex();
    final isViewingToday = _tabController.index == dayIndex;

    if (!isViewingToday) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getMealIcon(currentMeal.type),
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'NOW SERVING',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  currentMeal.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentMeal.timing,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayMenu(DayMenu day) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMealCard(day.breakfast),
        const SizedBox(height: 12),
        _buildMealCard(day.lunch),
        const SizedBox(height: 12),
        _buildMealCard(day.snacks),
        const SizedBox(height: 12),
        _buildMealCard(day.dinner),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMealCard(Meal meal) {
    final isCurrentMeal = _selectedWeek == getCurrentWeekNumber() &&
        _tabController.index == getCurrentDayIndex() &&
        meal.type == getCurrentMeal();

    // Filter items based on veg preference
    List<String> displayItems = meal.items;
    if (!_showNonVeg && meal.hasNonVeg) {
      displayItems = meal.items
          .where((item) =>
              !item.toLowerCase().contains('egg') &&
              !item.toLowerCase().contains('chicken') &&
              !item.toLowerCase().contains('mutton') &&
              !item.toLowerCase().contains('fish') &&
              !item.toLowerCase().contains('prawn') &&
              !item.toLowerCase().contains('non-veg'))
          .toList();
    }

    return Card(
      elevation: isCurrentMeal ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isCurrentMeal
            ? BorderSide(color: AppColors.primary, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _getMealColor(meal.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getMealIcon(meal.type),
                    color: _getMealColor(meal.type),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            meal.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (isCurrentMeal) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
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
                            ),
                          ],
                        ],
                      ),
                      Text(
                        meal.timing,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (meal.hasNonVeg && _showNonVeg)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.egg_alt,
                      size: 16,
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: displayItems.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 13),
                  ),
                );
              }).toList(),
            ),
            if (meal.specialItem != null && _showNonVeg) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Special: ${meal.specialItem}',
                      style: TextStyle(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getMealIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Icons.free_breakfast;
      case MealType.lunch:
        return Icons.lunch_dining;
      case MealType.snacks:
        return Icons.cookie;
      case MealType.dinner:
        return Icons.dinner_dining;
    }
  }

  Color _getMealColor(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return const Color(0xFFFBBC05); // Yellow
      case MealType.lunch:
        return const Color(0xFF4285F4); // Blue
      case MealType.snacks:
        return const Color(0xFF34A853); // Green
      case MealType.dinner:
        return const Color(0xFFEA4335); // Red
    }
  }
}
