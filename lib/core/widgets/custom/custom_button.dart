import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';

enum ButtonSize { small, medium, large, extraLarge }

class CustomButton extends StatelessWidget {
  // required parameters
  final VoidCallback? onPressed;
  final String? text;

  // optional sizing
  final double? width;
  final double? height;

  final ButtonSize size;
  final EdgeInsets? padding;
  final bool isFullWidth;

  // optional styling
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final Gradient? bgGradient;
  final double? borderRadius;
  final double? borderWidth;

  // optional state
  final bool isLoading;

  // optional icon
  final Widget? iconLeft;
  final Widget? iconRight;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.isLoading = false,
    this.isFullWidth = false,
    this.iconLeft,
    this.iconRight,
    this.size = ButtonSize.medium,
    this.borderWidth,
    this.bgGradient,
  });

  // ========== FACTORY CONSTRUCTORS ==========

  // Primary Button (filled background)
  factory CustomButton.primary({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isFullWidth = false,
    bool isLoading = false,
    Widget? iconLeft,
    Widget? iconRight,
    Color? bgColor,
    Color? textColor,
    Gradient? bgGradient,
  }) {
    return CustomButton(
      onPressed: onPressed,
      isFullWidth: isFullWidth,
      isLoading: isLoading,
      text: text,
      iconLeft: iconLeft,
      iconRight: iconRight,
      size: size,
      bgColor: bgColor ?? AppColors.primary, // ✅ Set colors
      textColor: textColor ?? AppColors.textOnPrimary,
      bgGradient: bgGradient,
    );
  }

  // Outlined button (border only)
  factory CustomButton.outlined({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isFullWidth = false,
    bool isLoading = false,
    Widget? iconLeft,
    Widget? iconRight,
    Color? bgColor,
    Color? textColor,
    Color? borderColor,
    double? borderWidth,
  }) {
    return CustomButton(
      onPressed: onPressed,
      isFullWidth: isFullWidth,
      isLoading: isLoading,
      text: text,
      iconLeft: iconLeft,
      iconRight: iconRight,
      size: size,
      bgColor: Colors.transparent, // ✅ Set colors
      textColor: textColor ?? AppColors.textOnPrimary,
      borderColor: borderColor ?? AppColors.primary, // ✅ Set border color
      borderWidth: borderWidth ?? 2, // ✅ Set default border width
    );
  }

  // text button (no background or border)
  factory CustomButton.text({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isFullWidth = false,
    bool isLoading = false,
    Widget? iconLeft,
    Widget? iconRight,
    Color? textColor,
  }) {
    return CustomButton(
      onPressed: onPressed,
      isFullWidth: isFullWidth,
      isLoading: isLoading,
      text: text,
      iconLeft: iconLeft,
      iconRight: iconRight,
      size: size,
      bgColor: Colors.transparent,
      textColor: textColor ?? AppColors.textOnPrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    // check if disabled

    final bool isDisabled = onPressed == null || isLoading;
    final double buttonHeight = height ?? _getHeight();
    final double buttonWidth = isFullWidth
        ? double.infinity
        : width ?? AppDimensions.buttonWidthMD;
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: bgGradient == null
                  ? isDisabled
                        ? AppColors.disabled
                        : bgColor ?? AppColors.primary
                  : null,
              gradient: isDisabled ? null : bgGradient,
              border: borderColor != null
                  ? Border.all(color: borderColor!, width: borderWidth ?? 1)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius ?? 99),
            ),
            child: Center(child: isLoading ? _buildLoading() : _buildContent()),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      width: 20.w,
      height: 20.h,
      child: CircularProgressIndicator(
        color: textColor ?? AppColors.primarySoft,
        strokeWidth: 2,
      ),
    );
  }

  Widget _buildContent() {
    final bool isDisabled = onPressed == null;
    if (text == null || text!.isEmpty) {
      return iconLeft ?? const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconLeft != null) ...[iconLeft!, SizedBox(width: 8.w)],
        Text(
          text!,
          style: AppTextStyles.buttonMedium.copyWith(
            color: isDisabled
                ? AppColors.textDisabled
                : (textColor ?? AppColors.textOnPrimary),
          ),
        ),
        if (iconRight != null) ...[SizedBox(width: 8.w), iconRight!],
      ],
    );
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return AppDimensions.buttonHeightSM;
      case ButtonSize.medium:
        return AppDimensions.buttonHeightMD;
      case ButtonSize.large:
        return AppDimensions.buttonHeightLG;
      case ButtonSize.extraLarge:
        return AppDimensions.buttonHeightXL;
    }
  }
}
