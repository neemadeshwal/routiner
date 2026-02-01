import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App-wide dimension constants using ScreenUtil for responsive design

/// Design based on 414x896 screen size

class AppDimensions {
  // Private constructor to prevent instantiation
  AppDimensions._();

  // ==================== SPACING ====================

  static double get space4 => 4.w;

  static double get space8 => 8.w;

  static double get space12 => 12.w;

  static double get space16 => 16.w;

  static double get space20 => 20.w;

  static double get space24 => 24.w;

  static double get space32 => 32.w;

  static double get space40 => 40.w;

  static double get space48 => 48.w;

  static double get space64 => 64.w;

  // ==================== PADDING ====================

  static double get paddingXS => 4.w;

  static double get paddingSM => 8.w;

  static double get paddingMD => 12.w;

  static double get padding => 16.w;

  static double get paddingLG => 20.w;

  static double get paddingXL => 24.w;

  static double get paddingXXL => 32.w;

  // Horizontal paddings
  static double get horizontalPaddingSM => 8.w;
  static double get horizontalPaddingMD => 16.w;
  static double get horizontalPaddingLG => 24.w;

  // Vertical paddings
  static double get verticalPaddingSM => 8.h;
  static double get verticalPaddingMD => 16.h;
  static double get verticalPaddingLG => 24.h;

  // ==================== MARGIN ====================

  static double get marginXS => 4.w;

  static double get marginSM => 8.w;

  static double get marginMD => 12.w;

  static double get margin => 16.w;

  static double get marginLG => 20.w;

  static double get marginXL => 24.w;

  static double get marginXXL => 32.w;

  // ==================== BORDER RADIUS ====================

  static double get radiusXXS => 2.r;

  static double get radiusXS => 4.r;

  static double get radiusSM => 6.r;

  static double get radiusMD => 8.r;

  static double get radius => 12.r;

  static double get radiusLG => 16.r;

  static double get radiusXL => 20.r;

  static double get radiusXXL => 24.r;

  static double get radiusHuge => 32.r;

  static double get radiusCircle => 100.r;

  // Card specific
  static double get cardRadius => 12.r;
  static double get buttonRadius => 8.r;
  static double get inputRadius => 8.r;
  static double get dialogRadius => 16.r;

  // ==================== FONT SIZES ====================

  static double get fontXXS => 10.sp;

  static double get fontXS => 12.sp;

  static double get fontSM => 14.sp;

  static double get fontMD => 16.sp;

  static double get fontLG => 18.sp;

  static double get fontXL => 20.sp;

  static double get fontXXL => 24.sp;

  static double get fontHuge => 28.sp;

  static double get fontXHuge => 32.sp;

  static double get fontDisplay => 40.sp;

  static double get fontMassive => 48.sp;

  // Semantic font sizes
  static double get caption => 12.sp;
  static double get bodySmall => 14.sp;
  static double get body => 16.sp;
  static double get bodyLarge => 18.sp;
  static double get subtitle => 20.sp;
  static double get title => 24.sp;
  static double get heading => 28.sp;
  static double get headingLarge => 32.sp;
  static double get display => 40.sp;

  // ==================== ICON SIZES ====================

  static double get iconXXS => 12.r;

  static double get iconXS => 16.r;

  static double get iconSM => 20.r;

  static double get iconMD => 24.r;

  static double get iconLG => 28.r;

  static double get iconXL => 32.r;

  static double get iconXXL => 40.r;

  static double get iconHuge => 48.r;

  static double get iconXHuge => 64.r;

  static double get icon5XHuge => 474.r;

  // ==================== BUTTON DIMENSIONS ====================

  static double get buttonHeightSM => 32.h;

  static double get buttonHeightMD => 40.h;

  static double get buttonHeightLG => 48.h;

  static double get buttonHeightXL => 56.h;

  // Button widths
  static double get buttonWidthSM => 80.w;
  static double get buttonWidthMD => 120.w;
  static double get buttonWidthLG => 160.w;
  static double get buttonWidthXL => 200.w;
  static double get buttonWidthFull => double.infinity;

  // Button padding
  static double get buttonPaddingHorizontal => 24.w;
  static double get buttonPaddingVertical => 12.h;

  // ==================== APPBAR DIMENSIONS ====================

  static double get appBarHeight => 56.h;

  static double get appBarElevation => 0;

  static double get appBarIconSize => 24.r;

  // ==================== BOTTOM NAVIGATION ====================

  static double get bottomNavHeight => 60.h;

  static double get bottomNavIconSize => 24.r;

  static double get bottomNavIconSizeLarge => 28.r;

  // ==================== CARD DIMENSIONS ====================

  /// Card elevation
  static double get cardElevation => 2;

  /// Card elevation on hover/press
  static double get cardElevationHigh => 8;

  static double get cardPadding => 16.w;

  static double get cardMargin => 8.w;

  // ==================== LIST ITEM DIMENSIONS ====================

  static double get listItemHeightSM => 48.h;

  static double get listItemHeightMD => 56.h;

  static double get listItemHeightLG => 72.h;

  static double get listItemHeightXL => 88.h;

  // ==================== DIVIDER DIMENSIONS ====================

  static double get dividerThickness => 1.h;

  static double get dividerIndent => 16.w;

  // ==================== INPUT FIELD DIMENSIONS ====================

  static double get inputHeight => 48.h;

  static double get inputHeightSM => 40.h;

  static double get inputHeightLG => 56.h;

  static double get inputBorderWidth => 1.w;

  static double get inputBorderWidthFocused => 2.w;

  static double get inputPadding => 16.w;

  // ==================== AVATAR SIZES ====================

  static double get avatarXS => 24.r;

  static double get avatarSM => 32.r;

  static double get avatarMD => 40.r;

  static double get avatarLG => 48.r;

  static double get avatarXL => 64.r;

  static double get avatarXXL => 80.r;

  static double get avatarHuge => 120.r;

  // ==================== IMAGE DIMENSIONS ====================

  static double get thumbnailSize => 80.r;

  static double get imageSmall => 120.r;

  static double get imageMedium => 200.r;

  static double get imageLarge => 300.r;

  // ==================== LOGO DIMENSIONS ====================

  static double get logoWidth => 240.w;
  static double get logoHeight => 73.h;

  // ==================== DIALOG DIMENSIONS ====================

  /// Dialog width - 0.85.sw (85% of screen width)
  static double get dialogWidth => 0.85.sw;

  static double get dialogMaxWidth => 400.w;

  static double get dialogPadding => 24.w;

  // ==================== BOTTOM SHEET DIMENSIONS ====================

  /// Bottom sheet max height - 0.9.sh (90% of screen height)
  static double get bottomSheetMaxHeight => 0.9.sh;

  static double get bottomSheetRadius => 20.r;

  static double get bottomSheetHandleWidth => 40.w;

  static double get bottomSheetHandleHeight => 4.h;

  static double get bottomSheetPadding => 20.w;

  // ==================== CHIP DIMENSIONS ====================

  static double get chipHeight => 32.h;

  static double get chipPadding => 12.w;

  static double get chipSpacing => 8.w;

  // ==================== TAB BAR DIMENSIONS ====================

  static double get tabBarHeight => 48.h;

  static double get tabIndicatorThickness => 2.h;

  static double get tabMinWidth => 90.w;

  // ==================== LOADING INDICATOR SIZES ====================

  static double get loadingSM => 16.r;

  static double get loadingMD => 24.r;

  static double get loadingLG => 32.r;

  static double get loadingXL => 48.r;

  // ==================== FLOATING ACTION BUTTON ====================

  static double get fabSize => 56.r;

  static double get fabSizeSM => 40.r;

  static double get fabSizeLG => 64.r;

  static double get fabIconSize => 24.r;

  // ==================== CONTAINER WIDTHS ====================

  static double get containerWidthXS => 100.w;

  static double get containerWidthSM => 150.w;

  static double get containerWidthMD => 200.w;

  static double get containerWidthLG => 300.w;

  static double get containerWidthXL => 400.w;

  // ==================== CONTAINER HEIGHTS ====================

  static double get containerHeightXS => 80.h;

  static double get containerHeightSM => 120.h;

  static double get containerHeightMD => 160.h;

  static double get containerHeightLG => 200.h;

  static double get containerHeightXL => 300.h;

  // ==================== SCREEN DIMENSIONS ====================

  /// Full screen width - 1.swx
  static double get screenWidth => 1.sw;

  /// Full screen height - 1.sh
  static double get screenHeight => 1.sh;

  /// Half screen width - 0.5.sw
  static double get halfScreenWidth => 0.5.sw;

  /// Half screen height - 0.5.sh
  static double get halfScreenHeight => 0.5.sh;

  /// 75% screen width - 0.75.sw
  static double get threeQuarterScreenWidth => 0.75.sw;

  /// 75% screen height - 0.75.sh
  static double get threeQuarterScreenHeight => 0.75.sh;

  // ==================== GRID SPACING ====================

  static double get gridMainAxisSpacing => 12.h;

  static double get gridCrossAxisSpacing => 12.w;

  static double get gridPadding => 16.w;

  // ==================== BORDER WIDTH ====================

  static double get borderThin => 0.5.w;

  static double get border => 1.w;

  static double get borderThick => 2.w;

  static double get borderXThick => 3.w;

  // ==================== SHADOWS & ELEVATION ====================

  /// No elevation
  static double get elevationNone => 0;

  /// Low elevation
  static double get elevationLow => 2;

  /// Medium elevation
  static double get elevationMedium => 4;

  /// High elevation
  static double get elevationHigh => 8;

  /// Extra high elevation
  static double get elevationXHigh => 16;

  // ==================== SLIDER DIMENSIONS ====================

  static double get sliderHeight => 48.h;

  static double get sliderTrackHeight => 4.h;

  static double get sliderThumbRadius => 10.r;

  // ==================== SEARCH BAR DIMENSIONS ====================

  static double get searchBarHeight => 48.h;

  static double get searchBarIconSize => 20.r;

  // ==================== BADGE DIMENSIONS ====================

  static double get badgeSize => 20.r;

  static double get badgeSizeSM => 16.r;

  static double get badgeDot => 8.r;

  // ==================== STEPPER DIMENSIONS ====================

  static double get stepperIconSize => 24.r;

  static double get stepperLineThickness => 2.h;

  // ==================== SAFE AREA PADDING ====================

  static double get statusBarHeight => ScreenUtil().statusBarHeight;

  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  // ==================== UTILITY GETTERS ====================

  /// Screen pixel ratio
  static double? get pixelRatio => ScreenUtil().pixelRatio;

  /// Text scale factor
  static double get textScaleFactor => ScreenUtil().textScaleFactor;
}
