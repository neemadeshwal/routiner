import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routiner/core/constants/assets_constants.dart';
import 'package:routiner/core/theme/theme_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
