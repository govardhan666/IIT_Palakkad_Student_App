import '../domain/entities/mess_menu.dart';

/// Complete mess menu data for IIT Palakkad (4-week rotation)
class MessMenuData {
  /// Week 1 Menu
  static const WeekMenu week1 = WeekMenu(
    weekNumber: 1,
    days: [
      // Monday
      DayMenu(
        dayName: 'Monday',
        dayOfWeek: 1,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Idli', 'Sambar', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Potato Fry', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Banana', 'Biscuits'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Fry', 'Aloo Gobi', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Tuesday
      DayMenu(
        dayName: 'Tuesday',
        dayOfWeek: 2,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Puri', 'Potato Masala', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Beans Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Samosa', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Chana Masala', 'Mixed Veg', 'Rice', 'Curd', 'Pickle'],
          hasNonVeg: true,
          specialItem: 'Egg Curry (Non-Veg)',
        ),
      ),
      // Wednesday
      DayMenu(
        dayName: 'Wednesday',
        dayOfWeek: 3,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Dosa', 'Sambar', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Cabbage Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Vada', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Rajma', 'Bhindi Fry', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Thursday
      DayMenu(
        dayName: 'Thursday',
        dayOfWeek: 4,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Upma', 'Chutney', 'Bread', 'Butter', 'Jam', 'Boiled Egg', 'Milk', 'Tea/Coffee'],
          hasNonVeg: true,
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Carrot Beans Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Bread Pakora', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Tadka', 'Paneer Butter Masala', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Friday
      DayMenu(
        dayName: 'Friday',
        dayOfWeek: 5,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Pongal', 'Sambar', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Potato Podimas', 'Curd', 'Pickle', 'Papad'],
          hasNonVeg: true,
          specialItem: 'Chicken Curry (Non-Veg)',
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Bajji', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Makhani', 'Aloo Jeera', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Saturday
      DayMenu(
        dayName: 'Saturday',
        dayOfWeek: 6,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Poha', 'Sev', 'Onion', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Veg Biryani', 'Raita', 'Mirchi Ka Salan', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Cake/Pastry', 'Juice'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Kadhi', 'Aloo Matar', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Sunday
      DayMenu(
        dayName: 'Sunday',
        dayOfWeek: 7,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Chole Bhature', 'Onion', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Brinjal Curry', 'Curd', 'Pickle', 'Papad'],
          hasNonVeg: true,
          specialItem: 'Fish Curry (Non-Veg)',
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Pasta/Noodles'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Yellow Dal', 'Gobi Matar', 'Rice', 'Curd', 'Pickle', 'Ice Cream'],
          specialItem: 'Ice Cream',
        ),
      ),
    ],
  );

  /// Week 2 Menu
  static const WeekMenu week2 = WeekMenu(
    weekNumber: 2,
    days: [
      // Monday
      DayMenu(
        dayName: 'Monday',
        dayOfWeek: 1,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Medu Vada', 'Sambar', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Vendakkai Fry', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Banana', 'Biscuits'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Palak', 'Jeera Aloo', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Tuesday
      DayMenu(
        dayName: 'Tuesday',
        dayOfWeek: 2,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Uttapam', 'Sambar', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Beetroot Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Pakora', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Chole', 'Mixed Veg', 'Rice', 'Curd', 'Pickle'],
          hasNonVeg: true,
          specialItem: 'Egg Bhurji (Non-Veg)',
        ),
      ),
      // Wednesday
      DayMenu(
        dayName: 'Wednesday',
        dayOfWeek: 3,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Paratha', 'Curd', 'Pickle', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Kootu', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Bonda', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Moong Dal', 'Capsicum Potato', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Thursday
      DayMenu(
        dayName: 'Thursday',
        dayOfWeek: 4,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Idli', 'Sambar', 'Tomato Chutney', 'Bread', 'Butter', 'Jam', 'Boiled Egg', 'Milk', 'Tea/Coffee'],
          hasNonVeg: true,
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Drumstick Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Cutlet', 'Sauce'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Arhar Dal', 'Shahi Paneer', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Friday
      DayMenu(
        dayName: 'Friday',
        dayOfWeek: 5,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Rava Dosa', 'Sambar', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Ivy Gourd Fry', 'Curd', 'Pickle', 'Papad'],
          hasNonVeg: true,
          specialItem: 'Mutton Curry (Non-Veg)',
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Spring Roll', 'Sauce'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Fry', 'Matar Paneer', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Saturday
      DayMenu(
        dayName: 'Saturday',
        dayOfWeek: 6,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Aloo Paratha', 'Curd', 'Pickle', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Chicken Biryani/Veg Biryani', 'Raita', 'Salan', 'Curd', 'Pickle', 'Papad'],
          hasNonVeg: true,
          specialItem: 'Chicken Biryani',
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Sandwich', 'Juice'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Mixed Dal', 'Bhindi Masala', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Sunday
      DayMenu(
        dayName: 'Sunday',
        dayOfWeek: 7,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Puri', 'Chana Masala', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Pumpkin Curry', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Fried Rice/Noodles'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Toor Dal', 'Veg Kofta', 'Rice', 'Curd', 'Pickle', 'Gulab Jamun'],
          specialItem: 'Gulab Jamun',
        ),
      ),
    ],
  );

  /// Week 3 Menu
  static const WeekMenu week3 = WeekMenu(
    weekNumber: 3,
    days: [
      // Monday
      DayMenu(
        dayName: 'Monday',
        dayOfWeek: 1,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Idiyappam', 'Coconut Milk', 'Egg Curry', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
          hasNonVeg: true,
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Snake Gourd Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Banana', 'Biscuits'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Yellow Dal', 'Aloo Methi', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Tuesday
      DayMenu(
        dayName: 'Tuesday',
        dayOfWeek: 2,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Set Dosa', 'Sambar', 'Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Cauliflower Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Puff', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Makhani', 'Aloo Capsicum', 'Rice', 'Curd', 'Pickle'],
          hasNonVeg: true,
          specialItem: 'Omelette (Non-Veg)',
        ),
      ),
      // Wednesday
      DayMenu(
        dayName: 'Wednesday',
        dayOfWeek: 3,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Appam', 'Vegetable Stew', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Cluster Beans Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Masala Vadai', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Moong Dal', 'Kadai Paneer', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Thursday
      DayMenu(
        dayName: 'Thursday',
        dayOfWeek: 4,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Semiya Upma', 'Chutney', 'Bread', 'Butter', 'Jam', 'Boiled Egg', 'Milk', 'Tea/Coffee'],
          hasNonVeg: true,
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Raw Banana Fry', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Cutlet', 'Sauce'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Chana Dal', 'Palak Paneer', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Friday
      DayMenu(
        dayName: 'Friday',
        dayOfWeek: 5,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Masala Dosa', 'Sambar', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Potato Roast', 'Curd', 'Pickle', 'Papad'],
          hasNonVeg: true,
          specialItem: 'Chicken Roast (Non-Veg)',
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Onion Pakoda', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Rajma Masala', 'Veg Pulao', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Saturday
      DayMenu(
        dayName: 'Saturday',
        dayOfWeek: 6,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Methi Paratha', 'Curd', 'Pickle', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Veg Pulao', 'Raita', 'Curry', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Cake', 'Juice'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Tadka', 'Mushroom Masala', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Sunday
      DayMenu(
        dayName: 'Sunday',
        dayOfWeek: 7,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Bread Omelette', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
          hasNonVeg: true,
          specialItem: 'Bread Omelette',
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Bitter Gourd Fry', 'Curd', 'Pickle', 'Papad'],
          hasNonVeg: true,
          specialItem: 'Egg Curry (Non-Veg)',
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Manchurian'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Sambar', 'Aloo Matar', 'Rice', 'Curd', 'Pickle', 'Kheer'],
          specialItem: 'Kheer',
        ),
      ),
    ],
  );

  /// Week 4 Menu
  static const WeekMenu week4 = WeekMenu(
    weekNumber: 4,
    days: [
      // Monday
      DayMenu(
        dayName: 'Monday',
        dayOfWeek: 1,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Ragi Idli', 'Sambar', 'Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Spinach Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Banana', 'Biscuits'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Fry', 'Aloo Gobi', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Tuesday
      DayMenu(
        dayName: 'Tuesday',
        dayOfWeek: 2,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Pesarattu', 'Ginger Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Ash Gourd Curry', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Aloo Bonda', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Tadka Dal', 'Paneer Do Pyaza', 'Rice', 'Curd', 'Pickle'],
          hasNonVeg: true,
          specialItem: 'Egg Masala (Non-Veg)',
        ),
      ),
      // Wednesday
      DayMenu(
        dayName: 'Wednesday',
        dayOfWeek: 3,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Wheat Dosa', 'Sambar', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Ridge Gourd Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Dhokla', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Masoor Dal', 'Mix Veg Curry', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Thursday
      DayMenu(
        dayName: 'Thursday',
        dayOfWeek: 4,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Kichidi', 'Chutney', 'Bread', 'Butter', 'Jam', 'Boiled Egg', 'Milk', 'Tea/Coffee'],
          hasNonVeg: true,
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Carrot Poriyal', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Momos', 'Sauce'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Black Dal', 'Malai Kofta', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Friday
      DayMenu(
        dayName: 'Friday',
        dayOfWeek: 5,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Plain Dosa', 'Sambar', 'Podi', 'Coconut Chutney', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Beans Curry', 'Curd', 'Pickle', 'Papad'],
          hasNonVeg: true,
          specialItem: 'Prawn Curry (Non-Veg)',
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Pani Puri', 'Chutney'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Dal Makhani', 'Jeera Rice', 'Paneer Tikka', 'Curd', 'Pickle'],
        ),
      ),
      // Saturday
      DayMenu(
        dayName: 'Saturday',
        dayOfWeek: 6,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Gobi Paratha', 'Curd', 'Pickle', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Egg Biryani/Veg Biryani', 'Raita', 'Salan', 'Curd', 'Pickle', 'Papad'],
          hasNonVeg: true,
          specialItem: 'Egg Biryani',
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Pizza', 'Juice'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Palak Dal', 'Veg Jalfrezi', 'Rice', 'Curd', 'Pickle'],
        ),
      ),
      // Sunday
      DayMenu(
        dayName: 'Sunday',
        dayOfWeek: 7,
        breakfast: Meal(
          type: MealType.breakfast,
          items: ['Pav Bhaji', 'Onion', 'Lemon', 'Bread', 'Butter', 'Jam', 'Milk', 'Tea/Coffee'],
        ),
        lunch: Meal(
          type: MealType.lunch,
          items: ['Rice', 'Sambar', 'Rasam', 'Drumstick Curry', 'Curd', 'Pickle', 'Papad'],
        ),
        snacks: Meal(
          type: MealType.snacks,
          items: ['Tea/Coffee', 'Chow Mein'],
        ),
        dinner: Meal(
          type: MealType.dinner,
          items: ['Chapati', 'Sambar', 'Paneer Butter Masala', 'Rice', 'Curd', 'Pickle', 'Jalebi'],
          specialItem: 'Jalebi',
        ),
      ),
    ],
  );

  /// Get all weeks
  static List<WeekMenu> get allWeeks => [week1, week2, week3, week4];

  /// Get week by number
  static WeekMenu getWeek(int weekNumber) {
    switch (weekNumber) {
      case 1:
        return week1;
      case 2:
        return week2;
      case 3:
        return week3;
      case 4:
        return week4;
      default:
        return week1;
    }
  }

  /// Get current week's menu
  static WeekMenu getCurrentWeekMenu() {
    return getWeek(getCurrentWeekNumber());
  }

  /// Get today's menu
  static DayMenu? getTodayMenu() {
    final week = getCurrentWeekMenu();
    final dayIndex = getCurrentDayIndex();
    if (dayIndex >= 0 && dayIndex < week.days.length) {
      return week.days[dayIndex];
    }
    return null;
  }

  /// Get current meal
  static Meal? getCurrentMealItem() {
    final today = getTodayMenu();
    if (today == null) return null;
    return today.getMeal(getCurrentMeal());
  }
}
