import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.forestGreen,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.forestGreen,
        secondary: AppColors.charcoalBlack,
        surface: AppColors.surface,
        error: AppColors.errorSoftRed,
        onPrimary: AppColors.primaryWhite,
        onSecondary: AppColors.primaryWhite,
        onSurface: AppColors.charcoalBlack,
        onError: AppColors.primaryWhite,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display,
        headlineLarge: AppTypography.heading,
        titleLarge: AppTypography.title,
        bodyLarge: AppTypography.body,
        labelSmall: AppTypography.caption,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forestGreen,
          foregroundColor: AppColors.primaryWhite,
          textStyle: AppTypography.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded cards/buttons
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.forestGreen,
          side: const BorderSide(color: AppColors.forestGreen, width: 1),
          textStyle: AppTypography.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.primaryWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.forestGreen, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorSoftRed, width: 1),
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.lightGrey),
      ),
      cardTheme: CardTheme(
        color: AppColors.primaryWhite,
        elevation: 10,
        shadowColor: AppColors.charcoalBlack.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryWhite,
        selectedItemColor: AppColors.forestGreen,
        unselectedItemColor: AppColors.lightGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
      ),
    );
  }
}
