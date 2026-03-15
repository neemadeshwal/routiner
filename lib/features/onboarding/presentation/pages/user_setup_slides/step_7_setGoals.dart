import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_state.dart';

/// Pill selected: vibrant purple.
const Color _kPillSelectedBg = Color(0xFF8E97FD);
/// Pill unselected: light mode (light grey).
const Color _kPillUnselectedBg = Color(0xFFE8ECF4);
/// Text on selected pill.
const Color _kPillSelectedText = Color(0xFFFFFFFF);
/// Section label (uppercase).
const Color _kSectionLabel = Color(0xFFB8B8C0);

const List<String> _kDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class ReminderOption {
  const ReminderOption({required this.label, required this.emoji});
  final String label;
  final String emoji;
}

const List<ReminderOption> _kReminders = [
  ReminderOption(label: 'Morning', emoji: '🌅'),
  ReminderOption(label: 'Afternoon', emoji: '☀️'),
  ReminderOption(label: 'Evening', emoji: '🌇'),
  ReminderOption(label: 'Night', emoji: '🌙'),
];

const List<String> _kDurations = ['5 min', '10 min', '15 min', '30 min', '1 hour'];

class Step7SetGoal extends StatefulWidget {
  const Step7SetGoal({super.key});

  @override
  State<Step7SetGoal> createState() => _Step7SetGoalState();
}

class _Step7SetGoalState extends State<Step7SetGoal> {
  void _toggleDay(
    String day,
    Set<String> savedDays,
    String savedReminder,
    String savedDuration,
  ) {
    final newDays = Set<String>.from(savedDays);
    if (newDays.contains(day)) {
      newDays.remove(day);
    } else {
      newDays.add(day);
    }
    context.read<UserSetupBloc>().add(UserSetupSetGoalSelected(
          days: newDays,
          reminder: savedReminder,
          duration: savedDuration,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UserSetupBloc>().state;
    final savedDays = state is UserSetupProgress
        ? state.formData.days
        : state is UserSetupSubmitting
            ? state.formData.days
            : {'Mon', 'Tue'};
    final savedReminder = state is UserSetupProgress
        ? state.formData.reminder
        : state is UserSetupSubmitting
            ? state.formData.reminder
            : 'Morning';
    final savedDuration = state is UserSetupProgress
        ? state.formData.duration
        : state is UserSetupSubmitting
            ? state.formData.duration
            : '5 min';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppDimensions.space8),
        Text(
          'Set your goals 🎯',
          style: AppTextStyles.appBarTitle,
        ),
        SizedBox(height: AppDimensions.space8),
        Text(
          'How often do you want to do this habit?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: AppDimensions.space24),
        _buildDaysSection(savedDays, savedReminder, savedDuration),
        SizedBox(height: AppDimensions.space24),
        _buildReminderSection(savedDays, savedReminder, savedDuration),
        SizedBox(height: AppDimensions.space24),
        _buildDurationSection(savedDays, savedReminder, savedDuration),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.space12),
      child: Text(
        label,
        style: AppTextStyles.bodyMedium.copyWith(
          color: _kSectionLabel,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDaysSection(
    Set<String> savedDays,
    String savedReminder,
    String savedDuration,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppDimensions.space12,
          runSpacing: AppDimensions.space12,
          children: _kDays
              .map((day) => _PillChip(
                    label: day,
                    isSelected: savedDays.contains(day),
                    onTap: () =>
                        _toggleDay(day, savedDays, savedReminder, savedDuration),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildReminderSection(
    Set<String> savedDays,
    String savedReminder,
    String savedDuration,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('REMINDER'),
        Wrap(
          spacing: AppDimensions.space12,
          runSpacing: AppDimensions.space12,
          children: _kReminders
              .map((r) => _PillChip(
                    label: '${r.emoji} ${r.label}',
                    isSelected: savedReminder == r.label,
                    onTap: () {
                      context.read<UserSetupBloc>().add(UserSetupSetGoalSelected(
                            days: savedDays,
                            reminder: r.label,
                            duration: savedDuration,
                          ));
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildDurationSection(
    Set<String> savedDays,
    String savedReminder,
    String savedDuration,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('DURATION'),
        Wrap(
          spacing: AppDimensions.space12,
          runSpacing: AppDimensions.space12,
          children: _kDurations
              .map((d) => _PillChip(
                    label: d,
                    isSelected: savedDuration == d,
                    onTap: () {
                      context.read<UserSetupBloc>().add(UserSetupSetGoalSelected(
                            days: savedDays,
                            reminder: savedReminder,
                            duration: d,
                          ));
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _PillChip extends StatelessWidget {
  const _PillChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
            vertical: AppDimensions.paddingSM,
          ),
          decoration: BoxDecoration(
            color: isSelected ? _kPillSelectedBg : _kPillUnselectedBg,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isSelected ? _kPillSelectedText : AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
