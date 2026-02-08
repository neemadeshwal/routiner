import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/assets_constants.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/theme_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        context.go(RouteConstants.onBoarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppColors.backgroundGradient,

        child: SafeArea(
          child: Center(
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
    );
  }
}
