import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextTheme getTextTheme({required bool isDark}) {
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final secondaryTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return TextTheme(
      // Headlines - Editorial Elegance (Cormorant Garamond)
      displayLarge: GoogleFonts.cormorantGaramond(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.cormorantGaramond(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.cormorantGaramond(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.22,
      ),
      
      // Titles - Editorial and Features
      headlineLarge: GoogleFonts.cormorantGaramond(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.cormorantGaramond(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.33,
      ),

      // UI Text - Modern Asian Elegance (Inter Variable)
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.43,
        letterSpacing: 0.1,
      ),

      // Body Text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.5,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        height: 1.33,
        letterSpacing: 0.4,
      ),

      // Labels & Buttons
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }
}
