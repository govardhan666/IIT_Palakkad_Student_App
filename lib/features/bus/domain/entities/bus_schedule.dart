/// Bus trip entity
class BusTrip {
  final String departureTime;
  final String arrivalTime;
  final String from;
  final String to;
  final String? busNumber;
  final String? notes;

  const BusTrip({
    required this.departureTime,
    required this.arrivalTime,
    required this.from,
    required this.to,
    this.busNumber,
    this.notes,
  });

  /// Parse time string to DateTime for comparison
  DateTime get departureDateTime {
    final parts = departureTime.split(':');
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  /// Check if this trip is upcoming (departure time is in the future)
  bool get isUpcoming {
    final now = DateTime.now();
    return departureDateTime.isAfter(now);
  }

  /// Get duration until departure
  Duration get timeUntilDeparture {
    return departureDateTime.difference(DateTime.now());
  }

  /// Format time until departure as string
  String get timeUntilDepartureFormatted {
    final duration = timeUntilDeparture;
    if (duration.isNegative) return 'Departed';
    if (duration.inMinutes < 1) return 'Now';
    if (duration.inMinutes < 60) return '${duration.inMinutes} min';
    final hours = duration.inHours;
    final mins = duration.inMinutes % 60;
    if (mins == 0) return '$hours hr';
    return '$hours hr $mins min';
  }
}

/// Bus route type
enum BusRouteType {
  toAhalia,
  toCampus,
  toPalakkad,
  toKanjikode,
}

/// Day type for schedule
enum ScheduleDay {
  weekday,
  saturday,
  sunday,
}

/// Get current schedule day
ScheduleDay getCurrentScheduleDay() {
  final now = DateTime.now();
  if (now.weekday == DateTime.saturday) return ScheduleDay.saturday;
  if (now.weekday == DateTime.sunday) return ScheduleDay.sunday;
  return ScheduleDay.weekday;
}

/// Get day name from schedule day
String getScheduleDayName(ScheduleDay day) {
  switch (day) {
    case ScheduleDay.weekday:
      return 'Weekdays';
    case ScheduleDay.saturday:
      return 'Saturday';
    case ScheduleDay.sunday:
      return 'Sunday';
  }
}
