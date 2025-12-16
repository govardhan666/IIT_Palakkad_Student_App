import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/bus_schedule_data.dart';
import '../../domain/entities/bus_schedule.dart';

/// Bus schedule screen with routes and timings
class BusScheduleScreen extends StatefulWidget {
  const BusScheduleScreen({super.key});

  @override
  State<BusScheduleScreen> createState() => _BusScheduleScreenState();
}

class _BusScheduleScreenState extends State<BusScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScheduleDay _selectedDay;
  Timer? _timer;

  // Route indices
  static const int _campusToAhalia = 0;
  static const int _ahaliaToCampus = 1;
  static const int _campusToPalakkad = 2;
  static const int _palakkadToCampus = 3;
  static const int _campusToKanjikode = 4;
  static const int _kanjikodetoCampus = 5;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _selectedDay = getCurrentScheduleDay();

    // Update every minute for countdown
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Schedule'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Campus → Ahalia'),
            Tab(text: 'Ahalia → Campus'),
            Tab(text: 'Campus → Palakkad'),
            Tab(text: 'Palakkad → Campus'),
            Tab(text: 'Campus → Kanjikode'),
            Tab(text: 'Kanjikode → Campus'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Day selector
          _buildDaySelector(),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildScheduleList('Campus', 'Ahalia'),
                _buildScheduleList('Ahalia', 'Campus'),
                _buildScheduleList('Campus', 'Palakkad Town'),
                _buildScheduleList('Palakkad Town', 'Campus'),
                _buildScheduleList('Campus', 'Kanjikode'),
                _buildScheduleList('Kanjikode', 'Campus'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      padding: const EdgeInsets.all(16),
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
          const Icon(Icons.calendar_today, size: 20),
          const SizedBox(width: 12),
          const Text('Day:'),
          const SizedBox(width: 12),
          Expanded(
            child: SegmentedButton<ScheduleDay>(
              segments: const [
                ButtonSegment(
                  value: ScheduleDay.weekday,
                  label: Text('Weekdays'),
                ),
                ButtonSegment(
                  value: ScheduleDay.saturday,
                  label: Text('Sat'),
                ),
                ButtonSegment(
                  value: ScheduleDay.sunday,
                  label: Text('Sun'),
                ),
              ],
              selected: {_selectedDay},
              onSelectionChanged: (selection) {
                setState(() => _selectedDay = selection.first);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleList(String from, String to) {
    final trips = BusScheduleData.getSchedule(
      from: from,
      to: to,
      day: _selectedDay,
    );

    if (trips.isEmpty) {
      return _buildNoService(from, to);
    }

    // Find next bus
    BusTrip? nextBus;
    if (_selectedDay == getCurrentScheduleDay()) {
      for (final trip in trips) {
        if (trip.isUpcoming) {
          nextBus = trip;
          break;
        }
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildNextBusCard(nextBus, from, to);
        }

        final trip = trips[index - 1];
        final isNext = nextBus != null &&
            trip.departureTime == nextBus.departureTime &&
            _selectedDay == getCurrentScheduleDay();
        final isPast = _selectedDay == getCurrentScheduleDay() && !trip.isUpcoming && !isNext;

        return _buildTripCard(trip, isNext: isNext, isPast: isPast);
      },
    );
  }

  Widget _buildNextBusCard(BusTrip? nextBus, String from, String to) {
    if (nextBus == null || _selectedDay != getCurrentScheduleDay()) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Text(
              _selectedDay == getCurrentScheduleDay()
                  ? 'No more buses today'
                  : 'Viewing ${getScheduleDayName(_selectedDay)} schedule',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                child: const Text(
                  'NEXT BUS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.directions_bus,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nextBus.departureTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$from → $to',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  nextBus.timeUntilDepartureFormatted,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTripCard(BusTrip trip, {bool isNext = false, bool isPast = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isNext
            ? AppColors.primary.withOpacity(0.1)
            : isPast
                ? Theme.of(context).cardColor.withOpacity(0.5)
                : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: isNext
            ? Border.all(color: AppColors.primary, width: 2)
            : Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isNext
                ? AppColors.primary.withOpacity(0.2)
                : isPast
                    ? AppColors.textSecondary.withOpacity(0.1)
                    : AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.directions_bus,
            color: isNext
                ? AppColors.primary
                : isPast
                    ? AppColors.textSecondary
                    : AppColors.success,
          ),
        ),
        title: Text(
          trip.departureTime,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isPast
                ? AppColors.textSecondary
                : Theme.of(context).textTheme.bodyLarge?.color,
            decoration: isPast ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          'Arrives ${trip.arrivalTime}',
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: isNext && _selectedDay == getCurrentScheduleDay()
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  trip.timeUntilDepartureFormatted,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : isPast
                ? Text(
                    'Departed',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  )
                : null,
      ),
    );
  }

  Widget _buildNoService(String from, String to) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_transfer,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No Service',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'There is no bus service from $from to $to on ${getScheduleDayName(_selectedDay)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
