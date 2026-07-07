import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.charcoalBlack,
        onPrimary: AppColors.softIvory,
        secondary: AppColors.deepIndigo,
        onSecondary: AppColors.softIvory,
        surface: AppColors.riceWhite,
        onSurface: AppColors.charcoalBlack,
        error: Color(0xFF8C3A3A),
        onError: AppColors.riceWhite,
      ),
      scaffoldBackgroundColor: AppColors.softIvory,
      textTheme: AppTypography.getTextTheme(isDark: false),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.charcoalBlack),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.charcoalBlack,
          foregroundColor: AppColors.softIvory,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.softIvory,
        onPrimary: AppColors.charcoalBlack,
        secondary: AppColors.teaBrown,
        onSecondary: AppColors.charcoalBlack,
        surface: AppColors.darkSlate,
        onSurface: AppColors.softIvory,
        error: Color(0xFF8C3A3A),
        onError: AppColors.riceWhite,
      ),
      scaffoldBackgroundColor: AppColors.deepIndigo,
      textTheme: AppTypography.getTextTheme(isDark: true),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.softIvory),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.softIvory,
          foregroundColor: AppColors.charcoalBlack,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
