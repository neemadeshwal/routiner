import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_state.dart';

/// Selected goal card: vibrant purple background.
const Color _kSelectedBg = Color(0xFF8E97FD);
/// Unselected goal card: muted purple/gray.
const Color _kUnselectedBg = Color(0xFFE8E9F5);
/// Circle behind checkmark when selected (pastel purple).
const Color _kSelectedCircle = Color(0xFFB4BCED);
/// Checkmark and text on selected card.
const Color _kSelectedFg = Color(0xFFFFFFFF);
/// Unselected circle (light).
const Color _kUnselectedCircle = Color(0xFFFFFFFF);
/// Text on unselected card.
const Color _kUnselectedText = Color(0xFF3F414E);

final List<String> _kGoalOptions = [
  'I want to build good habits',
  'I need to build better routines',
  'I want to finally finish the habits I fear',
  'I need to be organised',
  'I want to be more productive',
  'I want to improve my health',
];

class Step5Goals extends StatefulWidget {
  const Step5Goals({super.key});

  @override
  State<Step5Goals> createState() => _Step5GoalsState();
}

class _Step5GoalsState extends State<Step5Goals> {
  final Set<String> _selectedGoals = {};


  void _toggle(String goal) {
    setState(() {
      if (_selectedGoals.contains(goal)) {
        _selectedGoals.remove(goal);
      } else {
        _selectedGoals.add(goal);
      }
      context.read<UserSetupBloc>().add(UserSetupGoalsSelected(goals: _selectedGoals.toList()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state=context.watch<UserSetupBloc>().state;
    final savedGoals=state is UserSetupProgress? state.formData.goals : state is UserSetupSubmitting ? state.formData.goals : [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppDimensions.space8),
        Text(
          'What do you hope to achieve?',
          style: AppTextStyles.appBarTitle,
        ),
        SizedBox(height: AppDimensions.space8),
        Text(
          'Select all that apply',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: AppDimensions.space24),
        ..._kGoalOptions.map((goal) => _GoalChip(
              label: goal,
              isSelected: savedGoals.contains(goal),
              onTap: () => _toggle(goal),
            )),
      ],
    );
  }
}

class _GoalChip extends StatelessWidget {
  const _GoalChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.space12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLG,
              vertical: AppDimensions.padding,
            ),
            decoration: BoxDecoration(
              color: isSelected ? _kSelectedBg : const Color.fromARGB(255, 232, 233, 245),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: isSelected ? 4 : 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                _CheckCircle(isSelected: isSelected),
                SizedBox(width: AppDimensions.space16),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected ? _kSelectedFg : _kUnselectedText,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckCircle extends StatelessWidget {
  const _CheckCircle({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isSelected ? _kSelectedCircle : _kUnselectedCircle,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, size: 18, color: _kSelectedFg)
          : null,
    );
  }
}
