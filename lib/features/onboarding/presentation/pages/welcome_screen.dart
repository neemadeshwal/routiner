import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/constants_imports.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/core/utils/extensions.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySoft,

      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesAssets.welcomeBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconsAssets.logo,
                width: AppDimensions.logoWidthSM,
                height: AppDimensions.logoHeightSM,
              ),
              SizedBox(height: 30),
              Text(
                AppConstants.welcomeTitle.capitalizeWords(),
                style: AppTextStyles.titleXl.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  AppConstants.welcomeSubtitle.capitalize(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleSmall,
                ),
              ),
              const Spacer(),
              CustomButton.primary(
                text: AppConstants.getStarted.toUpperCase(),
                isFullWidth: true,
                bgColor: Colors.white,
                textColor: AppColors.shimmerDark,
                size: ButtonSize.extraLarge,
                onPressed: () {
                  context.go(RouteConstants.signin);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
