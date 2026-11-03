import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Headings: Playfair Display. Body: Manrope.
class AppText {
  AppText._();

  static TextStyle display(double size, {Color color = AppColors.white, FontWeight weight = FontWeight.w500, double height = 1.12}) =>
      GoogleFonts.playfairDisplay(fontSize: size, fontWeight: weight, height: height, color: color);

  static TextStyle body({double size = 15, Color color = AppColors.charcoal, double height = 1.7, FontWeight weight = FontWeight.w400}) =>
      GoogleFonts.manrope(fontSize: size, fontWeight: weight, height: height, color: color);

  static TextStyle eyebrow({Color color = AppColors.gold}) =>
      GoogleFonts.manrope(fontSize: 11, letterSpacing: 3, fontWeight: FontWeight.w700, color: color);

  static TextStyle get button => GoogleFonts.manrope(fontSize: 12, letterSpacing: 1.6, fontWeight: FontWeight.w700);
}
