import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/features/home/presentation/pages/home_screen.dart';
import 'package:routiner/core/constants/constants_imports.dart';
import 'package:routiner/features/splash/presentation/pages/splash_screen.dart';

class RouteConfig {
  RouteConfig._();
  static final GoRouter _router = GoRouter(
    initialLocation: RouteConstants.splash,
    routes: [
      GoRoute(
        path: RouteConstants.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteConstants.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
  static GoRouter get router => _router;
}
