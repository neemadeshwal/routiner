import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/app_constants.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/core/utils/extensions.dart';
import 'package:routiner/core/utils/validators.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/core/widgets/custom/custom_input.dart'
    show CustomInput;
import 'package:routiner/features/auth/presentation/widgets/background.dart';
import 'package:routiner/features/auth/presentation/widgets/password_toggle.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
 bool _showPassword = false;
  void _handleContinue() {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    if (_formKey.currentState!.validate()) {
      print('New Password: $newPassword');
      print('Confirm Password: $confirmPassword');
    }
  }

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
                      iconLeft: Icon(Icons.arrow_back),
                      onPressed: () {
                        context.go(RouteConstants.otpVerification);
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
                  Text(
                    AppConstants.resetPassword.capitalizeWords(),
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppDimensions.height20),
                  Text(
                    AppConstants.resetPasswordDescription.capitalize(),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.height40),
                  CustomInput(
                    label: AppConstants.newPassword.capitalize(),
                    hint: AppConstants.newPassword.capitalize(),
                                    obscureText: !_showPassword,

                    controller: _newPasswordController,
                                    validator: Validators.strongPassword,

                    textInputAction: TextInputAction.next,
                     iconRight: PasswordToggle(
                                      showPassword: _showPassword,
                                      onToggle: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                  ),
                  SizedBox(height: AppDimensions.height40),
                  CustomInput(
                    label: AppConstants.confirmPassword.capitalize(),
                    hint: AppConstants.confirmPassword.capitalize(),
                    obscureText: true,
                    controller: _confirmPasswordController,
                    validator: Validators.password,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: AppDimensions.height40),
                  CustomButton.primary(
                    text: AppConstants.continue_.capitalizeWords(),
                    onPressed: () {
                      _handleContinue();
                    },
                    isFullWidth: true,
                    size: ButtonSize.extraLarge,
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
