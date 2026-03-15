import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/constants_imports.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  // When we use const,flutter remembers the widget and doesn't rebuild it when the state or properties hasn't changed, won't relocate new memory to the widget and use the same old one.
  // This improves the performance significantly,reduces workload of garbage collector.

  // {}- this leads to named parameters

  // super.key-> automatically takes key passed to this widget and passes it to the parent widget which is stateful widget in this case.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
// create state- > this is the method that flutter calls the very first time the widget is inserted in the tree
// it only runs once and from that point on, the state object lives on even if the widget itself is rebuilt.

// Why the split is required?>?

// ----> the split is required because the state of the widget can change over time, and we want to keep the logic that manages that state separate from the widget's structure and appearance. By splitting the widget into a StatefulWidget and its corresponding State class, we can ensure that the widget can rebuild itself when necessary without losing its state. The StatefulWidget is responsible for creating the State object, which holds the mutable state and contains the logic for updating that state. This separation allows for better organization and maintainability of the code.
// Widget is cheap and get thrown away and rebuilt constantly, but the state is expensive and stays in memory.
class _SplashScreenState extends State<SplashScreen> {
  bool _minDelayDone = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _minDelayDone = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final state = context.read<AuthBloc>().state;
        _navigateFromAuth(state);
      });
    });
  }

  void _navigateFromAuth(AuthState state) {
    if (!_minDelayDone || !mounted) return;
    // Only navigate if we're still on the splash route (avoid reacting after user navigated to signup/signin)
    final currentPath = GoRouter.of(context).routerDelegate
        .currentConfiguration.uri.path;
    if (currentPath != RouteConstants.splash && currentPath != '/') return;
    if (state is Authenticated) {
      context.go(RouteConstants.home);
    } else if (state is Unauthenticated || state is AuthError) {
      context.go(RouteConstants.onBoarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is Authenticated ||
          current is Unauthenticated ||
          current is AuthError,
      listener: (context, state) {
        _navigateFromAuth(state);
      },
      child: Scaffold(
      body: Container(
        decoration: AppColors.backgroundGradient,
        // SafeArea is a widget that ensures your app's content is positioned within the "visible" parts of a device's screen.

        //It automatically adds enough padding to prevent your UI from being obscured by hardware features like notches, camera holes, or system status bars (the area where the clock and battery icon live).
        child: SafeArea(
          child: Center(
            //In Flutter, the Stack widget allows you to place multiple children on top of each other. Think of it like a deck of cards or layers in Photoshop—the first widget in the list is the bottom layer, and subsequent widgets are painted over it.
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  IconsAssets.circleBackground,
                  width: AppDimensions.icon5XHuge,
                ),
                SvgPicture.asset(
                  IconsAssets.logo,
                  width: AppDimensions.logoWidth,
                  height: AppDimensions.logoHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
