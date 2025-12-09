/// Meal types
enum MealType {
  breakfast,
  lunch,
  snacks,
  dinner,
}

/// Get meal type display name
String getMealTypeName(MealType type) {
  switch (type) {
    case MealType.breakfast:
      return 'Breakfast';
    case MealType.lunch:
      return 'Lunch';
    case MealType.snacks:
      return 'Snacks';
    case MealType.dinner:
      return 'Dinner';
  }
}

/// Get meal timing
String getMealTiming(MealType type) {
  switch (type) {
    case MealType.breakfast:
      return '7:30 AM - 9:30 AM';
    case MealType.lunch:
      return '12:30 PM - 2:30 PM';
    case MealType.snacks:
      return '5:00 PM - 6:00 PM';
    case MealType.dinner:
      return '7:30 PM - 9:30 PM';
  }
}

/// Single meal entity
class Meal {
  final MealType type;
  final List<String> items;
  final String? specialItem;
  final bool hasNonVeg;

  const Meal({
    required this.type,
    required this.items,
    this.specialItem,
    this.hasNonVeg = false,
  });

  String get timing => getMealTiming(type);
  String get name => getMealTypeName(type);
}

/// Day's complete menu
class DayMenu {
  final String dayName;
  final int dayOfWeek; // 1 = Monday, 7 = Sunday
  final Meal breakfast;
  final Meal lunch;
  final Meal snacks;
  final Meal dinner;

  const DayMenu({
    required this.dayName,
    required this.dayOfWeek,
    required this.breakfast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
  });

  Meal getMeal(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return breakfast;
      case MealType.lunch:
        return lunch;
      case MealType.snacks:
        return snacks;
      case MealType.dinner:
        return dinner;
    }
  }

  List<Meal> get allMeals => [breakfast, lunch, snacks, dinner];
}

/// Week's menu
class WeekMenu {
  final int weekNumber; // 1-4
  final List<DayMenu> days;

  const WeekMenu({
    required this.weekNumber,
    required this.days,
  });
}

/// Get current week number (1-4) based on date
int getCurrentWeekNumber() {
  final now = DateTime.now();
  // Use the day of month to determine week
  // Week 1: 1-7, Week 2: 8-14, Week 3: 15-21, Week 4: 22-end
  final day = now.day;
  if (day <= 7) return 1;
  if (day <= 14) return 2;
  if (day <= 21) return 3;
  return 4;
}

/// Get current day index (0 = Monday, 6 = Sunday)
int getCurrentDayIndex() {
  return DateTime.now().weekday - 1;
}

/// Get current meal based on time
MealType getCurrentMeal() {
  final now = DateTime.now();
  final hour = now.hour;
  final minute = now.minute;

  // Before 9:30 AM - Breakfast
  if (hour < 9 || (hour == 9 && minute <= 30)) {
    return MealType.breakfast;
  }
  // Before 2:30 PM - Lunch
  if (hour < 14 || (hour == 14 && minute <= 30)) {
    return MealType.lunch;
  }
  // Before 6:00 PM - Snacks
  if (hour < 18) {
    return MealType.snacks;
  }
  // Dinner
  return MealType.dinner;
}
