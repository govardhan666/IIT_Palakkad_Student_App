# IIT Palakkad Student App - Claude Code Prompts

## 📋 Extracted Data (Ready for Copy-Paste)

---

## 🕐 IIT PALAKKAD SLOT SYSTEM

### Monday, Wednesday, Friday Schedule (50-min slots)

| Time | Mon | Wed | Fri |
|------|-----|-----|-----|
| 08:00-08:50 | A | C | E |
| 09:00-09:50 | B | D | A |
| 10:00-10:50 | C | E | B |
| 11:00-11:50 | D | A | C |
| 12:05-12:55 | H | H | H |
| 13:00-13:50 | Lunch | Lunch | Lunch |
| 14:00-15:15 | I | Q (14:00-14:50) | J |
| 15:30-16:45 | J | R3 (15:00-15:50) | I |
| 17:10-18:00 | R1 | CMN-A/CMN-B | R5 |

### Tuesday, Thursday Schedule (75-min slots)

| Time | Tue | Thu |
|------|-----|-----|
| 08:00-08:50 | B | D |
| 09:00-10:15 | F | G |
| 10:30-11:45 | G | F |
| 12:00-12:50 | M | M |
| 13:00-13:50 | Lunch | Lunch |
| 14:00-15:15 | K | L |
| 15:30-16:45 | L | K |
| 17:10-18:00 | R2 | R4 |

### Lab Slots

| Slot | Day | Time |
|------|-----|------|
| PM1 | Monday | 09:00-11:45 |
| PM2 | Tuesday | 09:00-11:45 |
| PM3 | Wednesday | 09:00-11:45 |
| PM4 | Thursday | 09:00-11:45 |
| PM5 | Friday | 09:00-11:45 |
| PA1 | Monday | 14:00-16:45 |
| PA2 | Tuesday | 14:00-16:45 |
| PA3 | Wednesday | 14:00-15:50 |
| PA4 | Thursday | 14:00-16:45 |
| PA5 | Friday | 14:00-16:45 |

### Slot Credit Information

| Slot Type | Credits | Duration |
|-----------|---------|----------|
| A, B, C, D, H | 3 credits | 3×50 mins |
| F, G, I, J, K, L | 3 credits | 2×75 mins |
| E, M | 2 credits | 2×50 mins |
| Q, R1-R5 | 1 credit | 50 mins |
| PM1-PM5 | Lab | 2hr 45min |
| PA1, PA2, PA4, PA5 | Lab | 2hr 45min |
| PA3 | Lab | 1hr 50min |

### Slot Naming Convention
- Numbers in slot names = day of week (1=Monday, 2=Tuesday, etc.)
- Example: PA5 = Friday afternoon lab, M3 = Wednesday M slot

---

## 🔗 IIT PALAKKAD PORTAL URLS

| Feature | URL |
|---------|-----|
| Login/Records Portal | https://records.iitpkd.ac.in/ |
| Course Registration | https://records.iitpkd.ac.in/course_registration_reports/student_courses |
| Grades/Results | https://records.iitpkd.ac.in/grades/view_results |
| WiFi Login | https://netaccess.iitpkd.ac.in:1442/ |
| Faculty List | https://iitpkd.ac.in/faculty-list |

---

## 📱 APP STRUCTURE (Based on VIT-AP App)

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── slot_system.dart      # IIT Palakkad slot mapping
│   ├── utils/
│   │   ├── date_utils.dart
│   │   └── validators.dart
│   └── theme/
│       └── app_theme.dart
│
├── features/
│   ├── auth/
│   │   ├── model/
│   │   ├── repository/
│   │   ├── viewmodel/
│   │   └── view/
│   │       ├── pages/
│   │       │   └── login_page.dart
│   │       └── widgets/
│   │
│   ├── home/
│   │   ├── model/
│   │   ├── repository/
│   │   ├── viewmodel/
│   │   └── view/
│   │       ├── pages/
│   │       │   └── home_page.dart
│   │       └── widgets/
│   │           ├── weather_widget.dart
│   │           ├── quick_access_grid.dart
│   │           └── for_you_section.dart
│   │
│   ├── timetable/
│   │   ├── model/
│   │   │   ├── course_model.dart
│   │   │   └── timetable_model.dart
│   │   ├── repository/
│   │   │   └── timetable_repository.dart
│   │   ├── viewmodel/
│   │   └── view/
│   │       ├── pages/
│   │       │   └── timetable_page.dart
│   │       └── widgets/
│   │           └── timetable_grid.dart
│   │
│   ├── bus_schedule/
│   │   ├── model/
│   │   ├── repository/
│   │   └── view/
│   │
│   ├── mess_menu/
│   │   ├── model/
│   │   ├── repository/
│   │   └── view/
│   │
│   ├── results/
│   │   ├── model/
│   │   ├── repository/
│   │   └── view/
│   │
│   ├── faculty/
│   │   ├── model/
│   │   ├── repository/
│   │   └── view/
│   │
│   ├── wifi/
│   │   ├── repository/
│   │   └── view/
│   │
│   └── account/
│       ├── model/
│       ├── repository/
│       └── view/
│
├── shared/
│   ├── widgets/
│   │   ├── bottom_nav_bar.dart
│   │   └── loading_indicator.dart
│   └── services/
│       ├── api_service.dart
│       └── storage_service.dart
│
└── main.dart
```

---

## 🎯 PHASED PROMPTS FOR CLAUDE CODE

### PHASE 1: Project Setup
```
Create a Flutter app called "IIT Palakkad Student" with:

1. Clean architecture structure (lib/core, lib/features, lib/shared)
2. Dependencies in pubspec.yaml:
   - flutter_bloc: ^8.1.3
   - dio: ^5.3.3
   - shared_preferences: ^2.2.2
   - go_router: ^12.1.1
   - flutter_secure_storage: ^9.0.0
   - http: ^1.1.0
   - html: ^0.15.4 (for HTML parsing)
   - intl: ^0.18.1

3. Bottom navigation with 5 tabs: Home, Timetable, Bus Schedule, Mess Menu, Account
4. Theme with IIT Palakkad colors (Primary: #1E3A8A blue, Accent: #F59E0B gold)
5. Placeholder screens for each tab
6. Basic app routing with go_router

Start with the foundation only.
```

### PHASE 2: Authentication
```
Add authentication to the IIT Palakkad app:

1. Create login screen for https://records.iitpkd.ac.in/
2. The login uses form-based auth (POST with username/password)
3. Store session cookies using flutter_secure_storage
4. Create AuthRepository with methods:
   - login(username, password) -> returns session token
   - logout()
   - isLoggedIn()
   - getStoredCredentials()
5. AuthBloc with states: Initial, Loading, Authenticated, Unauthenticated, Error
6. Protect all routes - redirect to login if not authenticated
7. Auto-login on app start if valid session exists
```

### PHASE 3: Course Fetching & Timetable
```
Add timetable generation to the IIT Palakkad app:

1. After login, fetch courses from:
   https://records.iitpkd.ac.in/course_registration_reports/student_courses

2. Parse HTML response to extract: Course Code, Course Name, Slot, Credits, Instructor

3. Create semester selector (parse available semesters from the page)

4. Implement the IIT Palakkad slot system (I'm providing the exact mapping below)

5. Generate a weekly timetable grid showing Mon-Fri with all time slots

6. Color-code different courses for easy viewing

SLOT SYSTEM MAPPING:
[Copy the slot system tables from above]

IMPORTANT:
- Slots like "F" appear on both Tue (9:00-10:15) and Thu (10:30-11:45)
- Lab slots (PA, PM) span multiple hours
- Parse slot from course data (e.g., "A", "F+I", "PA2+R2")
```

### PHASE 4: Home Screen
```
Build the Home screen with these sections:

1. HEADER:
   - Greeting based on time of day
   - Student name (from stored profile)
   - Profile avatar

2. WEATHER WIDGET:
   - Show IIT Palakkad weather (Lat: 10.8676, Long: 76.6524)
   - Use OpenWeatherMap free API or wttr.in
   - Show: Temperature, condition, humidity

3. QUICK ACCESS GRID (2x2):
   - Results → Navigate to grades screen
   - Exams → Placeholder screen
   - Faculty → Navigate to faculty list
   - WiFi → WiFi auto-login screen

4. TODAY'S CLASSES:
   - Show upcoming classes from timetable
   - Current/next class highlighted
   - Show time remaining until next class

5. FOR YOU SECTION:
   - Cards with campus updates/announcements
   - Can be static data for now
```

### PHASE 5: Results Feature
```
Add Results/Grades feature:

1. Fetch grades from: https://records.iitpkd.ac.in/grades/view_results

2. Parse HTML to extract:
   - CGPA (Cumulative GPA)
   - Semester-wise SGPA
   - Course-wise grades (Course Code, Name, Credits, Grade, Grade Points)

3. Create GradeModel:
   - courseCode, courseName, credits, grade, gradePoints

4. Create SemesterResult model:
   - semesterName, sgpa, courses[]

5. UI:
   - Overall CGPA card at top
   - Semester-wise expandable list
   - Each semester shows SGPA and course grades
   - Color code grades (S=green, A=blue, etc.)
```

### PHASE 6: Faculty Feature
```
Add Faculty Directory feature:

1. Scrape faculty from: https://iitpkd.ac.in/faculty-list

2. Parse to extract:
   - Name
   - Department
   - Designation
   - Email
   - Profile image URL
   - Research areas (if available)

3. Create FacultyModel with above fields

4. UI:
   - Search bar at top
   - Filter by department dropdown
   - List view with faculty cards
   - Each card: Photo, Name, Dept, Email
   - Tap to expand for more details
   - Email tap opens mail app
```

### PHASE 7: WiFi Auto-Login
```
Add WiFi auto-login feature for campus WiFi:

Portal URL: https://netaccess.iitpkd.ac.in:1442/

1. Create WifiCredentials model:
   - username, password

2. Store credentials securely using flutter_secure_storage

3. WifiRepository:
   - saveCredentials()
   - getCredentials()
   - attemptLogin() -> makes POST to portal

4. UI:
   - "Save WiFi Credentials" form if not saved
   - "One Tap Login" button if credentials saved
   - Status indicator (Connected/Disconnected/Error)
   - "Forget Credentials" option
```

### PHASE 8: Bus Schedule
```
Add Bus Schedule feature with this data:

CAMPUS SHUTTLE (Nila ↔ Sahyadri):

WORKING DAYS:
Nila → Sahyadri: 8:30, 9:25, 9:45, 10:20, 10:45, 11:15, 11:50, 12:15, 12:30, 13:00, 13:30, 13:45, 14:15, 14:45, 15:20, 15:45, 16:30, 17:00, 17:15, 17:45, 18:00, 18:30, 19:00, 19:30, 20:00, 20:30, 21:00, 22:00, 23:00, 00:00

Sahyadri → Nila: 7:45, 8:15, 8:30, 8:45, 9:00, 9:25, 9:45, 10:20, 10:45, 11:15, 11:50, 12:15, 12:30, 13:00, 13:30, 13:45, 14:15, 14:45, 15:20, 15:45, 16:30, 17:00, 17:15, 17:45, 18:00, 18:30, 19:00, 19:30, 20:00, 21:15, 22:15, 23:15
(Multiple buses at times in bold: 8:30, 8:45, 9:00, 23:00, 23:15)

SATURDAYS:
Nila → Sahyadri: 8:30, 9:00, 9:30, 10:00, 10:30, 11:00, 11:30, 12:00, 12:30, 13:00, 13:30, 14:00, 14:30, 15:00, 15:30, 16:00, 16:30, 17:00, 17:15, 17:30, 18:00, 18:30, 19:00, 19:30, 20:00, 20:30, 21:00, 22:00, 23:00, 00:00

Sahyadri → Nila: 7:30, 8:00, 8:30, 9:00, 9:30, 10:00, 10:30, 11:00, 11:30, 12:00, 12:30, 13:00, 13:30, 14:00, 14:30, 15:00, 15:30, 16:00, 16:30, 17:00, 17:30, 18:00, 18:30, 19:00, 19:30, 20:15, 21:15, 22:15, 23:15

SUNDAYS:
Nila → Sahyadri: 8:45, 9:15, 10:00, 11:00, 12:00, 12:30, 13:15, 14:00, 15:00, 16:00, 17:00, 18:00, 18:30, 19:00, 19:30, 20:00, 20:30, 21:00, 22:00, 23:00, 00:00

Sahyadri → Nila: 8:00, 8:30, 9:00, 9:30, 10:15, 11:15, 12:15, 12:45, 13:30, 14:15, 15:15, 16:15, 17:15, 18:00, 18:30, 19:00, 19:30, 20:15, 21:15, 22:15, 23:15

PALAKKAD TOWN ROUTES (Working Days):
Route 1: Nila Gate 7:40 → Kadamkode → Manapullykavu → Maidaan → Stadium Bus Stand → Kalmandapam → Chandranagar → Pudussery → Nila Gate → Sahyadri 8:55 (Palakkad arrival: 8:25)

Route 2: Nila Gate 7:55 → Kalleppulley 8:25 → Koppam → Sekharipuram → Mattumantha → Malampuzha → Nila Gate → Sahyadri 8:55

Route 3: Palakkad 8:00 → Kadamkode → Manapullykavu → Maidaan → Stadium Bus Stand → Kalmandapam → Chandranagar → Pudussery → Nila Gate → Sahyadri 8:30

Route 4: Sahyadri 17:10 → Nila Gate → Pudussery → Kadamkode → Manapullykavu → Maidaan → Stadium Bus Stand → Palakkad 17:40 (Return: Stadium 17:45 → Chandranagar → Pudussery → Nila)

Route 5: Sahyadri 17:20 → Nila Manogata → Malampuzha Road → Mattumantha → Sekharipuram → Koppam → Kalleppulley 17:55

WISE PARK JUNCTION:
Working Days: Nila 8:15 → Wise Park 8:30 → Nila Manogata 8:45 → Sahyadri 9:00 | Sahyadri 18:15 → Nila Gate → Wise Park 18:45 → Nila Manogata 19:00

Sundays: No Palakkad Town or Wise Park routes

UI Requirements:
1. Three tabs: "Campus Shuttle" | "Town Routes" | "Wise Park"
2. Auto-detect day type (Working/Saturday/Sunday)
3. Show "Next bus in X mins" prominently
4. Direction toggle: Nila↔Sahyadri
5. Highlight multiple bus times
6. Pull-to-refresh for current time update
```

### PHASE 9: Mess Menu
```
Add Mess Menu feature with this data:

MEAL TIMINGS:
- Breakfast: 07:30 - 09:30
- Lunch: 12:00 - 14:00
- Snacks: 16:30 - 18:00
- Dinner: 19:30 - 21:30

COMMON ITEMS (Every day):
- Breakfast: Bread, Butter, Jam, Milk, Tea, Coffee, Sprouts/Chana, Seasonal Fruit
- Non-Veg Breakfast: Boiled Egg (5 days), Omelette (2 days)
- Lunch: Mix Pickle, Papad, Mix Salad, Onion, Lemon, White Rice
- Snacks: Tea, Coffee, Sugar
- Dinner: Appalam, Mixed Salad, Pickle

WEEK 1 & 3 MENU:

Monday:
- Breakfast: Aloo Paratha, Ketchup, Curd, Mint Chutney
- Lunch: Phulka, White Rice, Kerala Rice, Chana Masala, Arhar Dal, Sambar, Curd
- Snacks: Onion Kachori, Ketchup, Fried Chilly
- Dinner: Fried Rice, Phulka, Dal Tadka, Gobhi Manchurian

Tuesday:
- Breakfast: Masala Dosa, Tomato Chutney, Sambar
- Lunch: Puri, Aloo Palak, Sambar, Ridge Gourd, Buttermilk, Watermelon
- Snacks: Aloo Bonda, Ketchup
- Dinner: Phulka, Chole Masala, Jeera Rice, Dal, Raita, Ice-cream

Wednesday:
- Breakfast: Dal Kichdi, Coconut Chutney, Dahi Boondhi (Non-Veg: Omelette)
- Lunch: Chapathi, Green Peas Masala, Onion Raita, Rasam, Chana Dal Fry
- Snacks: Green Matar Chat
- Dinner: Veg: Hyderabadi Paneer | Non-Veg: Hyderabadi Chicken + White Rice, Moong Dal, Paratha, Laddu

Thursday:
- Breakfast: Puri, Chana Masala
- Lunch: Chapathi, Mix Dal, Malai Kofta, Bottle Gourd, Curd
- Snacks: Tikki Chat
- Dinner: Special Dal, Sambar, MASALA DOSA (UNLIMITED), Payasam, Rasam

Friday:
- Breakfast: Fried Idly, Vada, Sambar, Coconut Chutney (Non-Veg: Omelette)
- Lunch: Phulka, Kadai Veg, Sambar, Potato Cabbage, Buttermilk
- Snacks: Pungulu with Coconut Chutney
- Dinner: Veg: Paneer Butter Masala | Non-Veg: Chicken Gravy + Pulao, Chapathi, Badhusha

Saturday:
- Breakfast: Gobi Mix Veg Paratha, Ketchup, Coriander Chutney
- Lunch: Chapathi, Rajma Masala, Green Veg, Ginger Dal, Gongura Chutney, Curd
- Snacks: Samosa, Ketchup, Cold Coffee
- Dinner: Phulka, Green Peas Masala, Raw Banana Poriyal, Rasam, Buttermilk

Sunday:
- Breakfast: Onion Rava Dosa, Tomato Chutney, Sambar
- Lunch: Veg: Chilli Paneer + Dum Briyani | Non-Veg: Chicken Dum Briyani + Shorba, Raita, Aam Panna
- Snacks: Vada Pav, Fried Chilly, Coriander Chutney
- Dinner: Arhar Dal Tadka, Aloo Fry, Kadhi Pakoda, Rice, Chapati, Gulab Jamun

WEEK 2 & 4 MENU:

Monday:
- Breakfast: Aloo Paratha, Ketchup, Curd, Seasonal Fruit, Mint Chutney
- Lunch: Phulka, Ghee Rice, Aloo Chana Masala, Soya Chilly, Rasam, Buttermilk
- Snacks: Macaroni
- Dinner: Veg: Paneer Biryani | Non-Veg: Egg Biryani + Raita, Mutter Masala, Phulka, Makkan Peda

Tuesday:
- Breakfast: Upma, Vada, Coriander Chutney, Curd
- Lunch: Chole, Bhatura, Toor Dal, Watermelon, Green Mix Veg, Lemon Rice, Curd
- Snacks: Dahi Papdi Chat
- Dinner: Phulka, Methi Dal, Mix Veg, Sambar, Ice-cream

Wednesday:
- Breakfast: Puttu, Kadal Curry, Peanut Butter (Non-Veg: Omelette)
- Lunch: Chapathi, Methi Dal, Drumstick Gravy, Dondakaya, Rasam, Buttermilk
- Snacks: Mysore Bonda
- Dinner: Veg: Kadai Paneer | Non-Veg: Kadai Chicken + Pulao, Tawa Butter Naan

Thursday:
- Breakfast: Mini Chole Bhatura, Seasonal Fruit
- Lunch: Chapathi, Mutter Paneer Masala, Coriander Rice, Kollu Rasam, Potato Chips, Curd
- Snacks: Cutlet, Ketchup
- Dinner: Arhar Dal Tadka, Aloo Fry, Kadhi Pakoda, Rice, Chapati, Mysore Pak

Friday:
- Breakfast: Podi Dosa, Sambar, Tomato Chutney, Peanut Butter
- Lunch: Phulka, Navadhanya Masala, Sambar, Green Mix Veg, Watermelon Juice
- Snacks: Pani Puri
- Dinner: Veg: Paneer Butter Masala | Non-Veg: Chicken Gravy + Pulao, Chapathi, Fruit Vermicelli Sheera

Saturday:
- Breakfast: Mix-Veg Paratha, Mint Chutney, Curd (Non-Veg: Omelette)
- Lunch: Chapathi, Green Peas Pulav, Spinach Dal, Gobhi Capsicum, Masala Buttermilk
- Snacks: Samosa, Ketchup, Cold Coffee
- Dinner: Dal Makhani, Aloo Brinjal, Sambar, Phulka, Kheer

Sunday:
- Breakfast: Andhra Kara Dosa, Peanut Chutney, Sambar
- Lunch: Veg: Paneer Masala (Spicy) | Non-Veg: Chicken Masala (Spicy) + Puri, Briyani Rice, Raita, Fruit Juice
- Snacks: Pav Bhaji
- Dinner: Phulka, Baby Aloo Masala, Soya Chilli, Dal, Rasam

UI Requirements:
1. Auto-detect current week (1&3 or 2&4) from date
2. Show current meal highlighted based on time
3. Day selector with today highlighted
4. Veg/Non-Veg toggle switch
5. Meal timing indicators
6. Special items highlighted (e.g., "UNLIMITED Dosa!")
7. Pull down to see common items
```

### PHASE 10: Account Screen
```
Add Account/Settings screen:

1. Profile Section:
   - Student photo (or default avatar)
   - Name
   - Registration number
   - Branch/Department
   - Email

2. Settings:
   - Theme toggle (Light/Dark/System)
   - Notification preferences
   - WiFi credentials management

3. App Info:
   - Version number
   - About section
   - Developer credits
   - Privacy policy link

4. Actions:
   - Clear cache button
   - Logout button (clears session, returns to login)
```

---

## ✅ DATA EXTRACTION COMPLETE

All data has been extracted and is ready to use:
- ✅ Slot System - Complete with all slots and timings
- ✅ Bus Schedule - All routes for Working Days, Saturdays, and Sundays
- ✅ Mess Menu - Week 1/3 and Week 2/4 menus with all meals

---

## 💡 TIPS FOR CLAUDE CODE

1. **Use these prompts sequentially** - Complete each phase before moving to next
2. **Test after each phase** - Run `flutter run` and verify
3. **Report errors** - If something breaks, paste the error message
4. **Upload screenshots** - Show what the records portal pages look like for better parsing
5. **Be specific** - If a feature isn't working, describe exactly what's wrong

---

## 🌤️ WEATHER API SETUP (for Phase 4)

Option 1: wttr.in (No API key needed)
```
GET https://wttr.in/Palakkad?format=j1
```

Option 2: OpenWeatherMap (Free tier)
```
GET https://api.openweathermap.org/data/2.5/weather?lat=10.8676&lon=76.6524&appid=YOUR_API_KEY
```

---

## 🎨 IIT PALAKKAD BRAND COLORS

```dart
// lib/core/constants/app_colors.dart
class AppColors {
  static const Color primary = Color(0xFF1E3A8A);      // IIT Blue
  static const Color accent = Color(0xFFF59E0B);       // Gold
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
}
```
