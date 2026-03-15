import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';


class AllSetSuccessScreen extends StatelessWidget {
  const AllSetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🌱',
                style: TextStyle(fontSize: 80.sp),
              ),
              SizedBox(height: AppDimensions.space24),
              Text(
                "You're all set!",
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppDimensions.space16),
              Text(
                'Your first habit is ready. Small steps, every day — that\'s how change happens.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: Material(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(28.r),
                  child: InkWell(
                    onTap: () => context.go(RouteConstants.home),
                    borderRadius: BorderRadius.circular(28.r),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start tracking',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '→',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
