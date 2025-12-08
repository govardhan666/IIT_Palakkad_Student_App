import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/timetable/data/repositories/course_repository_impl.dart';
import 'features/timetable/presentation/bloc/course_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const IITPKDStudentApp());
}

class IITPKDStudentApp extends StatefulWidget {
  const IITPKDStudentApp({super.key});

  @override
  State<IITPKDStudentApp> createState() => _IITPKDStudentAppState();
}

class _IITPKDStudentAppState extends State<IITPKDStudentApp> {
  late final AuthRepositoryImpl _authRepository;
  late final AuthBloc _authBloc;
  late final CourseRepositoryImpl _courseRepository;
  late final CourseBloc _courseBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    // Initialize repositories
    _authRepository = AuthRepositoryImpl();

    // Initialize AuthBloc
    _authBloc = AuthBloc(authRepository: _authRepository);

    // Initialize CourseRepository with auth dependency
    _courseRepository = CourseRepositoryImpl(authRepository: _authRepository);

    // Initialize CourseBloc
    _courseBloc = CourseBloc(courseRepository: _courseRepository);

    // Initialize router with AuthBloc for route protection
    _appRouter = AppRouter(authBloc: _authBloc);

    // Check authentication status on app start (auto-login)
    _authBloc.add(const AuthCheckRequested());
  }

  @override
  void dispose() {
    _authBloc.close();
    _courseBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<CourseBloc>.value(value: _courseBloc),
      ],
      child: MaterialApp.router(
        title: 'IIT PKD Student',
        debugShowCheckedModeBanner: false,

        // Theme
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,

        // Router with authentication
        routerConfig: _appRouter.router,
      ),
    );
  }
}
