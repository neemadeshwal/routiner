import 'package:flutter/material.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';

/// Slide-up sheet: "New good habit" — custom habit row + popular habits.
Future<void> showNewGoodHabitBottomSheet(
  BuildContext context, {
  VoidCallback? onCreateCustomHabit,
  void Function(String habitId)? onPopularHabitSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) => _NewGoodHabitSheetBody(
      onCreateCustomHabit: onCreateCustomHabit,
      onPopularHabitSelected: onPopularHabitSelected,
    ),
  );
}

class _NewGoodHabitSheetBody extends StatelessWidget {
  const _NewGoodHabitSheetBody({
    this.onCreateCustomHabit,
    this.onPopularHabitSelected,
  });

  final VoidCallback? onCreateCustomHabit;
  final void Function(String habitId)? onPopularHabitSelected;

  static const _popular = <_PopularHabit>[
    _PopularHabit(
      id: 'walk',
      title: 'Walk',
      subtitle: '10 km',
      color: Color(0xFFFFE8EC),
      icon: Icons.directions_walk_rounded,
      iconColor: Color(0xFFE57373),
    ),
    _PopularHabit(
      id: 'swim',
      title: 'Swim',
      subtitle: '30 min',
      color: Color(0xFFE8EAF6),
      icon: Icons.pool_rounded,
      iconColor: Color(0xFF7986CB),
    ),
    _PopularHabit(
      id: 'read',
      title: 'Read',
      subtitle: '20 min',
      color: Color(0xFFE8F5E9),
      icon: Icons.menu_book_rounded,
      iconColor: Color(0xFF81C784),
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
                      'NEW GOOD HABIT',
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
                          onCreateCustomHabit?.call();
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
                              color: const Color(0xFFEBEAEC),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Create Custom Habit',
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
                                  border: Border.all(
                                    color: const Color(0xFFEBEAEC),
                                  ),
                                ),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: AppColors.textTitle,
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
                      'POPULAR HABITS',
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
                        itemCount: _popular.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: AppDimensions.space12),
                        itemBuilder: (context, i) {
                          final h = _popular[i];
                          return _PopularHabitCard(
                            habit: h,
                            onTap: () {
                              Navigator.of(context).pop();
                              onPopularHabitSelected?.call(h.id);
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

class _PopularHabit {
  const _PopularHabit({
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

class _PopularHabitCard extends StatelessWidget {
  const _PopularHabitCard({
    required this.habit,
    required this.onTap,
  });

  final _PopularHabit habit;
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
