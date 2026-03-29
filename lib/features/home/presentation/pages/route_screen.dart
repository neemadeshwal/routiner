import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/assets_constants.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/features/home/presentation/widgets/habit_fab_menu_panel.dart';
import 'package:routiner/features/home/presentation/widgets/new_good_habit_bottom_sheet.dart';
import 'package:routiner/features/home/presentation/widgets/quit_bad_habit_bottom_sheet.dart';

class RouteScreen extends StatefulWidget {
  final Widget child;
  final String currentPath;

  const RouteScreen({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  bool _fabMenuOpen = false;

  void _toggleFabMenu() {
    setState(() => _fabMenuOpen = !_fabMenuOpen);
  }

  Future<void> _openQuitBadHabitSheet() async {
    setState(() => _fabMenuOpen = false);
    if (!mounted) return;
    await showQuitBadHabitBottomSheet(
      context,
      onTrackCustomBadHabit: () {
        context.push(RouteConstants.createCustomHabit, extra: true);
      },
      onCommonHabitSelected: (id) {
        // TODO: pre-fill quit habit from template id
      },
    );
  }

  Future<void> _openNewGoodHabitSheet() async {
    setState(() => _fabMenuOpen = false);
    if (!mounted) return;
    await showNewGoodHabitBottomSheet(
      context,
      onCreateCustomHabit: () {
        context.push(RouteConstants.createCustomHabit);
      },
      onPopularHabitSelected: (id) {
        // TODO: pre-fill habit from template id
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeRoute = widget.currentPath;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0XFFEAECF0)),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: widget.child),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: AppDimensions.space16),
                    padding: EdgeInsets.symmetric(vertical: AppDimensions.space16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusCircle),
                      border: Border.all(color: const Color(0XFFCDCDD0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: '',
                          bgColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          width: 32,
                          height: 32,
                          borderRadius: 99,
                          iconLeft: activeRoute == RouteConstants.home
                              ? SvgPicture.asset(IconsAssets.homeColored,
                                  width: 30, height: 30)
                              : SvgPicture.asset(IconsAssets.home,
                                  width: 30, height: 30),
                          onPressed: () => context.go(RouteConstants.home),
                        ),
                        CustomButton(
                          text: '',
                          bgColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          width: 32,
                          height: 32,
                          borderRadius: 99,
                          iconLeft: activeRoute == RouteConstants.explore
                              ? SvgPicture.asset(IconsAssets.exploreColored,
                                  width: 30, height: 30)
                              : SvgPicture.asset(IconsAssets.explore,
                                  width: 30, height: 30),
                          onPressed: () => context.go(RouteConstants.explore),
                        ),
                        SizedBox(width: 48, height: 48),
                        CustomButton(
                          text: '',
                          bgColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          width: 32,
                          height: 32,
                          borderRadius: 99,
                          iconLeft: activeRoute == RouteConstants.activity
                              ? SvgPicture.asset(IconsAssets.activityColored,
                                  width: 30, height: 30)
                              : SvgPicture.asset(IconsAssets.activity,
                                  width: 30, height: 30),
                          onPressed: () => context.go(RouteConstants.activity),
                        ),
                        CustomButton(
                          text: '',
                          bgColor: Colors.transparent,
                          width: 32,
                          height: 32,
                          borderRadius: 99,
                          padding: EdgeInsets.zero,
                          iconLeft: activeRoute == RouteConstants.profile
                              ? SvgPicture.asset(IconsAssets.profileColored,
                                  width: 30, height: 30)
                              : SvgPicture.asset(IconsAssets.profile,
                                  width: 30, height: 30),
                          onPressed: () => context.go(RouteConstants.profile),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_fabMenuOpen)
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _fabMenuOpen = false),
                    child: ColoredBox(
                      color: Colors.black.withValues(alpha: 0.45),
                    ),
                  ),
                ),
              if (_fabMenuOpen)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 112,
                  child: HabitFabMenuPanel(
                    onQuitBadHabit: _openQuitBadHabitSheet,
                    onNewGoodHabit: _openNewGoodHabitSheet,
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: AppDimensions.space16,
                child: Center(
                  child: Material(
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _toggleFabMenu,
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: _fabMenuOpen
                              ? Transform.rotate(
                                  angle: math.pi / 4,
                                  child: SvgPicture.asset(
                                    IconsAssets.add,
                                    width: 22,
                                    height: 22,
                                  ),
                                )
                              : SvgPicture.asset(
                                  IconsAssets.add,
                                  width: 22,
                                  height: 22,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
