import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/core/utils/extensions.dart';

class OnboardingItem extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  const OnboardingItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SvgPicture.asset(icon, width: 414.w, height: 434.h, fit: BoxFit.cover),
        SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.capitalizeWords(),
                style: AppTextStyles.headlineMedium.copyWith(
                  height: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15),
              Text(description, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
