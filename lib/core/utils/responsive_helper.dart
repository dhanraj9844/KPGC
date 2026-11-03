import 'package:flutter/widgets.dart';

/// Mobile < 600, tablet 600-1023, desktop >= 1024.
class Responsive {
  Responsive._();

  static double width(BuildContext c) => MediaQuery.sizeOf(c).width;
  static bool isMobile(BuildContext c) => width(c) < 600;
  static bool isTablet(BuildContext c) => width(c) >= 600 && width(c) < 1024;
  static bool isDesktop(BuildContext c) => width(c) >= 1024;

  static T pick<T>(BuildContext c, {required T mobile, T? tablet, required T desktop}) {
    if (isDesktop(c)) return desktop;
    if (isMobile(c)) return mobile;
    return tablet ?? desktop;
  }

  static double hPad(BuildContext c) => pick<double>(c, mobile: 20, tablet: 40, desktop: 72);
  static double vPad(BuildContext c) => pick<double>(c, mobile: 56, tablet: 80, desktop: 110);
}
