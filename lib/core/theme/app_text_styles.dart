import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routiner/core/theme/app_colors.dart';

/// App-wide text styles using Google Fonts (Rubik) and ScreenUtil
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // ==================== BASE FONT FAMILY ====================

  /// Base text style with Rubik font family

  static TextStyle get _baseTextStyle => GoogleFonts.rubik();

  // ==================== DISPLAY STYLES ====================

  /// Display Large - 48.sp, Bold
  static TextStyle get displayLarge => _baseTextStyle.copyWith(
    fontSize: 48.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Display Medium - 40.sp, Bold
  static TextStyle get displayMedium => _baseTextStyle.copyWith(
    fontSize: 40.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Display Small - 32.sp, Bold
  static TextStyle get displaySmall => _baseTextStyle.copyWith(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    height: 1.3,
    letterSpacing: -0.25,
  );

  // ==================== HEADLINE STYLES ====================

  /// Headline Large - 28.sp, SemiBold
  static TextStyle get headlineLarge => _baseTextStyle.copyWith(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.25,
  );

  /// Headline Medium - 24.sp, SemiBold
  static TextStyle get headlineMedium => _baseTextStyle.copyWith(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0,
  );

  /// Headline Small - 20.sp, SemiBold
  static TextStyle get headlineSmall => _baseTextStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0,
  );

  // ==================== TITLE STYLES ====================

  /// Title Large - 22.sp, Medium

  static TextStyle get titleXl => _baseTextStyle.copyWith(
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 1,
    color: AppColors.textTitleColored,
  );

  static TextStyle get titleLarge => _baseTextStyle.copyWith(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  /// Title Medium - 18.sp, Medium
  static TextStyle get titleMedium => _baseTextStyle.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.15,
  );

  /// Title Small - 16.sp, Medium
  static TextStyle get titleSmall => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
    color: AppColors.textSubTitleColored,
  );

  // ==================== BODY STYLES ====================

  /// Body Large - 18.sp, Regular
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
  );

  /// Body Medium - 16.sp, Regular
  static TextStyle get bodyMedium => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.25,
  );

  /// Body Small - 14.sp, Regular
  static TextStyle get bodySmall => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.25,
  );

  // ==================== LABEL STYLES ====================

  /// Label Large - 16.sp, Medium
  static TextStyle get labelLarge => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );

  /// Label Medium - 14.sp, Medium
  static TextStyle get labelMedium => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// Label Small - 12.sp, Medium
  static TextStyle get labelSmall => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // ==================== CAPTION STYLES ====================

  /// Caption - 12.sp, Regular
  static TextStyle get caption => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.4,
  );

  /// Caption Bold - 12.sp, SemiBold
  static TextStyle get captionBold => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.4,
  );

  // ==================== OVERLINE STYLES ====================

  /// Overline - 10.sp, Medium, Uppercase
  static TextStyle get overline => _baseTextStyle.copyWith(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 1.5,
  );

  // ==================== BUTTON STYLES ====================

  /// Button Large - 16.sp, SemiBold
  static TextStyle get buttonLarge => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
  );

  /// Button Medium - 14.sp, SemiBold
  static TextStyle get buttonMedium => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
  );

  /// Button Small - 12.sp, SemiBold
  static TextStyle get buttonSmall => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
  );

  // ==================== SPECIALIZED STYLES ====================

  /// Input Field Text - 16.sp, Regular
  static TextStyle get inputText => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
  );

  /// Input Hint Text - 16.sp, Regular, Light Color
  static TextStyle get hintText => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
    color: Colors.grey[400],
  );

  /// Input Label - 14.sp, Medium
  static TextStyle get inputLabel => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.25,
  );

  /// Error Text - 12.sp, Regular, Red
  static TextStyle get errorText => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.25,
    color: Colors.red[700],
  );

  /// Helper Text - 12.sp, Regular
  static TextStyle get helperText => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.25,
    color: Colors.grey[600],
  );

  /// Link Text - 14.sp, Medium, Blue, Underline
  static TextStyle get linkText => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.25,
    color: Colors.blue[700],
    decoration: TextDecoration.underline,
  );

  /// Chip Text - 14.sp, Medium
  static TextStyle get chipText => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.25,
  );

  /// Badge Text - 10.sp, SemiBold
  static TextStyle get badgeText => _baseTextStyle.copyWith(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
  );

  /// Tab Text - 14.sp, SemiBold
  static TextStyle get tabText => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
  );

  /// Tooltip Text - 12.sp, Regular
  static TextStyle get tooltipText => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.4,
    color: Colors.white,
  );

  /// AppBar Title - 20.sp, SemiBold
  static TextStyle get appBarTitle => _baseTextStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.15,
  );

  /// Bottom Nav Label - 12.sp, Medium
  static TextStyle get bottomNavLabel => _baseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.5,
  );

  /// Dialog Title - 20.sp, SemiBold
  static TextStyle get dialogTitle => _baseTextStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.15,
  );

  /// Dialog Content - 14.sp, Regular
  static TextStyle get dialogContent => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.25,
  );

  /// Snackbar Text - 14.sp, Regular
  static TextStyle get snackbarText => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.25,
    color: Colors.white,
  );

  /// List Tile Title - 16.sp, Medium
  static TextStyle get listTileTitle => _baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.15,
  );

  /// List Tile Subtitle - 14.sp, Regular
  static TextStyle get listTileSubtitle => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.25,
    color: Colors.grey[600],
  );

  /// Card Title - 18.sp, SemiBold
  static TextStyle get cardTitle => _baseTextStyle.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.15,
  );

  /// Card Subtitle - 14.sp, Regular
  static TextStyle get cardSubtitle => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.25,
    color: Colors.grey[600],
  );

  /// Price Text - 24.sp, Bold
  static TextStyle get priceText => _baseTextStyle.copyWith(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: 0,
  );

  /// Discount Text - 14.sp, Medium, Strikethrough
  static TextStyle get discountText => _baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0,
    decoration: TextDecoration.lineThrough,
    color: Colors.grey[500],
  );

  // ==================== CUSTOM WEIGHT VARIATIONS ====================

  /// Get text style with custom weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Get text style with custom color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Get text style with custom size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size.sp);
  }

  /// Get text style with custom height (line height)
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  /// Get text style with custom letter spacing
  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }

  // ==================== FONT WEIGHT HELPERS ====================

  static FontWeight get thin => FontWeight.w100;
  static FontWeight get extraLight => FontWeight.w200;
  static FontWeight get light => FontWeight.w300;
  static FontWeight get regular => FontWeight.w400;
  static FontWeight get medium => FontWeight.w500;
  static FontWeight get semiBold => FontWeight.w600;
  static FontWeight get bold => FontWeight.w700;
  static FontWeight get extraBold => FontWeight.w800;
  static FontWeight get black => FontWeight.w900;
}

// ==================== THEME DATA EXTENSION ====================

/// Extension to easily apply text styles to ThemeData
extension AppTextTheme on ThemeData {
  TextTheme get appTextTheme => TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  );
}
