import 'package:flutter/material.dart';
import 'package:omran/core/services/storage_service.dart';

class ThemeController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> loadTheme() async {
    final isDarkMode = await _storageService.getDarkMode();

    _themeMode = isDarkMode
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners();
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode
        ? ThemeMode.dark
        : ThemeMode.light;

    await _storageService.setDarkMode(isDarkMode);

    notifyListeners();
  }
}

final themeController = ThemeController();