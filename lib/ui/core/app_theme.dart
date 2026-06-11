import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color charcoal = Color(0xFF202020);
  static const Color neonLime = Color(0xFFC9F158);
  static const Color lightGray = Color(0xFFF2F3F5);
  static const Color white = Color(0xFFFFFFFF);
  
  static const Color textPrimary = Color(0xFF202020);
  static const Color textSecondary = Color(0xFF7A7C80);
  static const Color textMuted = Color(0xFFA0A2A6);
  
  static const Color cardDark = Color(0xFF202020);
  static const Color borderLight = Color(0xFFE2E4E8);
}

class AppTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.spaceGroteskTextTheme(
      ThemeData.light().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightGray,
      colorScheme: const ColorScheme.light(
        primary: AppColors.charcoal,
        secondary: AppColors.neonLime,
        background: AppColors.lightGray,
        surface: AppColors.white,
        onPrimary: AppColors.white,
        onSecondary: AppColors.charcoal,
        onBackground: AppColors.charcoal,
        onSurface: AppColors.charcoal,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.2,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.charcoal),
        titleTextStyle: TextStyle(
          color: AppColors.charcoal,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
