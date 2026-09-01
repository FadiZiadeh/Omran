
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
static ThemeData lightTheme = ThemeData(
brightness: Brightness.light,
useMaterial3: true,

scaffoldBackgroundColor: AppColors.background,

colorScheme: ColorScheme.fromSeed(
seedColor: AppColors.primary,
brightness: Brightness.light,
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
);

static ThemeData darkTheme = ThemeData(
brightness: Brightness.dark,
useMaterial3: true,

scaffoldBackgroundColor: Colors.black,

colorScheme: ColorScheme.fromSeed(
seedColor: Colors.white,
brightness: Brightness.dark,
),

inputDecorationTheme: InputDecorationTheme(
filled: true,
fillColor: const Color(0xFF1A1A1A),

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
color: Colors.white,
width: 2,
),
),
),

elevatedButtonTheme: ElevatedButtonThemeData(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.white,
foregroundColor: Colors.black,
minimumSize: const Size(double.infinity, 52),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
),
),
);
}
