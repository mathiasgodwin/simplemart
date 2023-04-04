import 'package:flutter/material.dart';

/// Styles - Contains the design system for the entire app.
/// Includes paddings, text styles, timings etc. Does not include colors.

/// Used for all animations in the  app
class Times {
  static const Duration fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const medium = Duration(milliseconds: 350);
  static const midslow = Duration(milliseconds: 500);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
}

class Sizes {
  static double hitScale = 1;
  static double get hit => 40 * hitScale;
}

class IconSizes {
  static double scale = 1;
  static double xs = 8;
  static double sm = 16;
  static double med = 24;
  static double lg = 30;
  static double xl = 40;
}

class Insets {
  static double scale = 1;
  static double offsetScale = 1;
  // Regular paddings
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get med => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 32 * scale;
  static double get xxl => 60 * scale;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class Corners {
  static const double btn = s5;

  static const double dialog = 12;

  /// Xs
  static const double s3 = 3;

  static BorderRadius get s3Border => BorderRadius.all(s3Radius);

  static Radius get s3Radius => const Radius.circular(s3);

  /// Small
  static const double s5 = 5;

  static BorderRadius get s5Border => BorderRadius.all(s5Radius);

  static Radius get s5Radius => const Radius.circular(s5);

  /// Medium
  static const double s8 = 8;

  static const BorderRadius s8Border = BorderRadius.all(s8Radius);

  static const Radius s8Radius = Radius.circular(s8);

  /// Large
  static const double s10 = 10;

  static BorderRadius get s10Border => BorderRadius.all(s10Radius);

  static Radius get s10Radius => const Radius.circular(s10);

  /// X Large
  static const double s14 = 14;

  static BorderRadius get s14Border => BorderRadius.all(s14Radius);

  static Radius get s14Radius => const Radius.circular(s14);
}

class Strokes {
  static const double thin = 1;
  static const double thick = 4;
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
          color: const Color(0xff333333).withOpacity(.15),
          blurRadius: 10,
        ),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
          color: const Color(0xff333333).withOpacity(.15),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ];
}

/// Font Sizes
/// You can use these directly if you need, but usually there should be a predefined style in TextStyles.
class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get scale => 1;
  static double get s10 => 10 * scale;
  static double get s15 => 15 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s14 => 14 * scale;
  static double get s16 => 16 * scale;
  static double get s24 => 24 * scale;
  static double get s48 => 48 * scale;
}

extension SpaceValue on int {
  Widget get horizontalSpace => SizedBox(width: toDouble());
  Widget get verticalSpace => SizedBox(height: toDouble());
}

class HSpace {
  const HSpace();
  static Widget get s5 => 5.horizontalSpace;
  static Widget get s10 => 10.horizontalSpace;
  static Widget get s15 => 15.horizontalSpace;
  static Widget get s20 => 20.horizontalSpace;
  static Widget get s25 => 25.horizontalSpace;
  static Widget get s30 => 30.horizontalSpace;
  static Widget get s40 => 40.horizontalSpace;
  static Widget get s60 => 60.horizontalSpace;
}

class VSpace {
  const VSpace();
  static Widget get s5 => 5.verticalSpace;
  static Widget get s10 => 10.verticalSpace;
  static Widget get s15 => 15.verticalSpace;
  static Widget get s20 => 20.verticalSpace;
  static Widget get s25 => 25.verticalSpace;
  static Widget get s30 => 30.verticalSpace;
  static Widget get s35 => 35.verticalSpace;
  static Widget get s40 => 40.verticalSpace;
  static Widget get s60 => 60.verticalSpace;
}

class ButtonSizes {
  static Size get min => const Size(double.infinity, 45);
}

enum ScreenSize { small, normal, large, xLarge }

extension FormFactor on BuildContext {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;

  bool get isXLarge => MediaQuery.of(this).size.shortestSide > desktop;
  bool get isLarge => MediaQuery.of(this).size.shortestSide > tablet;
  bool get isNormal => MediaQuery.of(this).size.shortestSide > handset;
  bool get isSmall => MediaQuery.of(this).size.shortestSide < handset;

  ScreenSize get screenSize {
    final deviceWidth = MediaQuery.of(this).size.shortestSide;
    if (deviceWidth > desktop) return ScreenSize.xLarge;
    if (deviceWidth > tablet) return ScreenSize.large;
    if (deviceWidth > handset) return ScreenSize.normal;
    return ScreenSize.small;
  }
}

extension NumberUtil on String {
  int? get toInt => int.tryParse(this);
  double? get toDouble => double.tryParse(this);
}
