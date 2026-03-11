import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/app_constants.dart';
import 'package:routiner/core/constants/assets_constants.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/core/utils/extensions.dart';
import 'package:routiner/core/utils/validators.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/core/widgets/custom/custom_input.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_event.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_state.dart';
import 'package:routiner/features/auth/presentation/widgets/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SigninScreen();
}

class _SigninScreen extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;
  bool _isChecked = false;

  void _handleSignup() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (_formKey.currentState!.validate() && _isChecked) {
      context.read<AuthBloc>().add(
        SignUpRequested(email: email, password: password, name: name),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(RouteConstants.home);
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
                        child: Form(
                          key: _formKey,

                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingLG,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: AppDimensions.height20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomButton(
                                    text: "",
                                    iconLeft: const Icon(Icons.arrow_back),
                                    onPressed: loading ? null : _handleSignup,
                                    borderRadius: 999,
                                    height: 55,
                                    width: 55,
                                    isLoading: loading,

                                    bgColor: Colors.transparent,
                                    borderWidth: 1,
                                    borderColor: AppColors.textSubTitleColored,
                                  ),
                                ),
                                SizedBox(height: AppDimensions.height29),
                                Center(
                                  child: Text(
                                    AppConstants.createYourAccount.capitalize(),
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
                                    AppConstants.signupwithemail.toUpperCase(),
                                    style: AppTextStyles.tabText.copyWith(
                                      color: AppColors.textPlaceholder,
                                      fontWeight: AppTextStyles.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: AppDimensions.height40),
                                CustomInput(
                                  label: AppConstants.fullName.capitalize(),
                                  hint: AppConstants.fullName.capitalize(),
                                  controller: _nameController,
                                  validator: Validators.username,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: AppDimensions.verticalPaddingMD,
                                ),
                                CustomInput(
                                  label: AppConstants.emailAddress.capitalize(),
                                  hint: AppConstants.emailAddress.capitalize(),
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
                                SizedBox(
                                  height: AppDimensions.verticalPaddingMD,
                                ),

                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: AppColors
                                          .primary, // The background color when checked
                                      checkColor: Colors.white,
                                      side: BorderSide(
                                        color: AppColors
                                            .primary, // The border color
                                        width: 1.0, // Thickness of the border
                                      ),

                                      value: _isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked = value!;
                                        });
                                      },
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: AppConstants.iHaveRead
                                            .capitalize(),
                                        style: AppTextStyles.tabText.copyWith(
                                          color: AppColors.textPlaceholder,
                                          fontWeight: AppTextStyles.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: AppConstants.privacyPolicy
                                                .capitalizeWords(),
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppDimensions.height30),
                                CustomButton.primary(
                                  text: AppConstants.create.capitalizeWords(),
                                  bgColor: AppColors.primarySoft,
                                      isLoading: loading,
                                      onPressed: loading ? null : _handleSignup,
                                  isFullWidth: true,
                                  size: ButtonSize.extraLarge,
                                ),
                                SizedBox(height: AppDimensions.height20),
                               
                                SizedBox(height: AppDimensions.height40),
                                Center(
                                  child: GestureDetector(
                                    onTap: () =>
                                        context.go(RouteConstants.signin),
                                    child: RichText(
                                      text: TextSpan(
                                        style: AppTextStyles.bodyMedium
                                            .copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${AppConstants.alreadyHaveAnAccount.capitalize()} ',
                                          ),
                                          TextSpan(
                                            text: AppConstants.logIn
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
