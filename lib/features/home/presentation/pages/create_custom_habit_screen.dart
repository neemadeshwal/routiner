import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';

/// Create / configure a habit — name, icon, color, goal, reminders, build vs quit.
class CreateCustomHabitScreen extends StatefulWidget {
  const CreateCustomHabitScreen({
    super.key,
    this.initialQuitSelected = false,
  });

  /// When true (e.g. opened from “quit bad habit”), [HabitType.quit] is selected first.
  final bool initialQuitSelected;

  @override
  State<CreateCustomHabitScreen> createState() =>
      _CreateCustomHabitScreenState();
}

class _CreateCustomHabitScreenState extends State<CreateCustomHabitScreen> {
  final _nameController = TextEditingController(text: 'Walk');
  bool _remindersOn = true;
  late bool _isQuit = widget.initialQuitSelected;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.space16,
                vertical: AppDimensions.space8,
              ),
              child: Row(
                children: [
                  Material(
                    color: AppColors.surface,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMD),
                    child: InkWell(
                      onTap: () => context.pop(),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMD),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.textTitle,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Create Custom Habit',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textTitle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.space20,
                  AppDimensions.space8,
                  AppDimensions.space20,
                  AppDimensions.space24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionLabel('NAME'),
                    SizedBox(height: AppDimensions.space8),
                    TextField(
                      controller: _nameController,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textTitle,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Habit name',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.textPlaceholder.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.textPlaceholder.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          bottom: AppDimensions.space8,
                        ),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: AppDimensions.space24),
                    _SectionLabel('ICON AND COLOR'),
                    SizedBox(height: AppDimensions.space12),
                    Row(
                      children: [
                        Expanded(
                          child: _SelectableCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.directions_walk_rounded,
                                  size: 36,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: AppDimensions.space12),
                                Text(
                                  'Walking',
                                  style: AppTextStyles.titleSmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textTitle,
                                  ),
                                ),
                                Text(
                                  'Icon',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textPlaceholder,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: AppDimensions.space12),
                        Expanded(
                          child: _SelectableCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF9800),
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusSM,
                                    ),
                                  ),
                                ),
                                SizedBox(height: AppDimensions.space12),
                                Text(
                                  'Orange',
                                  style: AppTextStyles.titleSmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textTitle,
                                  ),
                                ),
                                Text(
                                  'Color',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textPlaceholder,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.space24),
                    _SectionLabel('GOAL'),
                    SizedBox(height: AppDimensions.space12),
                    _GoalCard(
                      onEdit: () {},
                    ),
                    SizedBox(height: AppDimensions.space24),
                    _SectionLabel('REMINDERS'),
                    SizedBox(height: AppDimensions.space12),
                    _RemindersCard(
                      remindersOn: _remindersOn,
                      onToggle: (v) => setState(() => _remindersOn = v),
                      onAddReminder: () {},
                    ),
                    SizedBox(height: AppDimensions.space24),
                    _SectionLabel('HABIT TYPE'),
                    SizedBox(height: AppDimensions.space12),
                    _HabitTypeToggle(
                      isQuit: _isQuit,
                      onChanged: (quit) => setState(() => _isQuit = quit),
                    ),
                    SizedBox(height: AppDimensions.space24),
                    _SectionLabel('LOCATION'),
                    SizedBox(height: AppDimensions.space12),
                    Container(
                      padding: EdgeInsets.all(AppDimensions.space20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusLG),
                        border: Border.all(color: const Color(0xFFEBEAEC)),
                      ),
                      child: Text(
                        'Optional — add a place',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPlaceholder,
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimensions.space32),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.space20,
                0,
                AppDimensions.space20,
                bottom + AppDimensions.space16,
              ),
              child: CustomButton(
                onPressed: () => context.pop(),
                text: 'Add Habit',
                isFullWidth: true,
                size: ButtonSize.extraLarge,
                bgColor: AppColors.primary,
                textColor: AppColors.textOnPrimary,
                borderRadius: AppDimensions.radiusHuge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.labelMedium.copyWith(
        letterSpacing: 1.2,
        fontWeight: FontWeight.w600,
        color: AppColors.textPlaceholder,
        fontSize: 11,
      ),
    );
  }
}

class _SelectableCard extends StatelessWidget {
  const _SelectableCard({
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppDimensions.space16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
            border: Border.all(color: const Color(0xFFEBEAEC)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.onEdit});

  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: const Color(0xFFEBEAEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textTitle,
                    ),
                    children: [
                      TextSpan(
                        text: '1 times ',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: 'or more per day',
                        style: TextStyle(
                          color: AppColors.textParagraph,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Material(
                color: AppColors.textTitle,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onEdit,
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.space12),
          Wrap(
            spacing: AppDimensions.space8,
            runSpacing: AppDimensions.space8,
            children: [
              _Chip(
                icon: Icons.sync_rounded,
                label: 'Daily',
              ),
              _Chip(
                icon: Icons.calendar_today_rounded,
                label: 'Every day',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.space12,
        vertical: AppDimensions.space8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(AppDimensions.radiusHuge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textParagraph),
          SizedBox(width: AppDimensions.space4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textTitle,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RemindersCard extends StatelessWidget {
  const _RemindersCard({
    required this.remindersOn,
    required this.onToggle,
    required this.onAddReminder,
  });

  final bool remindersOn;
  final ValueChanged<bool> onToggle;
  final VoidCallback onAddReminder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: const Color(0xFFEBEAEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Remember to set off time for a workout today.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textParagraph,
                  ),
                ),
              ),
              Switch.adaptive(
                value: remindersOn,
                onChanged: onToggle,
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF4CAF50),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.space12),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.space12,
              vertical: AppDimensions.space12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time_rounded,
                    size: 18, color: AppColors.textParagraph),
                SizedBox(width: AppDimensions.space8),
                Text(
                  '09:30',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textTitle,
                  ),
                ),
                SizedBox(width: AppDimensions.space20),
                Icon(Icons.notifications_none_rounded,
                    size: 18, color: AppColors.textParagraph),
                SizedBox(width: AppDimensions.space8),
                Expanded(
                  child: Text(
                    'Every day',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textTitle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimensions.space16),
          CustomButton(
            onPressed: onAddReminder,
            text: 'Add Reminder',
            isFullWidth: true,
            size: ButtonSize.medium,
            bgColor: Colors.transparent,
            textColor: AppColors.textTitle,
            borderColor: const Color(0xFFEBEAEC),
            borderWidth: 1,
            borderRadius: AppDimensions.radiusHuge,
          ),
        ],
      ),
    );
  }
}

class _HabitTypeToggle extends StatelessWidget {
  const _HabitTypeToggle({
    required this.isQuit,
    required this.onChanged,
  });

  final bool isQuit;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEBEAEC),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TypeSegment(
              label: 'Build',
              selected: !isQuit,
              onTap: () => onChanged(false),
            ),
          ),
          Expanded(
            child: _TypeSegment(
              label: 'Quit',
              selected: isQuit,
              onTap: () => onChanged(true),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeSegment extends StatelessWidget {
  const _TypeSegment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: AppDimensions.space12),
          decoration: BoxDecoration(
            color: selected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textTitle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
