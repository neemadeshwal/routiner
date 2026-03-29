import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/features/activity/presentation/pages/activity_screen.dart';
import 'package:routiner/features/auth/presentation/pages/forgot_password.dart';
import 'package:routiner/features/auth/presentation/pages/otp_verification.dart';
import 'package:routiner/features/auth/presentation/pages/reset_password.dart';
import 'package:routiner/features/auth/presentation/pages/signin_screen.dart';
import 'package:routiner/features/auth/presentation/pages/signup_screen.dart';
import 'package:routiner/features/explore/presentation/pages/explore_screen.dart';
import 'package:routiner/features/home/presentation/pages/create_custom_habit_screen.dart';
import 'package:routiner/features/home/presentation/pages/home_screen.dart';
import 'package:routiner/core/constants/constants_imports.dart';
import 'package:routiner/features/home/presentation/pages/route_screen.dart';
import 'package:routiner/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:routiner/features/onboarding/presentation/pages/all_set_success_screen.dart';
import 'package:routiner/features/onboarding/presentation/pages/user_setup_screen.dart';
import 'package:routiner/features/onboarding/presentation/pages/welcome_screen.dart';
import 'package:routiner/features/profile/presentation/pages/profile_screen.dart';
import 'package:routiner/features/splash/presentation/pages/splash_screen.dart';

class RouteConfig {
  RouteConfig._();

  /// Used for overlays (e.g. biometric dialog) — `MaterialApp.router` builder context has no [Navigator].
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteConstants.splash,
    routes: [
      GoRoute(
        path: RouteConstants.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteConstants.onBoarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteConstants.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RouteConstants.signin,
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: RouteConstants.signup,

        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(path: RouteConstants.forgotPassword,builder: (context,state)=>const ForgotPasswordScreen()),
      GoRoute(path:RouteConstants.otpVerification,builder:(context,state)=>const OtpVerificationScreen()),
      GoRoute(path:RouteConstants.resetPassword,builder:(context,state)=>const ResetPasswordScreen()),
      GoRoute(
        path: RouteConstants.userSetup,
        builder: (context, state) => const UserSetupScreen(),
      ),
      GoRoute(
        path: RouteConstants.allSetSuccess,
        builder: (context, state) => const AllSetSuccessScreen(),
      ),
      GoRoute(
        path: RouteConstants.createCustomHabit,
        builder: (context, state) {
          final quit = state.extra == true;
          return CreateCustomHabitScreen(initialQuitSelected: quit);
        },
      ),
        ShellRoute(
          builder: (context, state, child) => RouteScreen(
            currentPath: state.uri.path,
            child: child,
          ),
          routes: [
          GoRoute(path: RouteConstants.home,pageBuilder: (context,state)=>const NoTransitionPage(child: HomeScreen())),
          GoRoute(path: RouteConstants.activity,pageBuilder: (context,state)=>const NoTransitionPage(child: ActivityScreen())),
          GoRoute(path: RouteConstants.explore,pageBuilder: (context,state)=>const NoTransitionPage(child: ExploreScreen())),
          GoRoute(path: RouteConstants.profile,pageBuilder: (context,state)=>const NoTransitionPage(child: ProfileScreen())),
        ],
        ),
    ],
  );
  static GoRouter get router => _router;
}
