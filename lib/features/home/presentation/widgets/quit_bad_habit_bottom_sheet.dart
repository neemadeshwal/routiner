import 'package:flutter/material.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';

/// Slide-up sheet: quit a bad habit — custom tracker + common habits to quit.
Future<void> showQuitBadHabitBottomSheet(
  BuildContext context, {
  VoidCallback? onTrackCustomBadHabit,
  void Function(String habitId)? onCommonHabitSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) => _QuitBadHabitSheetBody(
      onTrackCustomBadHabit: onTrackCustomBadHabit,
      onCommonHabitSelected: onCommonHabitSelected,
    ),
  );
}

class _QuitBadHabitSheetBody extends StatelessWidget {
  const _QuitBadHabitSheetBody({
    this.onTrackCustomBadHabit,
    this.onCommonHabitSelected,
  });

  final VoidCallback? onTrackCustomBadHabit;
  final void Function(String habitId)? onCommonHabitSelected;

  static const _common = <_QuitHabitTemplate>[
    _QuitHabitTemplate(
      id: 'smoking',
      title: 'Smoking',
      subtitle: 'Track cravings',
      color: Color(0xFFFFEBEE),
      icon: Icons.smoke_free_rounded,
      iconColor: Color(0xFFE57373),
    ),
    _QuitHabitTemplate(
      id: 'social_scroll',
      title: 'Social scroll',
      subtitle: 'Screen time',
      color: Color(0xFFF3E5F5),
      icon: Icons.smartphone_rounded,
      iconColor: Color(0xFFBA68C8),
    ),
    _QuitHabitTemplate(
      id: 'junk_food',
      title: 'Junk food',
      subtitle: 'Snacks & sugar',
      color: Color(0xFFFFF3E0),
      icon: Icons.fastfood_rounded,
      iconColor: Color(0xFFFFB74D),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return DraggableScrollableSheet(
      initialChildSize: 0.42,
      minChildSize: 0.35,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: AppDimensions.space12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textPlaceholder.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.space20,
                    AppDimensions.space20,
                    AppDimensions.space20,
                    bottom + AppDimensions.space24,
                  ),
                  children: [
                    Text(
                      'QUIT BAD HABIT',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPlaceholder,
                      ),
                    ),
                    SizedBox(height: AppDimensions.space12),
                    Material(
                      color: AppColors.surface,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusLG),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          onTrackCustomBadHabit?.call();
                        },
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusLG),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.space16,
                            vertical: AppDimensions.space16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusLG),
                            border: Border.all(
                              color: const Color(0xFFFFCDD2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Track habit to quit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: AppColors.textTitle,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFFFEBEE),
                                  border: Border.all(
                                    color: const Color(0xFFFFCDD2),
                                  ),
                                ),
                                child: Icon(
                                  Icons.remove_rounded,
                                  color: const Color(0xFFE53935),
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimensions.space24),
                    Text(
                      'COMMON HABITS TO QUIT',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPlaceholder,
                      ),
                    ),
                    SizedBox(height: AppDimensions.space12),
                    SizedBox(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _common.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: AppDimensions.space12),
                        itemBuilder: (context, i) {
                          final h = _common[i];
                          return _QuitTemplateCard(
                            habit: h,
                            onTap: () {
                              Navigator.of(context).pop();
                              onCommonHabitSelected?.call(h.id);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuitHabitTemplate {
  const _QuitHabitTemplate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.iconColor,
  });

  final String id;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final Color iconColor;
}

class _QuitTemplateCard extends StatelessWidget {
  const _QuitTemplateCard({
    required this.habit,
    required this.onTap,
  });

  final _QuitHabitTemplate habit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: habit.color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 140,
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(habit.icon, color: habit.iconColor, size: 28),
                const Spacer(),
                Text(
                  habit.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.textTitle,
                  ),
                ),
                SizedBox(height: AppDimensions.space4),
                Text(
                  habit.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textParagraph,
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
