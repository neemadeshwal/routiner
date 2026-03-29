import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_state.dart';

/// 2D flat scroll picker styling (no dark bg, no 3D).
const Color _kUnselectedColor = Color(0xFFA1A4B2);
const double _kItemExtent = 52.0;
const double _kPickerCardRadius = 16.0;
const double _kPickerCardElevation = 2.0;

/// Hour wheel: 1–12 repeating (circular). Use a large list and interpret index % 12.
const int _kHourCycleCount = 101;
const int _kHourItemCount = 12 * _kHourCycleCount;
const int _kHourInitialOffset = 12 * (_kHourCycleCount ~/ 2);

/// Minute wheel: 0–59 repeating (circular).
const int _kMinuteCycleCount = 101;
const int _kMinuteItemCount = 60 * _kMinuteCycleCount;
const int _kMinuteInitialOffset = 60 * (_kMinuteCycleCount ~/ 2);

class Step3Wakeup extends StatefulWidget {
  const Step3Wakeup({super.key});

  @override
  State<Step3Wakeup> createState() => _Step3WakeupState();
}

class _Step3WakeupState extends State<Step3Wakeup> {
  static String _formatTime(int hour, int minute, bool isAm) {
    return '$hour:${minute.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';
  }

  void _onTimeChanged(BuildContext context, int hour, int minute, bool isAm) {
    if (!mounted) return;
    context.read<UserSetupBloc>().add(
          UserSetupWakeupSelected(hour: hour, minute: minute, isAm: isAm),
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UserSetupBloc>().state;
    final savedHour = state is UserSetupProgress
        ? state.formData.wakeupHour
        : state is UserSetupSubmitting
            ? state.formData.wakeupHour
            : 7;
    final savedMinute = state is UserSetupProgress
        ? state.formData.wakeupMinute
        : state is UserSetupSubmitting
            ? state.formData.wakeupMinute
            : 30;
    final savedIsAm = state is UserSetupProgress
        ? state.formData.wakeupIsAm
        : state is UserSetupSubmitting
            ? state.formData.wakeupIsAm
            : true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppDimensions.space8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            SizedBox(width: AppDimensions.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What time do you wake up?",
                    style: AppTextStyles.appBarTitle,
                  ),
                  SizedBox(height: AppDimensions.space4),
                
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.space24),
        Material(
          
          elevation: _kPickerCardElevation,
          shadowColor: AppColors.shadow,
          borderRadius: BorderRadius.circular(_kPickerCardRadius),
          color: AppColors.surface,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: AppDimensions.paddingXL,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_kPickerCardRadius),
            color: Colors.grey.shade100,
           
              border: Border.all(
                color: AppColors.inputBorder,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_kPickerCardRadius - 4),
              child: ScrollTimePicker(
                initialHour: savedHour,
                initialMinute: savedMinute,
                initialIsAm: savedIsAm,
                onTimeChanged: (hour, minute, isAm) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) _onTimeChanged(context, hour, minute, isAm);
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: AppDimensions.paddingXL),
        Text(
          "Your wake up time",
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPlaceholder,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
            border: Border.all(color: AppColors.inputBorder),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 20,
                color: AppColors.textPlaceholder,
              ),
              const SizedBox(width: 12),
              Text(
                _formatTime(savedHour, savedMinute, savedIsAm),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      
      ],
    );
  }
}

class ScrollTimePicker extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final bool initialIsAm;
  final void Function(int hour, int minute, bool isAm) onTimeChanged;

  const ScrollTimePicker({
    super.key,
    this.initialHour = 7,
    this.initialMinute = 30,
    this.initialIsAm = true,
    required this.onTimeChanged,
  });

  @override
  State<ScrollTimePicker> createState() => _ScrollTimePickerState();
}

class _ScrollTimePickerState extends State<ScrollTimePicker> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _amPmController;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(
      initialItem: _kHourInitialOffset + (widget.initialHour - 1).clamp(0, 11),
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _kMinuteInitialOffset + widget.initialMinute.clamp(0, 59),
    );
    _amPmController = FixedExtentScrollController(
      initialItem: widget.initialIsAm ? 0 : 1,
    );
  }

  void _notifyTime() {
    if (!_hourController.hasClients ||
        !_minuteController.hasClients ||
        !_amPmController.hasClients) return;
    final hour = (_hourController.selectedItem % 12) + 1;
    final minute = _minuteController.selectedItem % 60;
    final isAm = _amPmController.selectedItem == 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTimeChanged(hour, minute, isAm);
    });
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _amPmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: _WheelColumn(
                  controller: _hourController,
                  itemCount: _kHourItemCount,
                  
                  itemBuilder: (index) => '${(index % 12) + 1}',
                  onSelectedIndexChanged: (_) => _notifyTime(),
                ),
              ),
              Expanded(
                child: _WheelColumn(
                  controller: _minuteController,
                  itemCount: _kMinuteItemCount,
                  itemBuilder: (index) => (index % 60).toString().padLeft(2, '0'),
                  onSelectedIndexChanged: (_) => _notifyTime(),
                ),
              ),
              Expanded(
                child: _WheelColumn(
                  controller: _amPmController,
                  itemCount: 2,
                  itemBuilder: (index) => index == 0 ? 'AM' : 'PM',
                  onSelectedIndexChanged: (_) => _notifyTime(),
                ),
              ),
            ],
          ),
          IgnorePointer(
            child: Center(
              child: Container(
                height: _kItemExtent,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WheelColumn extends StatefulWidget {
  final FixedExtentScrollController controller;
  final int itemCount;
  final String Function(int index) itemBuilder;
  final ValueChanged<int> onSelectedIndexChanged;

  const _WheelColumn({
    required this.controller,
    required this.itemCount,
    required this.itemBuilder,
    required this.onSelectedIndexChanged,
  });

  @override
  State<_WheelColumn> createState() => _WheelColumnState();
}

class _WheelColumnState extends State<_WheelColumn> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.controller.initialItem;
    widget.controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(_WheelColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!widget.controller.hasClients) return;
    final index = widget.controller.selectedItem;
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onSelectedIndexChanged(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: widget.controller,
      itemExtent: _kItemExtent,
      diameterRatio: 10000,
      perspective: 0.0001,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        if (index != _selectedIndex) {
          setState(() => _selectedIndex = index);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) widget.onSelectedIndexChanged(index);
          });
        }
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: widget.itemCount,
        builder: (context, index) {
          final isSelected = index == _selectedIndex;
          final primaryColor = Theme.of(context).colorScheme.primary;
          return Center(
            child: Text(
              widget.itemBuilder(index),
              style: TextStyle(
                color: isSelected ? primaryColor : _kUnselectedColor,
                fontSize: isSelected ? 26 : 18,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          );
        },
      ),
    );
  }
}
