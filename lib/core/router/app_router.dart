import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/timetable/presentation/screens/timetable_screen.dart';
import '../../features/bus_schedule/presentation/screens/bus_schedule_screen.dart';
import '../../features/mess_menu/presentation/screens/mess_menu_screen.dart';
import '../../features/account/presentation/screens/account_screen.dart';
import '../../features/grades/presentation/screens/grades_screen.dart';
import '../../features/exams/presentation/screens/exams_screen.dart';
import '../../features/faculty/presentation/screens/faculty_screen.dart';
import '../../features/wifi/presentation/screens/wifi_screen.dart';
import '../../shared/widgets/main_scaffold.dart';

/// Route paths
class AppRoutes {
  static const String login = '/login';
  static const String home = '/';
  static const String timetable = '/timetable';
  static const String busSchedule = '/bus-schedule';
  static const String messMenu = '/mess-menu';
  static const String account = '/account';

  // Quick access routes
  static const String grades = '/grades';
  static const String exams = '/exams';
  static const String faculty = '/faculty';
  static const String wifi = '/wifi';
}

/// Global navigator keys for shell navigation
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

/// App Router Configuration with Authentication
class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: _guardRoute,
    routes: [
      /// Login Route (outside shell)
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      /// Grades Route (outside shell, pushes on top)
      GoRoute(
        path: AppRoutes.grades,
        builder: (context, state) => const GradesScreen(),
      ),

      /// Exams Route (outside shell, pushes on top)
      GoRoute(
        path: AppRoutes.exams,
        builder: (context, state) => const ExamsScreen(),
      ),

      /// Faculty Route (outside shell, pushes on top)
      GoRoute(
        path: AppRoutes.faculty,
        builder: (context, state) => const FacultyScreen(),
      ),

      /// WiFi Route (outside shell, pushes on top)
      GoRoute(
        path: AppRoutes.wifi,
        builder: (context, state) => const WifiScreen(),
      ),

      /// Shell Route for Bottom Navigation (protected)
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

  /// Route guard that redirects based on authentication state
  String? _guardRoute(BuildContext context, GoRouterState state) {
    final authState = authBloc.state;
    final isLoggingIn = state.matchedLocation == AppRoutes.login;

    // If still checking auth, don't redirect yet
    if (authState is AuthInitial || authState is AuthLoading) {
      return null;
    }

    // If authenticated
    if (authState is AuthAuthenticated) {
      // Redirect away from login page if already authenticated
      if (isLoggingIn) {
        return AppRoutes.home;
      }
      return null;
    }

    // If not authenticated (Unauthenticated or Error state)
    if (!isLoggingIn) {
      return AppRoutes.login;
    }

    return null;
  }
}

/// Stream wrapper for GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
