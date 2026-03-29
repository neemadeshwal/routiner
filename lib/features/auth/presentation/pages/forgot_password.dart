import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/app_constants.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/core/utils/extensions.dart';
import 'package:routiner/core/utils/validators.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/core/widgets/custom/custom_input.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_event.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_state.dart';
import 'package:routiner/features/auth/presentation/widgets/background.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  void _handleContinue() {
    final email = _emailController.text.trim();
    if (_formKey.currentState!.validate()) {
      print('Email: $email');

      context.read<AuthBloc>().add(ForgotPasswordRequested(email: email));

      // context.go(RouteConstants.otpVerification);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Check your email for the password reset link'),
              backgroundColor: Colors.green,
            ),
          );
          // context.go(RouteConstants.signin);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final loading= state is AuthLoading;

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            AppConstants.forgotPassword.capitalizeWords(),
                            style: AppTextStyles.titleLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height12),
                          Text(
                            AppConstants.forgotPasswordDescription.capitalize(),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height40),
                          CustomInput(
                            label: AppConstants.emailAddress.capitalize(),
                            hint: AppConstants.emailAddress.capitalize(),
                            controller: _emailController,
                            validator: Validators.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: AppDimensions.height40),
                          CustomButton.primary(
                            isLoading: loading,
                            text: AppConstants.continue_.capitalizeWords(),
                            onPressed: loading?null: () {
                              _handleContinue();
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
      },
    );
  }
}
