import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:routiner/core/constants/app_constants.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/core/theme/app_theme.dart';
import 'package:routiner/core/utils/extensions.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/features/auth/presentation/widgets/background.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreen();
}

class _OtpVerificationScreen extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLG,
                vertical: AppDimensions.paddingXXL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimensions.height20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomButton(
                      text: "",
                      iconLeft: const Icon(Icons.arrow_back),
                      onPressed: () {
                        context.go(RouteConstants.signin);
                      },
                      borderRadius: 999,
                      height: 55,
                      width: 55,
                      bgColor: Colors.transparent,
                      borderWidth: 1,
                      borderColor: AppColors.textSubTitleColored,
                    ),
                  ),
                  SizedBox(height: AppDimensions.height29),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.enterOtpCode.capitalizeWords(),
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.height12),
                      Text(
                        AppConstants.enterOtpCodeDescription.capitalize(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: AppDimensions.height40),
                      Pinput(
                        defaultPinTheme: AppTheme.defaultPinTheme,
                        focusedPinTheme: AppTheme.focusedPinTheme,
                        validator: (s) {
                          return s == '222222' ? null : 'Pin is incorrect';
                        },
                        length: 6,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        closeKeyboardWhenCompleted: true,
                        keyboardType: TextInputType.number,

                        onCompleted: (pin) => print(pin),
                      ),
                      SizedBox(height: AppDimensions.height40),
                      CustomButton.primary(
                        text: AppConstants.continue_.capitalizeWords(),
                        onPressed: () {
                          context.go(RouteConstants.resetPassword);
                        },
                        isFullWidth: true,
                        size: ButtonSize.extraLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
