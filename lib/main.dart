import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routiner/core/config/route_config.dart';
import 'package:routiner/core/theme/app_theme.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:routiner/firebase_options.dart';
import 'package:routiner/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized!');
  } catch (e) {
    print('❌ Firebase error: $e');
  }
  await GoogleSignIn.instance.initialize();
  await di.init();
  print('✅ Dependencies initialized!');
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => di.sl<AuthBloc>()..add(CheckAuthStatusRequested()),
      child: BlocProvider<UserSetupBloc>(
        create: (context) => di.sl<UserSetupBloc>(),
        child: const MyApp(),
      ),
    ),

    // const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = RouteConfig.router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) => MaterialApp.router(
        title: 'Routiner',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: _router,
        builder: (context, widget) {
          return widget!;
        },
      ),
    );
  }
}
