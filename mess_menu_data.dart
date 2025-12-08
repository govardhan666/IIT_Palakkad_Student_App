/// IIT Palakkad Mess Menu Data
/// Last Updated: 13/11/2024
/// Source: IIT Palakkad Mess
/// 
/// Notes:
/// - Week 1 and 3 follow the same menu
/// - Week 2 and 4 follow the same menu
/// - Everything is veg unless mentioned otherwise

class MessMenuData {
  MessMenuData._();

  static const String lastUpdated = '13/11/2024';

  // ============================================================
  // COMMON ITEMS (Available every day)
  // ============================================================

  static const CommonItems common = CommonItems(
    breakfast: ['Bread', 'Butter', 'Jam', 'Milk', 'Tea', 'Coffee', 'Sprouts/Chana', 'Seasonal Fruit'],
    breakfastVeg: 'Fruit (Based on Market availability)',
    breakfastNonVeg: 'Boiled Egg (5 times a week), Omelette (2 times a week)',
    lunch: ['Mix Pickle', 'Papad', 'Mix Salad', 'Onion', 'Lemon', 'White Rice'],
    snacks: ['Tea', 'Coffee', 'Sugar'],
    dinner: ['Appalam', 'Mixed Salad', 'Pickle (Mango/Chili/Mix)'],
  );

  // ============================================================
  // MEAL TIMINGS
  // ============================================================

  static const Map<String, MealTiming> mealTimings = {
    'breakfast': MealTiming('07:30', '09:30'),
    'lunch': MealTiming('12:00', '14:00'),
    'snacks': MealTiming('16:30', '18:00'),
    'dinner': MealTiming('19:30', '21:30'),
  };

  // ============================================================
  // WEEK 1 & 3 MENU
  // ============================================================

  static const Map<String, DayMenu> week1Menu = {
    'monday': DayMenu(
      breakfast: Meal(
        items: ['Aloo Paratha', 'Ketchup', 'Curd', 'Mint & Coriander Chutney'],
      ),
      lunch: Meal(
        items: ['Phulka', 'White Rice', 'Kerala Rice', 'Chana (White) Masala', 'Arhar Dal', 'Sambar', 'Chutney', 'Curd'],
      ),
      snacks: Meal(
        items: ['Onion Kachori', 'Tomato Ketchup', 'Fried Chilly'],
      ),
      dinner: Meal(
        items: ['Fried Rice', 'Phulka', 'Dal Tadka', 'Gobhi Manchurian'],
      ),
    ),
    'tuesday': DayMenu(
      breakfast: Meal(
        items: ['Masala Dosa', 'Tomato Chutney', 'Sambar'],
      ),
      lunch: Meal(
        items: ['Puri', 'Aloo Palak', 'Sambar', 'Ridge Gourd (Dry)', 'White Rice', 'Buttermilk', 'Watermelon', 'Kerala Rice'],
      ),
      snacks: Meal(
        items: ['Aloo Bonda (>60 gm)', 'Tomato Ketchup'],
      ),
      dinner: Meal(
        items: ['Phulka', 'Chole Masala', 'Jeera Rice', 'Dal (Mix Veg)', 'Raita', 'Ice-cream'],
      ),
    ),
    'wednesday': DayMenu(
      breakfast: Meal(
        items: ['Dal Kichdi', 'Coconut Chutney', 'Dahi Boondhi', 'Peanut Butter'],
        nonVegAlternative: 'Omelette',
      ),
      lunch: Meal(
        items: ['Chapathi', 'White Rice', 'Green Peas Masala', 'Kerala Rice', 'Onion Raita', 'Rasam', 'Chana Dal Fry'],
      ),
      snacks: Meal(
        items: ['Green Matar Chat'],
      ),
      dinner: Meal(
        vegItems: ['Hyderabadi Paneer Dish', 'White Rice', 'Moong Dal', 'Paratha', 'Laddu', 'Lemon'],
        nonVegItems: ['Hyderabadi Chicken Masala', 'White Rice', 'Moong Dal', 'Paratha', 'Laddu', 'Lemon'],
      ),
    ),
    'thursday': DayMenu(
      breakfast: Meal(
        items: ['Puri', 'Chana (White) Masala'],
      ),
      lunch: Meal(
        items: ['Chapathi', 'White Rice', 'Mix Dal', 'Malai Kofta', 'Bottle Gourd Dry', 'Curd'],
      ),
      snacks: Meal(
        items: ['Tikki Chat'],
      ),
      dinner: Meal(
        items: ['Special Dal', 'Sambar', 'Masala Dosa (UNLIMITED)', 'White Rice', 'Tomato Chutney', 'Coriander Chutney', 'Coconut Chutney', 'Payasam', 'Rasam'],
        highlight: 'Masala Dosa Night - Unlimited!',
      ),
    ),
    'friday': DayMenu(
      breakfast: Meal(
        items: ['Fried Idly', 'Vada', 'Sambar', 'Coconut Chutney'],
        nonVegAlternative: 'Omelette',
      ),
      lunch: Meal(
        items: ['Phulka', 'White Rice', 'Kadai Veg', 'Sambar', 'Potato Cabbage Dry', 'Buttermilk'],
      ),
      snacks: Meal(
        items: ['Pungulu with Coconut Chutney'],
      ),
      dinner: Meal(
        vegItems: ['Paneer Butter Masala', 'Pulao', 'Mix Dal', 'Chapathi', 'Mango Pickle', 'Lemon', 'Badhusha'],
        nonVegItems: ['Chicken Gravy', 'Pulao', 'Mix Dal', 'Chapathi', 'Mango Pickle', 'Lemon', 'Badhusha'],
      ),
    ),
    'saturday': DayMenu(
      breakfast: Meal(
        items: ['Gobi Mix Veg Paratha', 'Ketchup', 'Green Coriander Chutney', 'Peanut Butter'],
      ),
      lunch: Meal(
        items: ['Chapathi', 'White Rice', 'Rajma Masala', 'Green Vegetable (Dry)', 'Ginger Dal', 'Gongura Chutney', 'Curd'],
      ),
      snacks: Meal(
        items: ['Samosa', 'Tomato Ketchup', 'Cold Coffee'],
      ),
      dinner: Meal(
        items: ['Phulka', 'Green Peas Masala', 'White Rice', 'Raw Banana Poriyal', 'Rasam', 'Buttermilk'],
      ),
    ),
    'sunday': DayMenu(
      breakfast: Meal(
        items: ['Onion Rava Dosa', 'Tomato Chutney', 'Sambar'],
      ),
      lunch: Meal(
        vegItems: ['Chilli Paneer', 'Dum Briyani', 'Shorba Masala', 'Onion Raita', 'Aam Panna'],
        nonVegItems: ['Chicken Dum Briyani', 'Shorba Masala', 'Onion Raita', 'Aam Panna'],
        highlight: 'Biryani Special!',
      ),
      snacks: Meal(
        items: ['Vada Pav', 'Fried Green Chilly', 'Green Coriander Chutney'],
      ),
      dinner: Meal(
        items: ['Arhar Dal Tadka', 'Aloo Fry', 'Kadhi Pakoda', 'Rice', 'Chapati', 'Gulab Jamun'],
      ),
    ),
  };

  // ============================================================
  // WEEK 2 & 4 MENU
  // ============================================================

  static const Map<String, DayMenu> week2Menu = {
    'monday': DayMenu(
      breakfast: Meal(
        items: ['Aloo Paratha', 'Ketchup', 'Curd', 'Seasonal Fruit', 'Mint & Coriander Chutney'],
      ),
      lunch: Meal(
        items: ['Phulka', 'Ghee Rice', 'Aloo Chana Masala', 'Soya Chilly (Semi-Dry)', 'Rasam', 'Chutney', 'Buttermilk'],
      ),
      snacks: Meal(
        items: ['Macaroni'],
      ),
      dinner: Meal(
        vegItems: ['Paneer Biryani', 'Raita', 'Mutter Masala', 'Chana Dal Tadka', 'Phulka', 'Makkan Peda', 'White Rice'],
        nonVegItems: ['Egg Biryani', 'Raita', 'Mutter Masala', 'Chana Dal Tadka', 'Phulka', 'Makkan Peda', 'White Rice'],
        highlight: 'Biryani Night!',
      ),
    ),
    'tuesday': DayMenu(
      breakfast: Meal(
        items: ['Upma', 'Vada', 'Coriander Chutney', 'Curd'],
      ),
      lunch: Meal(
        items: ['Chole', 'Bhatura', 'Toor Dal Fry', 'Watermelon', 'Green Mix Vegetables (Dry)', 'Lemon Rice', 'Curd'],
        highlight: 'Chole Bhature!',
      ),
      snacks: Meal(
        items: ['Dahi Papdi Chat'],
      ),
      dinner: Meal(
        items: ['Phulka', 'White Rice', 'Methi Dal', 'Mix Veg (Dry)', 'Sambar', 'Ice-cream'],
      ),
    ),
    'wednesday': DayMenu(
      breakfast: Meal(
        items: ['Puttu', 'Kadal Curry', 'Peanut Butter'],
        nonVegAlternative: 'Omelette',
      ),
      lunch: Meal(
        items: ['Chapathi', 'Methi Dal', 'Drumstick Gravy', 'Dondakaya Dry', 'Rasam', 'Buttermilk'],
      ),
      snacks: Meal(
        items: ['Mysore Bonda'],
      ),
      dinner: Meal(
        vegItems: ['Kadai Paneer', 'Pulao', 'Mix Dal', 'Tawa Butter Naan', 'Mango Pickle', 'Lemon'],
        nonVegItems: ['Kadai Chicken', 'Pulao', 'Mix Dal', 'Tawa Butter Naan', 'Mango Pickle', 'Lemon'],
      ),
    ),
    'thursday': DayMenu(
      breakfast: Meal(
        items: ['Mini Chole Bhatura', 'Seasonal Fruit'],
      ),
      lunch: Meal(
        items: ['Chapathi', 'Mutter Paneer Masala', 'Coriander Rice', 'Kollu Rasam', 'Potato Chips', 'Dalpodhi', 'Curd'],
      ),
      snacks: Meal(
        items: ['Cutlet', 'Tomato Ketchup'],
      ),
      dinner: Meal(
        items: ['Arhar Dal Tadka', 'Aloo Fry', 'Kadhi Pakoda', 'White Rice', 'Chapati', 'Mysore Pak'],
      ),
    ),
    'friday': DayMenu(
      breakfast: Meal(
        items: ['Podi Dosa', 'Sambar', 'Tomato Chutney', 'Peanut Butter'],
      ),
      lunch: Meal(
        items: ['Phulka', 'Navadhanya Masala', 'Sambar', 'Green Mix Veg', 'Rasam', 'Watermelon Juice'],
      ),
      snacks: Meal(
        items: ['Pani Puri'],
        highlight: 'Pani Puri Friday!',
      ),
      dinner: Meal(
        vegItems: ['Paneer Butter Masala', 'Pulao', 'Mix Dal', 'Chapathi', 'Fruit Vermicelli Sheera'],
        nonVegItems: ['Chicken Gravy', 'Pulao', 'Mix Dal', 'Chapathi', 'Fruit Vermicelli Sheera'],
      ),
    ),
    'saturday': DayMenu(
      breakfast: Meal(
        items: ['Mix-Veg Paratha', 'Mint Chutney', 'Curd', 'Ketchup'],
        nonVegAlternative: 'Omelette',
      ),
      lunch: Meal(
        items: ['Chapathi', 'Green Peas Pulav', 'Spinach Dal', 'Gobhi Capsicum Dry', 'Cabbage Chutney', 'Masala Buttermilk'],
      ),
      snacks: Meal(
        items: ['Samosa', 'Tomato Ketchup', 'Cold Coffee'],
      ),
      dinner: Meal(
        items: ['Dal Makhani', 'Aloo Brinjal (Dry)', 'Sambar', 'Phulka', 'White Rice', 'Kheer'],
      ),
    ),
    'sunday': DayMenu(
      breakfast: Meal(
        items: ['Andhra Kara Dosa', 'Peanut Chutney', 'Sambar'],
      ),
      lunch: Meal(
        vegItems: ['Paneer Masala (Spicy)', 'Puri', 'Briyani Rice', 'Chana Dal Tadka', 'Raita', 'Fruit Juice'],
        nonVegItems: ['Chicken Masala (Spicy)', 'Puri', 'Briyani Rice', 'Chana Dal Tadka', 'Raita', 'Fruit Juice'],
        highlight: 'Non-Veg Special!',
      ),
      snacks: Meal(
        items: ['Pav Bhaji'],
        highlight: 'Pav Bhaji Sunday!',
      ),
      dinner: Meal(
        items: ['Phulka', 'Baby Aloo Masala', 'Soya Chilli (Semi Dry)', 'White Rice', 'Dal (Thick)', 'Rasam'],
      ),
    ),
  };

  // ============================================================
  // HELPER METHODS
  // ============================================================

  /// Get menu for current week
  static Map<String, DayMenu> getMenuForWeek(int weekNumber) {
    // Week 1 & 3 use week1Menu, Week 2 & 4 use week2Menu
    if (weekNumber == 1 || weekNumber == 3) {
      return week1Menu;
    } else {
      return week2Menu;
    }
  }

  /// Get week number of the month (1-4)
  static int getWeekOfMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final dayOfMonth = date.day;
    return ((dayOfMonth + firstDayOfMonth.weekday - 2) ~/ 7) + 1;
  }

  /// Get today's menu
  static DayMenu? getTodayMenu(DateTime date) {
    final weekNumber = getWeekOfMonth(date);
    final menu = getMenuForWeek(weekNumber);
    final dayName = _getDayName(date.weekday).toLowerCase();
    return menu[dayName];
  }

  /// Get current meal based on time
  static String getCurrentMealType(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final timeMinutes = hour * 60 + minute;

    // Breakfast: 07:30 - 09:30
    if (timeMinutes >= 450 && timeMinutes < 570) return 'breakfast';
    // Lunch: 12:00 - 14:00
    if (timeMinutes >= 720 && timeMinutes < 840) return 'lunch';
    // Snacks: 16:30 - 18:00
    if (timeMinutes >= 990 && timeMinutes < 1080) return 'snacks';
    // Dinner: 19:30 - 21:30
    if (timeMinutes >= 1170 && timeMinutes < 1290) return 'dinner';

    // Return next upcoming meal
    if (timeMinutes < 450) return 'breakfast';
    if (timeMinutes < 720) return 'lunch';
    if (timeMinutes < 990) return 'snacks';
    if (timeMinutes < 1170) return 'dinner';
    return 'breakfast'; // Next day
  }

  static String _getDayName(int weekday) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }
}

// ============================================================
// DATA MODELS
// ============================================================

class CommonItems {
  final List<String> breakfast;
  final String breakfastVeg;
  final String breakfastNonVeg;
  final List<String> lunch;
  final List<String> snacks;
  final List<String> dinner;

  const CommonItems({
    required this.breakfast,
    required this.breakfastVeg,
    required this.breakfastNonVeg,
    required this.lunch,
    required this.snacks,
    required this.dinner,
  });
}

class MealTiming {
  final String start;
  final String end;

  const MealTiming(this.start, this.end);
}

class DayMenu {
  final Meal breakfast;
  final Meal lunch;
  final Meal snacks;
  final Meal dinner;

  const DayMenu({
    required this.breakfast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
  });
}

class Meal {
  final List<String>? items;
  final List<String>? vegItems;
  final List<String>? nonVegItems;
  final String? nonVegAlternative;
  final String? highlight;

  const Meal({
    this.items,
    this.vegItems,
    this.nonVegItems,
    this.nonVegAlternative,
    this.highlight,
  });

  /// Get items based on preference
  List<String> getItems({bool isVeg = true}) {
    if (items != null) return items!;
    if (isVeg && vegItems != null) return vegItems!;
    if (!isVeg && nonVegItems != null) return nonVegItems!;
    return vegItems ?? nonVegItems ?? [];
  }

  bool get hasNonVegOption => nonVegItems != null || nonVegAlternative != null;
}
