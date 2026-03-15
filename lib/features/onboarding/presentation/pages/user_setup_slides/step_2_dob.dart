import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_state.dart';

class Step2Dob extends StatefulWidget {
  const Step2Dob({super.key});

  @override
  State<Step2Dob> createState() => _Step2DobState();
}

class _Step2DobState extends State<Step2Dob> {
  Future<void> _selectDate(BuildContext context) async {
    final bloc = context.read<UserSetupBloc>();
    final state = bloc.state;
    final savedDob = state is UserSetupProgress
        ? state.formData.dob
        : state is UserSetupSubmitting
            ? state.formData.dob
            : null;
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: savedDob ?? now.subtract(const Duration(days: 365 * 18)),
      firstDate: now.subtract(const Duration(days: 365 * 120)),
      lastDate: now,
      helpText: 'Select your date of birth',
    );
    if (picked == null || !mounted) return;
    bloc.add(UserSetupDobSelected(dob: picked));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UserSetupBloc>().state;
    final savedDob = state is UserSetupProgress
        ? state.formData.dob
        : state is UserSetupSubmitting
            ? state.formData.dob
            : null;
    final displayText = savedDob != null
        ? '${savedDob.day}/${savedDob.month}/${savedDob.year}'
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("When is your birthday?", style: AppTextStyles.appBarTitle),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              border: Border.all(color: Colors.transparent),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              displayText.isEmpty ? 'Select your date of birth' : displayText,
              style: AppTextStyles.bodyMedium?.copyWith(
                color: displayText.isEmpty
                    ? AppColors.textPlaceholder
                    : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}