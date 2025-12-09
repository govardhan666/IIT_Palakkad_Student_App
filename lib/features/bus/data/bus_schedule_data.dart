import '../domain/entities/bus_schedule.dart';

/// Complete bus schedule data for IIT Palakkad
class BusScheduleData {
  /// Campus to Ahalia (Weekdays)
  static const List<BusTrip> campusToAhaliaWeekday = [
    BusTrip(departureTime: '07:15', arrivalTime: '07:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '08:15', arrivalTime: '08:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '09:15', arrivalTime: '09:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '10:15', arrivalTime: '10:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '11:15', arrivalTime: '11:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '12:15', arrivalTime: '12:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '13:15', arrivalTime: '13:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '14:15', arrivalTime: '14:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '15:15', arrivalTime: '15:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '16:15', arrivalTime: '16:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '17:15', arrivalTime: '17:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '18:15', arrivalTime: '18:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '19:15', arrivalTime: '19:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '20:15', arrivalTime: '20:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '21:15', arrivalTime: '21:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '22:00', arrivalTime: '22:15', from: 'Campus', to: 'Ahalia'),
  ];

  /// Ahalia to Campus (Weekdays)
  static const List<BusTrip> ahaliaToCampusWeekday = [
    BusTrip(departureTime: '07:30', arrivalTime: '07:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '08:30', arrivalTime: '08:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '09:30', arrivalTime: '09:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '10:30', arrivalTime: '10:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '11:30', arrivalTime: '11:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '12:30', arrivalTime: '12:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '13:30', arrivalTime: '13:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '14:30', arrivalTime: '14:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '15:30', arrivalTime: '15:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '16:30', arrivalTime: '16:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '17:30', arrivalTime: '17:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '18:30', arrivalTime: '18:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '19:30', arrivalTime: '19:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '20:30', arrivalTime: '20:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '21:30', arrivalTime: '21:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '22:15', arrivalTime: '22:30', from: 'Ahalia', to: 'Campus'),
  ];

  /// Campus to Palakkad Town (Weekdays)
  static const List<BusTrip> campusToPalakkadWeekday = [
    BusTrip(departureTime: '07:00', arrivalTime: '07:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '09:00', arrivalTime: '09:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '12:00', arrivalTime: '12:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '14:00', arrivalTime: '14:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '17:00', arrivalTime: '17:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '19:00', arrivalTime: '19:45', from: 'Campus', to: 'Palakkad Town'),
  ];

  /// Palakkad Town to Campus (Weekdays)
  static const List<BusTrip> palakkadToCampusWeekday = [
    BusTrip(departureTime: '08:00', arrivalTime: '08:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '10:00', arrivalTime: '10:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '13:00', arrivalTime: '13:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '15:00', arrivalTime: '15:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '18:00', arrivalTime: '18:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '20:00', arrivalTime: '20:45', from: 'Palakkad Town', to: 'Campus'),
  ];

  /// Campus to Kanjikode (Weekdays)
  static const List<BusTrip> campusToKanjikodeWeekday = [
    BusTrip(departureTime: '08:00', arrivalTime: '08:20', from: 'Campus', to: 'Kanjikode'),
    BusTrip(departureTime: '11:00', arrivalTime: '11:20', from: 'Campus', to: 'Kanjikode'),
    BusTrip(departureTime: '14:00', arrivalTime: '14:20', from: 'Campus', to: 'Kanjikode'),
    BusTrip(departureTime: '17:00', arrivalTime: '17:20', from: 'Campus', to: 'Kanjikode'),
    BusTrip(departureTime: '20:00', arrivalTime: '20:20', from: 'Campus', to: 'Kanjikode'),
  ];

  /// Kanjikode to Campus (Weekdays)
  static const List<BusTrip> kanjikodetoCampusWeekday = [
    BusTrip(departureTime: '08:30', arrivalTime: '08:50', from: 'Kanjikode', to: 'Campus'),
    BusTrip(departureTime: '11:30', arrivalTime: '11:50', from: 'Kanjikode', to: 'Campus'),
    BusTrip(departureTime: '14:30', arrivalTime: '14:50', from: 'Kanjikode', to: 'Campus'),
    BusTrip(departureTime: '17:30', arrivalTime: '17:50', from: 'Kanjikode', to: 'Campus'),
    BusTrip(departureTime: '20:30', arrivalTime: '20:50', from: 'Kanjikode', to: 'Campus'),
  ];

  /// Campus to Ahalia (Saturday)
  static const List<BusTrip> campusToAhaliaSaturday = [
    BusTrip(departureTime: '07:15', arrivalTime: '07:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '08:15', arrivalTime: '08:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '09:15', arrivalTime: '09:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '10:15', arrivalTime: '10:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '11:15', arrivalTime: '11:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '12:15', arrivalTime: '12:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '13:15', arrivalTime: '13:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '14:15', arrivalTime: '14:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '15:15', arrivalTime: '15:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '16:15', arrivalTime: '16:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '17:15', arrivalTime: '17:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '18:15', arrivalTime: '18:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '19:15', arrivalTime: '19:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '20:15', arrivalTime: '20:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '21:15', arrivalTime: '21:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '22:00', arrivalTime: '22:15', from: 'Campus', to: 'Ahalia'),
  ];

  /// Ahalia to Campus (Saturday)
  static const List<BusTrip> ahaliaToCampusSaturday = [
    BusTrip(departureTime: '07:30', arrivalTime: '07:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '08:30', arrivalTime: '08:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '09:30', arrivalTime: '09:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '10:30', arrivalTime: '10:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '11:30', arrivalTime: '11:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '12:30', arrivalTime: '12:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '13:30', arrivalTime: '13:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '14:30', arrivalTime: '14:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '15:30', arrivalTime: '15:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '16:30', arrivalTime: '16:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '17:30', arrivalTime: '17:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '18:30', arrivalTime: '18:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '19:30', arrivalTime: '19:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '20:30', arrivalTime: '20:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '21:30', arrivalTime: '21:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '22:15', arrivalTime: '22:30', from: 'Ahalia', to: 'Campus'),
  ];

  /// Campus to Palakkad Town (Saturday)
  static const List<BusTrip> campusToPalakkadSaturday = [
    BusTrip(departureTime: '09:00', arrivalTime: '09:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '12:00', arrivalTime: '12:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '17:00', arrivalTime: '17:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '19:00', arrivalTime: '19:45', from: 'Campus', to: 'Palakkad Town'),
  ];

  /// Palakkad Town to Campus (Saturday)
  static const List<BusTrip> palakkadToCampusSaturday = [
    BusTrip(departureTime: '10:00', arrivalTime: '10:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '13:00', arrivalTime: '13:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '18:00', arrivalTime: '18:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '20:00', arrivalTime: '20:45', from: 'Palakkad Town', to: 'Campus'),
  ];

  /// Campus to Ahalia (Sunday)
  static const List<BusTrip> campusToAhaliaSunday = [
    BusTrip(departureTime: '08:15', arrivalTime: '08:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '10:15', arrivalTime: '10:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '12:15', arrivalTime: '12:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '14:15', arrivalTime: '14:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '16:15', arrivalTime: '16:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '18:15', arrivalTime: '18:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '20:15', arrivalTime: '20:30', from: 'Campus', to: 'Ahalia'),
    BusTrip(departureTime: '22:00', arrivalTime: '22:15', from: 'Campus', to: 'Ahalia'),
  ];

  /// Ahalia to Campus (Sunday)
  static const List<BusTrip> ahaliaToCampusSunday = [
    BusTrip(departureTime: '08:30', arrivalTime: '08:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '10:30', arrivalTime: '10:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '12:30', arrivalTime: '12:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '14:30', arrivalTime: '14:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '16:30', arrivalTime: '16:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '18:30', arrivalTime: '18:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '20:30', arrivalTime: '20:45', from: 'Ahalia', to: 'Campus'),
    BusTrip(departureTime: '22:15', arrivalTime: '22:30', from: 'Ahalia', to: 'Campus'),
  ];

  /// Campus to Palakkad Town (Sunday)
  static const List<BusTrip> campusToPalakkadSunday = [
    BusTrip(departureTime: '09:00', arrivalTime: '09:45', from: 'Campus', to: 'Palakkad Town'),
    BusTrip(departureTime: '17:00', arrivalTime: '17:45', from: 'Campus', to: 'Palakkad Town'),
  ];

  /// Palakkad Town to Campus (Sunday)
  static const List<BusTrip> palakkadToCampusSunday = [
    BusTrip(departureTime: '10:00', arrivalTime: '10:45', from: 'Palakkad Town', to: 'Campus'),
    BusTrip(departureTime: '18:00', arrivalTime: '18:45', from: 'Palakkad Town', to: 'Campus'),
  ];

  /// Get schedule for a specific route and day
  static List<BusTrip> getSchedule({
    required String from,
    required String to,
    required ScheduleDay day,
  }) {
    // Campus <-> Ahalia
    if (from == 'Campus' && to == 'Ahalia') {
      switch (day) {
        case ScheduleDay.weekday:
          return campusToAhaliaWeekday;
        case ScheduleDay.saturday:
          return campusToAhaliaSaturday;
        case ScheduleDay.sunday:
          return campusToAhaliaSunday;
      }
    }

    if (from == 'Ahalia' && to == 'Campus') {
      switch (day) {
        case ScheduleDay.weekday:
          return ahaliaToCampusWeekday;
        case ScheduleDay.saturday:
          return ahaliaToCampusSaturday;
        case ScheduleDay.sunday:
          return ahaliaToCampusSunday;
      }
    }

    // Campus <-> Palakkad
    if (from == 'Campus' && to == 'Palakkad Town') {
      switch (day) {
        case ScheduleDay.weekday:
          return campusToPalakkadWeekday;
        case ScheduleDay.saturday:
          return campusToPalakkadSaturday;
        case ScheduleDay.sunday:
          return campusToPalakkadSunday;
      }
    }

    if (from == 'Palakkad Town' && to == 'Campus') {
      switch (day) {
        case ScheduleDay.weekday:
          return palakkadToCampusWeekday;
        case ScheduleDay.saturday:
          return palakkadToCampusSaturday;
        case ScheduleDay.sunday:
          return palakkadToCampusSunday;
      }
    }

    // Campus <-> Kanjikode (weekdays only)
    if (from == 'Campus' && to == 'Kanjikode') {
      if (day == ScheduleDay.weekday) {
        return campusToKanjikodeWeekday;
      }
      return [];
    }

    if (from == 'Kanjikode' && to == 'Campus') {
      if (day == ScheduleDay.weekday) {
        return kanjikodetoCampusWeekday;
      }
      return [];
    }

    return [];
  }

  /// Get next upcoming bus for a route
  static BusTrip? getNextBus({
    required String from,
    required String to,
  }) {
    final day = getCurrentScheduleDay();
    final trips = getSchedule(from: from, to: to, day: day);

    for (final trip in trips) {
      if (trip.isUpcoming) {
        return trip;
      }
    }

    return null;
  }

  /// Available routes
  static const List<Map<String, String>> availableRoutes = [
    {'from': 'Campus', 'to': 'Ahalia'},
    {'from': 'Ahalia', 'to': 'Campus'},
    {'from': 'Campus', 'to': 'Palakkad Town'},
    {'from': 'Palakkad Town', 'to': 'Campus'},
    {'from': 'Campus', 'to': 'Kanjikode'},
    {'from': 'Kanjikode', 'to': 'Campus'},
  ];
}
