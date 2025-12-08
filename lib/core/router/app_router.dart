import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/timetable/presentation/screens/timetable_screen.dart';
import '../../features/bus_schedule/presentation/screens/bus_schedule_screen.dart';
import '../../features/mess_menu/presentation/screens/mess_menu_screen.dart';
import '../../features/account/presentation/screens/account_screen.dart';
import '../../shared/widgets/main_scaffold.dart';

/// Route paths
class AppRoutes {
  static const String home = '/';
  static const String timetable = '/timetable';
  static const String busSchedule = '/bus-schedule';
  static const String messMenu = '/mess-menu';
  static const String account = '/account';
}

/// Global navigator keys for shell navigation
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

/// App Router Configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      /// Shell Route for Bottom Navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          /// Home Tab
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),

          /// Timetable Tab
          GoRoute(
            path: AppRoutes.timetable,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TimetableScreen(),
            ),
          ),

          /// Bus Schedule Tab
          GoRoute(
            path: AppRoutes.busSchedule,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BusScheduleScreen(),
            ),
          ),

          /// Mess Menu Tab
          GoRoute(
            path: AppRoutes.messMenu,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MessMenuScreen(),
            ),
          ),

          /// Account Tab
          GoRoute(
            path: AppRoutes.account,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
