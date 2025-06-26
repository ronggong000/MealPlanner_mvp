import 'package:flutter/material.dart';

/// App color palette for centralized color management
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Background colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundPink = Color(0xFFF2E8EB);

  // Navigation colors
  static const Color navigationSelected = Color(0xFF1A0F0F);
  static const Color navigationUnselected = Color(0xFF8C5C5C);

  // Primary action button colors
  static const Color primaryButtonBackground = Color(0xFFE82933);
  static const Color primaryButtonText = Color(0xFFFFFFFF);

  // Text colors
  static const Color titleText = Color(0xFF1C0D0D);
  static const Color subtitleText = Color(0xFF994D52);

  // Additional colors for compatibility
  static const Color backgroundColor = backgroundPink;
  static const Color cardBackground = backgroundWhite;
  static const Color errorText = error;

  // Additional semantic colors
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFE82933);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryButtonBackground, Color(0xFFD32F2F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow colors
  static Color shadowColor = Colors.black.withOpacity(0.1);
  static Color cardShadow = Colors.grey.withOpacity(0.1);
}

/// App theme configuration
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryButtonBackground,
        brightness: Brightness.light,
        primary: AppColors.primaryButtonBackground,
        onPrimary: AppColors.primaryButtonText,
        surface: AppColors.backgroundWhite,
        onSurface: AppColors.titleText,
      ),
      scaffoldBackgroundColor: AppColors.backgroundPink,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryButtonBackground,
        foregroundColor: AppColors.primaryButtonText,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButtonBackground,
          foregroundColor: AppColors.primaryButtonText,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.titleText,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.titleText,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColors.titleText,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.titleText,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: AppColors.titleText,
        ),
        bodyMedium: TextStyle(
          color: AppColors.subtitleText,
        ),
        bodySmall: TextStyle(
          color: AppColors.subtitleText,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.backgroundWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: AppColors.cardShadow,
      ),
    );
  }
}