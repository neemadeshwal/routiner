import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;
  final bool isPrimary;
  const SocialButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return isPrimary
        ? CustomButton.primary(
            isFullWidth: true,
            size: ButtonSize.extraLarge,

            text: text.toUpperCase(),
            iconLeft: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                SvgPicture.asset(icon),
                SizedBox(width: AppDimensions.space12),
              ],
            ),
            onPressed: onPressed,
          )
        : CustomButton.outlined(
            isFullWidth: true,
            size: ButtonSize.extraLarge,

            bgColor: Colors.transparent,
            textColor: AppColors.textPrimary,
            borderColor: AppColors.textSubTitleColored,

            text: text.toUpperCase(),
            onPressed: onPressed,
            iconLeft: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(icon),
                SizedBox(width: AppDimensions.space12),
              ],
            ),
          );
  }
}
