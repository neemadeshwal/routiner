import 'package:flutter/material.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';

/// White cards that appear above the bottom nav when the center FAB is open.
class HabitFabMenuPanel extends StatefulWidget {
  const HabitFabMenuPanel({
    super.key,
    this.onQuitBadHabit,
    this.onNewGoodHabit,
  });

  /// Opens the “quit bad habit” bottom sheet.
  final VoidCallback? onQuitBadHabit;

  /// Opens the “new good habit” bottom sheet (e.g. create custom + popular habits).
  final VoidCallback? onNewGoodHabit;

  @override
  State<HabitFabMenuPanel> createState() => _HabitFabMenuPanelState();
}

class _HabitFabMenuPanelState extends State<HabitFabMenuPanel> {
  int _moodIndex = 4;

  static const _moods = ['😠', '😢', '😐', '🙂', '😍'];

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppDimensions.radiusLG);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.space16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _MenuCard(
                  title: 'Quit Bad Habit',
                  subtitle: 'Never too late...',
                  radius: radius,
                  
                  trailing: _ShieldIcon(
                    color: const Color(0xFFFFE4E4),
                    icon: Icons.close_rounded,
                    iconColor: const Color(0xFFE53935),
                  ),
                  onTap: () => widget.onQuitBadHabit?.call(),
                ),
              ),
              SizedBox(width: AppDimensions.space12),
              Expanded(
                child: _MenuCard(
                  title: 'New Good Habit',
                  subtitle: 'For a better life',
                  radius: radius,
                  trailing: _ShieldIcon(
                    color: const Color(0xFFE8F5E9),
                    icon: Icons.check_rounded,
                    iconColor: const Color(0xFF43A047),
                  ),
                  onTap: () => widget.onNewGoodHabit?.call(),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.space12),
          _MenuCard(
            title: 'Add Mood',
            subtitle: 'How’re you feeling?',
            radius: radius,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_moods.length, (i) {
                final selected = i == _moodIndex;
                return Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? 0 : AppDimensions.space8,
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => _moodIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding:  EdgeInsets.symmetric(horizontal: AppDimensions.space8,vertical: AppDimensions.space4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.grey.shade100,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        _moods[i],
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                );
              }),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.radius,
    required this.trailing,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final BorderRadius radius;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: radius,
      elevation: 6,
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.space16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.textTitle,
                      ),
                    ),
                    SizedBox(height: AppDimensions.space4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textParagraph,
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _ShieldIcon extends StatelessWidget {
  const _ShieldIcon({
    required this.color,
    required this.icon,
    required this.iconColor,
  });

  final Color color;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor, size: 22),
    );
  }
}
