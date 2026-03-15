import 'package:flutter/material.dart';
import 'package:routiner/core/theme/app_colors.dart';

class StepProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep; // 0-indexed

  const StepProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentStep;
        final isDone = index < currentStep;
        return _buildStepIndicator(
          key: ValueKey(index),
          isActive: isActive,
          isDone: isDone,
        );
      }),
    );
  }
}

Widget _buildStepIndicator({
  Key? key,
  required bool isActive,
  required bool isDone,
}) {
  return AnimatedContainer(
    key: key,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOutCubic,
    height: 5,
    width: isActive ? 60 : 43,
    margin: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      color: isActive
          ? AppColors.primary
          : (isDone ? Colors.grey.shade200 : Colors.grey.shade200),
    ),
  );
}