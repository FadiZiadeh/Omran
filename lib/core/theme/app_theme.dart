import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme(
      brightness: Brightness.light,

      primary: AppColors.primary,
      onPrimary: Colors.white,

      secondary: AppColors.primary,
      onSecondary: Colors.white,

      tertiary: AppColors.green,
      onTertiary: Colors.white,

      error: Colors.red,
      onError: Colors.white,

      surface: Colors.white,
      onSurface: AppColors.text,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.text,
      ),
      bodyMedium: TextStyle(
        color: AppColors.text,
      ),
      titleLarge: TextStyle(
        color: AppColors.text,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    // 🖤 Main background
    scaffoldBackgroundColor: AppColors.darkBackground,

    // Omran dark-mode palette
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      // 🟢 Main brand color
      primary: AppColors.green,
      onPrimary: Colors.white,

      // ⚪ Secondary
      secondary: Colors.white,
      onSecondary: Colors.black,

      // 🟢 Tertiary / accent
      tertiary: AppColors.green,
      onTertiary: Colors.white,

      error: Colors.redAccent,
      onError: Colors.white,

      // 🖤 Surfaces
      surface: AppColors.darkSurface,
      onSurface: Colors.white,
    ),

    // ⚪ Main text
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        color: Color(0xFFBDBDBD),
      ),
      titleLarge: TextStyle(
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
      ),
    ),

    // Search fields / text fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,

      hintStyle: const TextStyle(
        color: Color(0xFF9E9E9E),
      ),

      prefixIconColor: Colors.white70,
      suffixIconColor: Colors.white70,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.green,
          width: 2,
        ),
      ),
    ),

    // 🟢 Main buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),

    // Dividers
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2A2A2A),
    ),

    // Icons
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
}