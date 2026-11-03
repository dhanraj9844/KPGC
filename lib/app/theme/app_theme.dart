import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.gold,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.forest,
      onPrimary: AppColors.white,
      secondary: AppColors.gold,
      surface: AppColors.ivory,
      onSurface: AppColors.charcoal,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.ivory,
      textTheme: GoogleFonts.manropeTextTheme(),
      splashFactory: NoSplash.splashFactory,
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
