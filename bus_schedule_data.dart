/// IIT Palakkad Bus Schedule Data
/// Last Updated: 30/Jul/2025
/// Source: IIT Palakkad Transport Department

class BusScheduleData {
  BusScheduleData._();

  static const String lastUpdated = '30/Jul/2025';

  // ============================================================
  // CAMPUS SHUTTLE: NILA <-> SAHYADRI
  // ============================================================

  static const Map<String, CampusShuttleSchedule> campusShuttle = {
    'workingDays': CampusShuttleSchedule(
      nilaToSahyadri: [
        '08:30', '09:25', '09:45', '10:20', '10:45', '11:15', '11:50', '12:15', '12:30',
        '13:00', '13:30', '13:45', '14:15', '14:45', '15:20', '15:45', '16:30', '17:00', '17:15', '17:45', '18:00',
        '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '22:00', '23:00', '00:00',
      ],
      sahyadriToNila: [
        '07:45', '08:15', '08:30', '08:45', '09:00', '09:25', '09:45', '10:20', '10:45',
        '11:15', '11:50', '12:15', '12:30', '13:00', '13:30', '13:45', '14:15', '14:45', '15:20', '15:45', '16:30',
        '17:00', '17:15', '17:45', '18:00', '18:30', '19:00', '19:30', '20:00', '21:15', '22:15', '23:15',
      ],
      multipleBusTimes: ['08:30', '08:45', '09:00', '23:00', '23:15'],
    ),
    'saturdays': CampusShuttleSchedule(
      nilaToSahyadri: [
        '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30',
        '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:15', '17:30', '18:00',
        '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '22:00', '23:00', '00:00',
      ],
      sahyadriToNila: [
        '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
        '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30',
        '18:00', '18:30', '19:00', '19:30', '20:15', '21:15', '22:15', '23:15',
      ],
    ),
    'sundays': CampusShuttleSchedule(
      nilaToSahyadri: [
        '08:45', '09:15', '10:00', '11:00', '12:00', '12:30', '13:15', '14:00', '15:00',
        '16:00', '17:00', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '22:00', '23:00', '00:00',
      ],
      sahyadriToNila: [
        '08:00', '08:30', '09:00', '09:30', '10:15', '11:15', '12:15', '12:45', '13:30',
        '14:15', '15:15', '16:15', '17:15', '18:00', '18:30', '19:00', '19:30', '20:15', '21:15', '22:15', '23:15',
      ],
    ),
  };

  // ============================================================
  // PALAKKAD TOWN ROUTES
  // ============================================================

  static const List<TownRoute> palakkadTownWorkingDays = [
    TownRoute(
      routeId: 1,
      name: 'Nila Gate to Palakkad (Morning)',
      departure: '07:40',
      from: 'Nila Gate',
      stops: [
        BusStop('Nila Gate', '07:40'),
        BusStop('Kadamkode', null),
        BusStop('Manapullykavu', null),
        BusStop('Maidaan (Govt. Hospital)', null),
        BusStop('Stadium Bus Stand', null),
        BusStop('Kalmandapam', null),
        BusStop('Chandranagar', null),
        BusStop('Pudussery', null),
        BusStop('Nila Gate', null),
        BusStop('Sahyadri', '08:55'),
      ],
      note: 'Priority to those staying outside campus. Palakkad arrival: 08:25',
    ),
    TownRoute(
      routeId: 2,
      name: 'Nila Gate via Malampuzha (Morning)',
      departure: '07:55',
      from: 'Nila Gate',
      stops: [
        BusStop('Nila Gate', '07:55'),
        BusStop('Kalleppulley', '08:25'),
        BusStop('Koppam', null),
        BusStop('Sekharipuram', null),
        BusStop('Mattumantha', null),
        BusStop('Malampuzha', null),
        BusStop('Nila Gate', null),
        BusStop('Sahyadri', '08:55'),
      ],
    ),
    TownRoute(
      routeId: 3,
      name: 'Palakkad to Sahyadri (Morning)',
      departure: '08:00',
      from: 'Palakkad',
      stops: [
        BusStop('Palakkad', '08:00'),
        BusStop('Kadamkode', null),
        BusStop('Manapullykavu', null),
        BusStop('Maidaan (Govt. Hospital)', null),
        BusStop('Stadium Bus Stand', null),
        BusStop('Kalmandapam', null),
        BusStop('Chandranagar', null),
        BusStop('Pudussery', null),
        BusStop('Nila Gate', null),
        BusStop('Sahyadri', '08:30'),
      ],
    ),
    TownRoute(
      routeId: 4,
      name: 'Sahyadri to Palakkad (Evening)',
      departure: '17:10',
      from: 'Sahyadri',
      stops: [
        BusStop('Sahyadri', '17:10'),
        BusStop('Nila Gate', null),
        BusStop('Pudussery', null),
        BusStop('Kadamkode', null),
        BusStop('Manapullykavu', null),
        BusStop('Maidaan (Govt. Hospital)', null),
        BusStop('Stadium Bus Stand', null),
        BusStop('Palakkad', '17:40'),
      ],
      note: 'Return: Stadium Bus Stand 17:45 → Chandranagar → Pudussery → Nila. On Fridays: Sahyadri 17:10 to Kinar Stop',
    ),
    TownRoute(
      routeId: 5,
      name: 'Sahyadri via Malampuzha (Evening)',
      departure: '17:20',
      from: 'Sahyadri',
      stops: [
        BusStop('Sahyadri', '17:20'),
        BusStop('Nila Manogata', null),
        BusStop('Malampuzha Road', null),
        BusStop('Mattumantha', null),
        BusStop('Sekharipuram', null),
        BusStop('Koppam', null),
        BusStop('Kalleppulley', '17:55'),
      ],
      note: 'Return: Sekharipuram 17:50 → Chandranagar → Pudussery → Nila',
    ),
  ];

  static const List<TownRoute> palakkadTownSaturdays = [
    // Routes 1, 2, 4 same as working days, plus:
    TownRoute(
      routeId: 6,
      name: 'Sahyadri to Palakkad (Afternoon)',
      departure: '13:00',
      from: 'Sahyadri',
      stops: [
        BusStop('Sahyadri', '13:00'),
        BusStop('Nila Gate', null),
        BusStop('Pudussery', null),
        BusStop('Kadamkode', null),
        BusStop('Manapullykavu', null),
        BusStop('Maidaan (Govt. Hospital)', null),
        BusStop('Stadium Bus Stand', null),
        BusStop('Palakkad', '13:30'),
      ],
      note: 'Return: Stadium Bus Stand 13:30 → Chandranagar → Pudussery → Nila → Saraswati (14:00)',
    ),
  ];

  // No Palakkad Town routes on Sundays

  // ============================================================
  // WISE PARK JUNCTION ROUTES
  // ============================================================

  static const List<TownRoute> wiseParkWorkingDays = [
    TownRoute(
      routeId: 1,
      name: 'Wise Park Morning Route',
      departure: '08:15',
      from: 'Nila',
      stops: [
        BusStop('Nila', '08:15'),
        BusStop('Wise Park Junction', '08:30'),
        BusStop('Nila Manogata', '08:45'),
        BusStop('Sahyadri', '09:00'),
      ],
      note: 'Service roads only',
    ),
    TownRoute(
      routeId: 2,
      name: 'Wise Park Evening Route',
      departure: '18:15',
      from: 'Sahyadri',
      stops: [
        BusStop('Sahyadri', '18:15'),
        BusStop('Nila Gate', null),
        BusStop('Wise Park Junction', '18:45'),
        BusStop('Nila Manogata', '19:00'),
      ],
      note: 'Service roads only',
    ),
  ];

  static const List<TownRoute> wiseParkSaturdays = [
    TownRoute(
      routeId: 1,
      name: 'Wise Park Morning Route',
      departure: '08:45',
      from: 'Nila',
      stops: [
        BusStop('Nila', '08:45'),
        BusStop('Wise Park Junction', '09:00'),
        BusStop('Nila Manogata', '09:15'),
        BusStop('Sahyadri', '09:30'),
      ],
      note: 'Service roads only',
    ),
    TownRoute(
      routeId: 2,
      name: 'Wise Park Evening Route',
      departure: '18:15',
      from: 'Sahyadri',
      stops: [
        BusStop('Sahyadri', '18:15'),
        BusStop('Nila Gate', null),
        BusStop('Wise Park Junction', '18:45'),
        BusStop('Nila Manogata', '19:00'),
      ],
    ),
  ];

  // No Wise Park routes on Sundays

  // ============================================================
  // HELPER METHODS
  // ============================================================

  /// Get the appropriate schedule based on day type
  static CampusShuttleSchedule getScheduleForDay(DateTime date) {
    if (date.weekday == DateTime.sunday) {
      return campusShuttle['sundays']!;
    } else if (date.weekday == DateTime.saturday) {
      return campusShuttle['saturdays']!;
    } else {
      return campusShuttle['workingDays']!;
    }
  }

  /// Get next bus time from current time
  static String? getNextBus(List<String> schedule, String currentTime) {
    for (final time in schedule) {
      if (time.compareTo(currentTime) > 0) {
        return time;
      }
    }
    return null; // No more buses today
  }

  /// Get day type string
  static String getDayType(DateTime date) {
    if (date.weekday == DateTime.sunday) {
      return 'Sunday';
    } else if (date.weekday == DateTime.saturday) {
      return 'Saturday';
    } else {
      return 'Working Day';
    }
  }
}

// ============================================================
// DATA MODELS
// ============================================================

class CampusShuttleSchedule {
  final List<String> nilaToSahyadri;
  final List<String> sahyadriToNila;
  final List<String>? multipleBusTimes;

  const CampusShuttleSchedule({
    required this.nilaToSahyadri,
    required this.sahyadriToNila,
    this.multipleBusTimes,
  });
}

class TownRoute {
  final int routeId;
  final String name;
  final String departure;
  final String from;
  final List<BusStop> stops;
  final String? note;

  const TownRoute({
    required this.routeId,
    required this.name,
    required this.departure,
    required this.from,
    required this.stops,
    this.note,
  });
}

class BusStop {
  final String name;
  final String? time;

  const BusStop(this.name, this.time);
}
