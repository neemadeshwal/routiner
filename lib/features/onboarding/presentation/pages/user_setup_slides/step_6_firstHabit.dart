import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_state.dart';

/// Unselected habit card background (dark muted).
const Color _kCardUnselectedBg = AppColors.background;
/// Selected habit card background (vibrant purple).
const Color _kCardSelectedBg = Color(0xFF8E97FD);
/// Selected card border.
const Color _kCardSelectedBorder = Color(0xFFB4BCED);
/// Text on habit cards (white).
/// 
const Color _kCardTextUnselected = AppColors.textPrimary;
const Color _kCardTextSelected = Color(0xFFFFFFFF);
/// Subtitle/description on cards (lighter grey).
const Color _kCardSubtitleUnselected = AppColors.textSecondary;
const Color _kCardSubtitleSelected = AppColors.textPrimary;

class HabitOption {
  const HabitOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
  final String id;
  final String title;
  final String description;
  final IconData icon;
}

final List<HabitOption> _kFirstHabitOptions = [
  HabitOption(
    id: 'morning_walk',
    title: 'Morning Walk',
    description: 'Start fresh',
    icon: Icons.wb_sunny_outlined,
  ),
  HabitOption(
    id: 'morning_run',
    title: 'Morning Run',
    description: 'Build stamina',
    icon: Icons.directions_run,
  ),
  HabitOption(
    id: 'drinking_water',
    title: 'Drinking Water',
    description: 'Stay hydrated',
    icon: Icons.water_drop_outlined,
  ),
  HabitOption(
    id: 'meditation',
    title: 'Meditation',
    description: 'Find calm',
    icon: Icons.self_improvement,
  ),
  HabitOption(
    id: 'reading',
    title: 'Reading',
    description: 'Grow daily',
    icon: Icons.menu_book_outlined,
  ),
  HabitOption(
    id: 'journaling',
    title: 'Journaling',
    description: 'Reflect more',
    icon: Icons.edit_note,
  ),
];

class Step6FirstHabit extends StatefulWidget {
  const Step6FirstHabit({super.key});

  @override
  State<Step6FirstHabit> createState() => _Step6FirstHabitState();
}

class _Step6FirstHabitState extends State<Step6FirstHabit> {

  @override
  Widget build(BuildContext context) {
    final state=context.watch<UserSetupBloc>().state;
    final savedHabit=state is UserSetupProgress? state.formData.firstHabit : state is UserSetupSubmitting ? state.formData.firstHabit : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppDimensions.space8),
        Text(
          'Choose your first habit',
          style: AppTextStyles.appBarTitle,
        ),
        SizedBox(height: AppDimensions.space8),
        Text(
          'Pick one to start — you can add more later',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: AppDimensions.space24),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: AppDimensions.space12,
          crossAxisSpacing: AppDimensions.space12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.85,
          children: _kFirstHabitOptions
              .map((option) => _HabitCard(
                    option: option,
                    isSelected: savedHabit == option.id,
                    onTap: () {
                     
                      context.read<UserSetupBloc>().add(UserSetupFirstHabitSelected(habit: option.id));
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _HabitCard extends StatelessWidget {
  const _HabitCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final HabitOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(AppDimensions.padding),
          decoration: BoxDecoration(
            color: isSelected ? _kCardSelectedBg : _kCardUnselectedBg,
            borderRadius: BorderRadius.circular(16),
            border: isSelected
                ? Border.all(color: _kCardSelectedBorder, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                option.icon,
                size: 40,
                color: isSelected ? _kCardTextSelected : _kCardTextUnselected,
              ),
              SizedBox(height: AppDimensions.space12),
              Text(
                option.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? _kCardTextSelected : _kCardTextUnselected,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppDimensions.space4),
              Text(
                option.description,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? _kCardSubtitleSelected : _kCardSubtitleUnselected,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
