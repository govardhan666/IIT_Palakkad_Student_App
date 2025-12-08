/// App-wide constants
class AppConstants {
  // App Info
  static const String appName = 'IIT PKD Student';
  static const String appVersion = '1.0.0';

  // IIT Palakkad Portal URLs
  static const String recordsPortal = 'https://records.iitpkd.ac.in';
  static const String courseRegistration = 'https://records.iitpkd.ac.in/course_registration';
  static const String gradesPortal = 'https://records.iitpkd.ac.in/grades';
  static const String facultyDirectory = 'https://iitpkd.ac.in/people';
  static const String wifiLogin = 'https://192.168.249.1:1442';

  // API Endpoints (to be configured)
  static const String weatherApiBase = 'https://wttr.in';

  // Storage Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserData = 'user_data';
  static const String keyWifiCredentials = 'wifi_credentials';
  static const String keyCourses = 'courses';
  static const String keyThemeMode = 'theme_mode';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheExpiry = Duration(hours: 24);
}

/// Meal Timings
class MealTimings {
  static const String breakfast = '7:30 AM - 9:30 AM';
  static const String lunch = '12:00 PM - 2:00 PM';
  static const String snacks = '4:30 PM - 6:00 PM';
  static const String dinner = '7:30 PM - 9:30 PM';
}
