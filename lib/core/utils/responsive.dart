import 'package:get/get.dart';

class Responsive {
  Responsive._();

  //  SCREEN SIZE
  static double get width => Get.width;
  static double get height => Get.height;

  static bool get isMobile => width < 600;
  static bool get isTablet => width >= 600 && width < 1200;
  static bool get isDesktop => width >= 1200;

  // PADDING
  static double get paddingXS => isMobile ? 8 : 12;
  static double get paddingS  => isMobile ? 12 : 16;
  static double get paddingM  => isMobile ? 16 : 20;
  static double get paddingL  => isMobile ? 20 : 24;
  static double get paddingXL => isMobile ? 24 : 32;

  //  MARGIN
  static double get marginXS => isMobile ? 4 : 8;
  static double get marginS  => isMobile ? 8 : 12;
  static double get marginM  => isMobile ? 12 : 16;
  static double get marginL  => isMobile ? 16 : 20;
  static double get marginXL => isMobile ? 20 : 24;

  //  SPACING
  static double get spaceXS => isMobile ? 4 : 6;
  static double get spaceS  => isMobile ? 8 : 12;
  static double get spaceM  => isMobile ? 16 : 20;
  static double get spaceL  => isMobile ? 24 : 32;
  static double get spaceXL => isMobile ? 32 : 48;

  //TEXT SIZES
  static double get textXS => isMobile ? 10 : 12;
  static double get textS  => isMobile ? 12 : 14;
  static double get textM  => isMobile ? 14 : 16;
  static double get textL  => isMobile ? 16 : 18;
  static double get textXL => isMobile ? 18 : 22;
  static double get textXXL => isMobile ? 22 : 26;

  // ICON SIZES
  static double get iconXS => isMobile ? 14 : 16;
  static double get iconS  => isMobile ? 18 : 20;
  static double get iconM  => isMobile ? 22 : 24;
  static double get iconL  => isMobile ? 26 : 30;
  static double get iconXL => isMobile ? 32 : 36;

  // BUTTON
  static double get buttonHeight => isMobile ? 52 : 56;
  static double get buttonWidth => isDesktop ? 260 : double.infinity;
  static double get buttonRadius => isMobile ? 8 : 12;

  //CARD
  static double get cardRadius => isMobile ? 10 : 14;
  static double get cardElevation => isMobile ? 2 : 4;

  // CONTENT WIDTH
  static double get contentWidth {
    if (isDesktop) return width * 0.65;
    if (isTablet) return width * 0.85;
    return width;
  }
}
