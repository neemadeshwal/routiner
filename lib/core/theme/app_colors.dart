import 'dart:ui';

import 'package:flutter/painting.dart';

class AppColors {
  AppColors._();

  // ==================== PRIMARY COLORS ====================
  // Light Mode
  static const Color primary = Color(0XFF7583CA);
  static const Color primarySoft = Color(0XFF8E97FD);
  static const Color primaryLight = Color(0XFFB4BCED);
  // static const Color primaryDark = Color(0XFF4D57C8);

  // Dark Mode - Slightly desaturated for better dark mode contrast
  static const Color primaryDark = Color(0XFF9AA5E0); // Lighter, softer primary
  static const Color primarySoftDark = Color(
    0XFFA8B1FF,
  ); // Brighter soft variant
  static const Color primaryLightDark = Color(
    0XFFC4CCFF,
  ); // Very light for accents
  static const Color primaryDarkest = Color(0XFF5D68B8); // Darker variant

  // ==================== SECONDARY COLORS ====================
  // Light Mode
  static const Color secondary = Color(0XFF9AA2FD);

  // Dark Mode
  static const Color secondaryDark = Color(0XFFADB4FF); // Brighter for dark bg

  // ==================== BACKGROUND & SURFACE ====================
  // Light Mode
  static const Color background = Color(0XFFF5F5F7); // Changed to light gray
  static const Color surface = Color(0XFFFFFFFF);
  static const Color surfaceVariant = Color(0XFFF8F8FF);

  // Dark Mode - Deep, rich dark colors
  static const Color backgroundDark = Color(
    0XFF0F1014,
  ); // Very dark, almost black
  static const Color surfaceDark = Color(
    0XFF1A1B23,
  ); // Slightly lighter than background
  static const Color surfaceVariantDark = Color(
    0XFF252733,
  ); // Cards, elevated surfaces
  static const Color surfaceElevated = Color(
    0XFF2D2F3D,
  ); // Higher elevation (modals, dialogs)

  // ==================== TEXT COLORS ====================
  // Light Mode
  static const Color textPrimary = Color(0XFF3F414E);
  static const Color textSecondary = Color(0XFF6C6C6C);
  static const Color textTitle = Color(0XFF1D1617);
  static const Color textParagraph = Color(0XFF7B6F72);
  static const Color textPlaceholder = Color(0XFFA1A4B2);
  static const Color textDisabled = Color(0XFFEEEEEE);
  static const Color textOnPrimary = Color(0XFFFFFFFF);
  static const Color textTitleColored = Color(0XFFFFECCC);
  static const Color textSubTitleColored = Color(0XFFEBEAEC);

  // Dark Mode - High contrast for readability
  static const Color textPrimaryDark = Color(0XFFF5F5F7); // Almost white
  static const Color textSecondaryDark = Color(0XFFB8B8C0); // Medium gray
  static const Color textTitleDark = Color(0XFFFFFFFF); // Pure white
  static const Color textParagraphDark = Color(0XFFA8A8B0); // Softer gray
  static const Color textPlaceholderDark = Color(0XFF5E5E68); // Dim gray
  static const Color textDisabledDark = Color(0XFF3A3A42); // Very dim
  static const Color textOnPrimaryDark = Color(
    0XFF0F1014,
  ); // Dark text on bright colors

  // ==================== SIDEBAR COLORS ====================
  // Light Mode
  static const Color sidebarTitle = Color(0XFF4A4A4A);
  static const Color sidebarSubTitle = Color(0XFF868181);

  // Dark Mode
  static const Color sidebarTitleDark = Color(0XFFE5E5E8);
  static const Color sidebarSubTitleDark = Color(0XFF9090A0);

  // ==================== STATUS COLORS ====================
  // Light Mode
  static const Color error = Color(0XFFEF4444);
  static const Color success = Color(0XFF22C55E);
  static const Color warning = Color(0XFFFBBF24);
  static const Color info = Color(0XFF3B82F6);

  // Dark Mode - Slightly brighter for better visibility on dark bg
  static const Color errorDark = Color(0XFFFF6B6B); // Brighter red
  static const Color successDark = Color(0XFF34D87C); // Brighter green
  static const Color warningDark = Color(0XFFFFC850); // Brighter yellow
  static const Color infoDark = Color(0XFF5C9FFF); // Brighter blue

  // ==================== UTILITY COLORS ====================
  // Light Mode
  static const Color border = Color(0XFFE0E0E0);
  static const Color divider = Color(0XFFEEEEEE);
  static const Color disabled = Color(0XFFBDBDBD);
  static const Color shadow = Color(0X1A000000);

  // Dark Mode
  static const Color borderDark = Color(0XFF2D2F3D); // Subtle border
  static const Color dividerDark = Color(0XFF252733); // Very subtle divider
  static const Color disabledDark = Color(0XFF3A3A42); // Dim disabled state
  static const Color shadowDark = Color(0X33000000); // Slightly stronger shadow

  // ==================== INPUT FIELD COLORS ====================
  // Light Mode
  static const Color inputBackground = Color(0XFFF2F3F7);
  static const Color inputBorder = Color(0XFFE8ECF4);
  static const Color inputFocused = Color(0XFF7583CA);

  // Dark Mode
  static const Color inputBackgroundDark = Color(0XFF1F2129); // Dark input bg
  static const Color inputBorderDark = Color(0XFF2D2F3D); // Subtle border
  static const Color inputFocusedDark = Color(
    0XFF9AA5E0,
  ); // Bright when focused

  // ==================== SPECIAL COLORS ====================
  // Light Mode
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color shimmer = Color(0XFFE0E0E0);

  // Dark Mode
  static const Color overlayDark = Color(
    0xB3000000,
  ); // 70% black (darker overlay)
  static const Color shimmerDark = Color(0XFF2D2F3D); // Dark shimmer
  static const Color shimmerHighlight = Color(0XFF3A3C4A); // Shimmer highlight

  // ==================== GRADIENT COLORS (Bonus!) ====================
  // Light Mode Gradients
  static const Color gradientStart = Color(0XFF7583CA);
  static const Color gradientEnd = Color(0XFF9AA2FD);

  // Dark Mode Gradients
  static const Color gradientStartDark = Color(0XFF5D68B8);
  static const Color gradientEndDark = Color(0XFF8891E8);

  // Background Gradients

  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF9DCEFF), // Lighter sky blue

        Color(0xFF92A3FD), // Darker periwinkle
      ],
    ),
  );
}















// // create a class for app colors

// class AppColors{

//   // Private constructor to prevent instantiation
//   AppColors._();

//   // Primary color
//   static const Color primary=Color(0XFF7583CA);
//   static const Color primarySoft=Color(0XFF8E97FD);
//     static const Color primaryLight = Color(0XFFB4BCED);
//     static const Color primaryDark = Color(0XFF4D57C8);


//   // Secondary color
//   static const Color secondary=Color(0XFF9AA2FD);

//   // Background color
//   static const Color background=Color(0XFF4D57C8);
//   static const Color surface=Color(0XFFFFFFFF);

//   // Text colors
//   static const Color textPrimary=Color(0XFF3F414E);
//   static const Color textSecondary=Color(0XFF6C6C6C);
//   static const Color textTitle=Color(0XFF1D1617);
//   static const Color textParagraph=Color(0XFF7B6F72);
//   static const Color textPlaceholder=Color(0XFFA1A4B2);
//   static const Color textDisabled=Color(0XFFEEEEEE);
//   // static const Color textTitleColored=Color(0XFFFFECCC);

//   //Sidebar colors
//   static const Color sidebarTitle=Color(0XFF4A4A4A);
//   static const Color sidebarSubTitle=Color(0XFF868181);
  
// }