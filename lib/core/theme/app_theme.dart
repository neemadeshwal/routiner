import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:routiner/core/theme/theme_imports.dart';

/// App-wide theme configuration with light and dark mode support
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ==================== LIGHT THEME ====================

  static ThemeData get lightTheme {
    return ThemeData(
      // ===== BRIGHTNESS =====
      brightness: Brightness.light,
      useMaterial3: true,

      // ===== COLOR SCHEME =====
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        // onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        // onSecondary: AppColors.onSecondary,
        // secondaryContainer: AppColors.secondaryLight,
        onSecondaryContainer: AppColors.secondaryDark,
        // tertiary: AppColors.accent,
        onTertiary: Colors.white,
        error: AppColors.error,
        // onError: AppColors.onError,
        // errorContainer: AppColors.errorLight,
        onErrorContainer: AppColors.errorDark,
        // surfaceContainer: AppColors.backgroundLight,
        // onBackground: AppColors.textPrimary,
        // surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimary,
        // surfaceVariant: AppColors.grey100,
        onSurfaceVariant: AppColors.textSecondary,
        // outline: AppColors.grey300,
        shadow: Colors.black26,
        // inverseSurface: AppColors.grey900,
        onInverseSurface: Colors.white,
        inversePrimary: AppColors.primaryLight,
      ),

      // ===== SCAFFOLD =====
      // scaffoldBackgroundColor: AppColors.backgroundLight,

      // ===== APP BAR THEME =====
      appBarTheme: AppBarTheme(
        // backgroundColor: AppColors.surfaceLight,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: AppDimensions.appBarHeight,
        titleTextStyle: AppTextStyles.appBarTitle.copyWith(
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: AppDimensions.appBarIconSize,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // ===== TEXT THEME =====
      textTheme: GoogleFonts.rubikTextTheme().copyWith(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTextStyles.displayMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppTextStyles.displaySmall.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.textPrimary,
        ),
        titleLarge: AppTextStyles.titleLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        titleMedium: AppTextStyles.titleMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        titleSmall: AppTextStyles.titleSmall.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // ===== PRIMARY TEXT THEME =====
      primaryTextTheme: GoogleFonts.rubikTextTheme(),

      // ===== ICON THEME =====
      iconTheme: IconThemeData(
        color: AppColors.textPrimary,
        size: AppDimensions.iconMD,
      ),

      // ===== CARD THEME =====
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: AppDimensions.cardElevation,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        margin: EdgeInsets.all(AppDimensions.cardMargin),
      ),

      // ===== ELEVATED BUTTON THEME =====
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          // foregroundColor: AppColors.onPrimary,
          minimumSize: Size(
            AppDimensions.buttonWidthMD,
            AppDimensions.buttonHeightLG,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          elevation: AppDimensions.elevationLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ===== TEXT BUTTON THEME =====
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: Size(
            AppDimensions.buttonWidthSM,
            AppDimensions.buttonHeightMD,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMD,
            vertical: AppDimensions.paddingSM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ===== OUTLINED BUTTON THEME =====
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: Size(
            AppDimensions.buttonWidthMD,
            AppDimensions.buttonHeightLG,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          side: BorderSide(
            color: AppColors.primary,
            width: AppDimensions.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ===== ICON BUTTON THEME =====
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          iconSize: AppDimensions.iconMD,
        ),
      ),

      // ===== FLOATING ACTION BUTTON THEME =====
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        // foregroundColor: AppColors.onPrimary,
        elevation: AppDimensions.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        ),
        iconSize: AppDimensions.fabIconSize,
      ),

      // ===== INPUT DECORATION THEME =====
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        // fillColor: AppColors.grey50,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.inputPadding,
          vertical: AppDimensions.verticalPaddingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            // color: AppColors.grey300,
            width: AppDimensions.inputBorderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            // color: AppColors.grey300,
            width: AppDimensions.inputBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppDimensions.inputBorderWidthFocused,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppDimensions.inputBorderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppDimensions.inputBorderWidthFocused,
          ),
        ),
        labelStyle: AppTextStyles.inputLabel.copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: AppTextStyles.hintText,
        errorStyle: AppTextStyles.errorText,
        helperStyle: AppTextStyles.helperText,
      ),

      // ===== DIALOG THEME =====
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: AppDimensions.elevationHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.dialogRadius),
        ),
        titleTextStyle: AppTextStyles.dialogTitle.copyWith(
          color: AppColors.textPrimary,
        ),
        contentTextStyle: AppTextStyles.dialogContent.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // ===== BOTTOM SHEET THEME =====
      bottomSheetTheme: BottomSheetThemeData(
        // backgroundColor: AppColors.surfaceLight,
        elevation: AppDimensions.elevationHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.bottomSheetRadius),
          ),
        ),
      ),

      // ===== SNACKBAR THEME =====
      snackBarTheme: SnackBarThemeData(
        // backgroundColor: AppColors.grey900,
        contentTextStyle: AppTextStyles.snackbarText,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        ),
      ),

      // ===== DIVIDER THEME =====
      dividerTheme: DividerThemeData(
        // color: AppColors.grey200,
        thickness: AppDimensions.dividerThickness,
        space: AppDimensions.space16,
      ),

      // ===== CHIP THEME =====
      chipTheme: ChipThemeData(
        // backgroundColor: AppColors.grey100,
        deleteIconColor: AppColors.textSecondary,
        // disabledColor: AppColors.grey200,
        selectedColor: AppColors.primaryLight,
        // secondarySelectedColor: AppColors.secondaryLight,
        labelPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.chipPadding,
        ),
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingSM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
        ),
        labelStyle: AppTextStyles.chipText,
        secondaryLabelStyle: AppTextStyles.chipText,
        brightness: Brightness.light,
      ),

      // ===== LIST TILE THEME =====
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPaddingMD,
          vertical: AppDimensions.verticalPaddingSM,
        ),
        minVerticalPadding: AppDimensions.verticalPaddingSM,
        iconColor: AppColors.textPrimary,
        textColor: AppColors.textPrimary,
        titleTextStyle: AppTextStyles.listTileTitle,
        subtitleTextStyle: AppTextStyles.listTileSubtitle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        ),
      ),

      // ===== SWITCH THEME =====
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return Colors.grey;
        }),
      ),

      // ===== CHECKBOX THEME =====
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.grey;
        }),
        checkColor: WidgetStateProperty.all(AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
        ),
      ),

      // ===== RADIO THEME =====
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.grey;
        }),
      ),

      // ===== SLIDER THEME =====
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: Colors.grey,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primaryLight.withValues(alpha: 0.3),
        trackHeight: AppDimensions.sliderTrackHeight,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: AppDimensions.sliderThumbRadius,
        ),
      ),

      // ===== PROGRESS INDICATOR THEME =====
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: Colors.grey,
        circularTrackColor: Colors.grey,
      ),

      // ===== TAB BAR THEME =====
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTextStyles.tabText,
        unselectedLabelStyle: AppTextStyles.tabText,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppDimensions.tabIndicatorThickness,
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      // ===== BOTTOM NAVIGATION BAR THEME =====
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.bottomNavLabel,
        unselectedLabelStyle: AppTextStyles.bottomNavLabel,
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevationMedium,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // ===== NAVIGATION BAR THEME (Material 3) =====
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryLight,
        height: AppDimensions.bottomNavHeight,
        labelTextStyle: WidgetStateProperty.all(AppTextStyles.bottomNavLabel),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: AppColors.primary,
              size: AppDimensions.bottomNavIconSizeLarge,
            );
          }
          return IconThemeData(
            color: AppColors.textSecondary,
            size: AppDimensions.bottomNavIconSize,
          );
        }),
      ),

      // ===== TOOLTIP THEME =====
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
        ),
        textStyle: AppTextStyles.tooltipText,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMD,
          vertical: AppDimensions.paddingSM,
        ),
      ),

      // ===== BADGE THEME =====
      badgeTheme: BadgeThemeData(
        backgroundColor: AppColors.error,
        // textColor: AppColors.onError,
        textStyle: AppTextStyles.badgeText,
        smallSize: AppDimensions.badgeDot,
        largeSize: AppDimensions.badgeSize,
      ),

      // ===== DRAWER THEME =====
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.surface,
        elevation: AppDimensions.elevationHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppDimensions.radiusLG),
          ),
        ),
      ),

      // ===== POPUP MENU THEME =====
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surface,
        elevation: AppDimensions.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        ),
        textStyle: AppTextStyles.bodyMedium,
      ),

      // ===== BANNER THEME =====
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: AppTextStyles.bodyMedium,
      ),

      // ===== EXPANSION TILE THEME =====
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: AppColors.surface,
        collapsedBackgroundColor: AppColors.surface,
        textColor: AppColors.textPrimary,
        iconColor: AppColors.textPrimary,
        collapsedTextColor: AppColors.textPrimary,
        collapsedIconColor: AppColors.textSecondary,
      ),
    );
  }

  // ==================== DARK THEME ====================

  static ThemeData get darkTheme {
    return ThemeData(
      // ===== BRIGHTNESS =====
      brightness: Brightness.dark,
      useMaterial3: true,

      // ===== COLOR SCHEME =====
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.primaryDark,
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        onSecondary: AppColors.secondaryDark,
        secondaryContainer: AppColors.secondaryDark,
        onSecondaryContainer: AppColors.secondary,
        // tertiary: AppColors.accent,
        onTertiary: Colors.black,
        error: AppColors.error,
        onError: AppColors.errorDark,
        errorContainer: AppColors.errorDark,
        onErrorContainer: AppColors.error,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        surfaceContainer: AppColors.surfaceDark,
        onSurfaceVariant: AppColors.textSecondaryDark,
        outline: Colors.grey,
        shadow: Colors.black87,
        inverseSurface: Colors.grey,
        onInverseSurface: Colors.black,
        inversePrimary: AppColors.primaryDark,
      ),

      // ===== SCAFFOLD =====
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // ===== APP BAR THEME =====
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: AppDimensions.appBarHeight,
        titleTextStyle: AppTextStyles.appBarTitle.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textPrimaryDark,
          size: AppDimensions.appBarIconSize,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // ===== TEXT THEME =====
      textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: AppTextStyles.displayLarge.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            displayMedium: AppTextStyles.displayMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            displaySmall: AppTextStyles.displaySmall.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            headlineLarge: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            headlineMedium: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            headlineSmall: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            titleLarge: AppTextStyles.titleLarge.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            titleMedium: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            titleSmall: AppTextStyles.titleSmall.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            bodyLarge: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            bodyMedium: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            bodySmall: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
            ),
            labelLarge: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            labelMedium: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            labelSmall: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondaryDark,
            ),
          ),

      // ===== PRIMARY TEXT THEME =====
      primaryTextTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),

      // ===== ICON THEME =====
      iconTheme: IconThemeData(
        color: AppColors.textPrimaryDark,
        size: AppDimensions.iconMD,
      ),

      // ===== CARD THEME =====
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: AppDimensions.cardElevation,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        margin: EdgeInsets.all(AppDimensions.cardMargin),
      ),

      // ===== ELEVATED BUTTON THEME =====
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.primaryDark,
          minimumSize: Size(
            AppDimensions.buttonWidthMD,
            AppDimensions.buttonHeightLG,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          elevation: AppDimensions.elevationLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ===== TEXT BUTTON THEME =====
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          minimumSize: Size(
            AppDimensions.buttonWidthSM,
            AppDimensions.buttonHeightMD,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMD,
            vertical: AppDimensions.paddingSM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ===== OUTLINED BUTTON THEME =====
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          minimumSize: Size(
            AppDimensions.buttonWidthMD,
            AppDimensions.buttonHeightLG,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          side: BorderSide(
            color: AppColors.primaryLight,
            width: AppDimensions.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ===== ICON BUTTON THEME =====
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.textPrimaryDark,
          iconSize: AppDimensions.iconMD,
        ),
      ),

      // ===== FLOATING ACTION BUTTON THEME =====
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.primaryDark,
        elevation: AppDimensions.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        ),
        iconSize: AppDimensions.fabIconSize,
      ),

      // ===== INPUT DECORATION THEME =====
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.inputPadding,
          vertical: AppDimensions.verticalPaddingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            color: Colors.grey,
            width: AppDimensions.inputBorderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            color: Colors.grey,
            width: AppDimensions.inputBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            color: AppColors.primaryLight,
            width: AppDimensions.inputBorderWidthFocused,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppDimensions.inputBorderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppDimensions.inputBorderWidthFocused,
          ),
        ),
        labelStyle: AppTextStyles.inputLabel.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        hintStyle: AppTextStyles.hintText.copyWith(color: Colors.grey),
        errorStyle: AppTextStyles.errorText.copyWith(color: AppColors.error),
        helperStyle: AppTextStyles.helperText.copyWith(color: Colors.grey),
      ),

      // ===== DIALOG THEME =====
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceDark,
        elevation: AppDimensions.elevationHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.dialogRadius),
        ),
        titleTextStyle: AppTextStyles.dialogTitle.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        contentTextStyle: AppTextStyles.dialogContent.copyWith(
          color: AppColors.textSecondaryDark,
        ),
      ),

      // ===== BOTTOM SHEET THEME =====
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        elevation: AppDimensions.elevationHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.bottomSheetRadius),
          ),
        ),
      ),

      // ===== SNACKBAR THEME =====
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey,
        contentTextStyle: AppTextStyles.snackbarText.copyWith(
          color: AppColors.textPrimary,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        ),
      ),

      // ===== DIVIDER THEME =====
      dividerTheme: DividerThemeData(
        color: Colors.grey,
        thickness: AppDimensions.dividerThickness,
        space: AppDimensions.space16,
      ),

      // ===== CHIP THEME =====
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey,
        deleteIconColor: AppColors.textSecondaryDark,
        disabledColor: Colors.grey,
        selectedColor: AppColors.primaryDark,
        secondarySelectedColor: AppColors.secondaryDark,
        labelPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.chipPadding,
        ),
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingSM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
        ),
        labelStyle: AppTextStyles.chipText.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        secondaryLabelStyle: AppTextStyles.chipText.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        brightness: Brightness.dark,
      ),

      // ===== LIST TILE THEME =====
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPaddingMD,
          vertical: AppDimensions.verticalPaddingSM,
        ),
        minVerticalPadding: AppDimensions.verticalPaddingSM,
        iconColor: AppColors.textPrimaryDark,
        textColor: AppColors.textPrimaryDark,
        titleTextStyle: AppTextStyles.listTileTitle.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        subtitleTextStyle: AppTextStyles.listTileSubtitle.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        ),
      ),

      // ===== SWITCH THEME =====
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryDark;
          }
          return Colors.grey;
        }),
      ),

      // ===== CHECKBOX THEME =====
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return Colors.grey;
        }),
        checkColor: WidgetStateProperty.all(AppColors.primaryDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
        ),
      ),

      // ===== RADIO THEME =====
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return Colors.grey;
        }),
      ),

      // ===== SLIDER THEME =====
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryLight,
        inactiveTrackColor: Colors.grey,
        thumbColor: AppColors.primaryLight,
        overlayColor: AppColors.primaryDark.withValues(alpha: .3),
        trackHeight: AppDimensions.sliderTrackHeight,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: AppDimensions.sliderThumbRadius,
        ),
      ),

      // ===== PROGRESS INDICATOR THEME =====
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: Colors.grey,
        circularTrackColor: Colors.grey,
      ),

      // ===== TAB BAR THEME =====
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryLight,
        unselectedLabelColor: AppColors.textSecondaryDark,
        labelStyle: AppTextStyles.tabText,
        unselectedLabelStyle: AppTextStyles.tabText,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primaryLight,
            width: AppDimensions.tabIndicatorThickness,
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      // ===== BOTTOM NAVIGATION BAR THEME =====
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textSecondaryDark,
        selectedLabelStyle: AppTextStyles.bottomNavLabel,
        unselectedLabelStyle: AppTextStyles.bottomNavLabel,
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevationMedium,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // ===== NAVIGATION BAR THEME (Material 3) =====
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.primaryDark,
        height: AppDimensions.bottomNavHeight,
        labelTextStyle: WidgetStateProperty.all(
          AppTextStyles.bottomNavLabel.copyWith(
            color: AppColors.textPrimaryDark,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: AppColors.primaryLight,
              size: AppDimensions.bottomNavIconSizeLarge,
            );
          }
          return IconThemeData(
            color: AppColors.textSecondaryDark,
            size: AppDimensions.bottomNavIconSize,
          );
        }),
      ),

      // ===== TOOLTIP THEME =====
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
        ),
        textStyle: AppTextStyles.tooltipText.copyWith(
          color: AppColors.textPrimary,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMD,
          vertical: AppDimensions.paddingSM,
        ),
      ),

      // ===== BADGE THEME =====
      badgeTheme: BadgeThemeData(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        textStyle: AppTextStyles.badgeText,
        smallSize: AppDimensions.badgeDot,
        largeSize: AppDimensions.badgeSize,
      ),

      // ===== DRAWER THEME =====
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.surfaceDark,
        elevation: AppDimensions.elevationHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppDimensions.radiusLG),
          ),
        ),
      ),

      // ===== POPUP MENU THEME =====
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceDark,
        elevation: AppDimensions.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        ),
        textStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
      ),

      // ===== BANNER THEME =====
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: AppColors.surfaceDark,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
      ),

      // ===== EXPANSION TILE THEME =====
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: AppColors.surfaceDark,
        collapsedBackgroundColor: AppColors.surfaceDark,
        textColor: AppColors.textPrimaryDark,
        iconColor: AppColors.textPrimaryDark,
        collapsedTextColor: AppColors.textPrimaryDark,
        collapsedIconColor: AppColors.textSecondaryDark,
      ),
    );
  }
}
