import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_state.dart';
import 'package:routiner/features/onboarding/presentation/pages/user_setup_slides/step_1_gender.dart';
import 'package:routiner/features/onboarding/presentation/pages/user_setup_slides/step_2_dob.dart';
import 'package:routiner/features/onboarding/presentation/pages/user_setup_slides/step_3_wakeUp.dart';
import 'package:routiner/features/onboarding/presentation/pages/user_setup_slides/step_4_reflection.dart';
import 'package:routiner/features/onboarding/presentation/pages/user_setup_slides/step_5_goals.dart';
import 'package:routiner/features/onboarding/presentation/pages/user_setup_slides/step_6_firstHabit.dart';
import 'package:routiner/features/onboarding/presentation/pages/user_setup_slides/step_7_setGoals.dart';
import 'package:routiner/features/onboarding/presentation/widgets/step_progress_indicator.dart';

class UserSetupScreen extends StatefulWidget {
  const UserSetupScreen({super.key});

  @override
  State<UserSetupScreen> createState() => _UserSetupScreenState();
}

class _UserSetupScreenState extends State<UserSetupScreen> {
  Widget _buildStepContent(int currentStep) {
    switch (currentStep) {
      case 0:
        return const Step1Gender();
      case 1:
        return const Step2Dob();
      case 2:
        return const Step3Wakeup();
      case 3:
        return const Step4Reflection();
      case 4:
        return const Step5Goals();
      case 5:
        return const Step6FirstHabit();
      case 6:
        return const Step7SetGoal();
      default:
        return const Step1Gender();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSetupBloc, UserSetupState>(
      listener: (context, state) {
        if (state is UserSetupSuccess) {
          context.go(RouteConstants.allSetSuccess);
        }
        if (state is UserSetupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final formData = state is UserSetupProgress
            ? state.formData
            : state is UserSetupSubmitting
                ? state.formData
                : null;
        final currentStep = formData?.currentStep ?? 0;
        final loading = state is UserSetupSubmitting;

        final isStepValid = formData == null
            ? false
            : switch (currentStep) {
                0 => (formData.gender ?? '').trim().isNotEmpty,
                1 => formData.dob!=null,
                2 => formData.wakeupHour!=0 && formData.wakeupMinute!=0,
                3 => formData.reflectionHour!=0 && formData.reflectionMinute!=0,
                4 => formData.goals.isNotEmpty,
                5 => (formData.firstHabit ?? '').trim().isNotEmpty,
                6 => formData.days.isNotEmpty && formData.reminder.isNotEmpty && formData.duration.isNotEmpty,
                _ => true,
              };
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLG,
                vertical: AppDimensions.paddingLG,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's get to know you",
                    style: AppTextStyles.appBarTitle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "This helps us personalize your habit experience",
                    style: AppTextStyles.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  StepProgressIndicator(
                    totalSteps: 7,
                    currentStep: currentStep,
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: KeyedSubtree(
                        key: ValueKey<int>(currentStep),
                        child: _buildStepContent(currentStep),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Previous",
                          onPressed: currentStep > 0
                              ? () => context.read<UserSetupBloc>().add(
                                  UserSetupPreviousStep(),
                                )
                              : null,
                          bgColor: AppColors.background,
                          textColor: AppColors.primarySoft,
                          height: 50,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          text: currentStep == 6 ? "Complete" : "Next",
                          isLoading: loading,
                          onPressed: (loading || !isStepValid)
                              ? null
                              : () {
                                  if (currentStep == 6) {
                                    final bloc = context.read<UserSetupBloc>();
                                    Future.delayed(const Duration(seconds: 1))
                                        .then((_) => bloc.add(UserSetupComplete()));
                                  } else {
                                    context
                                        .read<UserSetupBloc>()
                                        .add(UserSetupNextStep());
                                  }
                                },
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
