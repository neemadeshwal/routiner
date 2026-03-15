import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/constants_imports.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/core/utils/extensions.dart';
import 'package:routiner/core/utils/validators.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/core/widgets/custom/custom_input.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_event.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_state.dart';
import 'package:routiner/features/auth/presentation/widgets/auth_widgets.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  @override
  State<SigninScreen> createState() => _SigninScreen();
}

class _SigninScreen extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  void _handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    print('Email: $email');
    print('Password: $password');

    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignInRequested(email: email, password: password),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is Authenticated || current is AuthError,
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(RouteConstants.userSetup);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final loading = state is AuthLoading;
        return Scaffold(
          body: Stack(
            children: [
              const Background(),
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLG,
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
                                      onPressed: () {},
                                      borderRadius: 999,
                                      height: 55,
                                      width: 55,

                                      bgColor: Colors.transparent,
                                      borderWidth: 1,
                                      borderColor:
                                          AppColors.textSubTitleColored,
                                    ),
                                  ),
                                  SizedBox(height: AppDimensions.height29),
                                  Center(
                                    child: Text(
                                      AppConstants.welcomeBack.capitalize(),
                                      style: AppTextStyles.titleXl.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppDimensions.height33),
                                  SocialButton(
                                    text: AppConstants.continueWithFb,
                                    icon: IconsAssets.fbIcon,
                                    onPressed: () {},
                                    isPrimary: true,
                                  ),
                                  SizedBox(height: AppDimensions.height20),
                                  SocialButton(
                                    text: AppConstants.continueWithGoogle,
                                    icon: IconsAssets.googleIcon,
                                    onPressed: loading
                                        ? () {}
                                        : () => context
                                            .read<AuthBloc>()
                                            .add(SignInWithGoogleRequested()),
                                    isPrimary: false,
                                  ),

                                  SizedBox(height: AppDimensions.height40),
                                  Center(
                                    child: Text(
                                      AppConstants.loginwithemail.toUpperCase(),
                                      style: AppTextStyles.tabText.copyWith(
                                        color: AppColors.textPlaceholder,
                                        fontWeight: AppTextStyles.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppDimensions.height40),
                                  CustomInput(
                                    label: AppConstants.emailAddress
                                        .capitalize(),
                                    hint: AppConstants.emailAddress
                                        .capitalize(),
                                    controller: _emailController,
                                    validator: Validators.email,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(
                                    height: AppDimensions.verticalPaddingMD,
                                  ),
                                  CustomInput(
                                    label: AppConstants.password.capitalize(),
                                    hint: AppConstants.password.capitalize(),
                                    obscureText: !_showPassword,
                                    controller: _passwordController,
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

                                  SizedBox(height: AppDimensions.height30),
                                  CustomButton.primary(
                                    text: AppConstants.logIn.capitalizeWords(),
                                    bgColor: AppColors.primarySoft,
                                    onPressed: loading ? null : _handleLogin,
                                    isLoading: loading,
                                    isFullWidth: true,
                                    size: ButtonSize.extraLarge,
                                  ),
                                  SizedBox(height: AppDimensions.height20),
                                  CustomButton.text(
                                    text: AppConstants.forgotPassword
                                        .capitalizeWords(),
                                    onPressed: () {context.go(RouteConstants.forgotPassword);},
                                    isFullWidth: true,
                                    textColor: AppColors.textPrimary,
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () =>
                                          context.go(RouteConstants.signup),
                                      child: RichText(
                                        text: TextSpan(
                                          style: AppTextStyles.bodyMedium
                                              .copyWith(
                                                color: AppColors.textPrimary,
                                              ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${AppConstants.dontHaveAnAccount} ',
                                            ),
                                            TextSpan(
                                              text: AppConstants.signup
                                                  .capitalizeWords(),
                                              style: TextStyle(
                                                color: AppColors
                                                    .primary, // ✅ Different color
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
