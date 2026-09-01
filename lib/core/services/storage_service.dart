import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferencesAsync _preferences =
  SharedPreferencesAsync();

  static const String _isLoggedInKey = 'is_logged_in';
  static const String _localeKey = 'locale';
  static const String _isDarkModeKey = 'is_dark_mode';

  Future<void> setLoggedIn(bool value) async {
    await _preferences.setBool(_isLoggedInKey, value);
  }

  Future<bool> isLoggedIn() async {
    return await _preferences.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> clearLogin() async {
    await _preferences.remove(_isLoggedInKey);
  }

  Future<void> setLocale(String languageCode) async {
    await _preferences.setString(
      _localeKey,
      languageCode,
    );
  }

  Future<String?> getLocale() async {
    return await _preferences.getString(_localeKey);
  }

  Future<void> setDarkMode(bool value) async {
    await _preferences.setBool(
      _isDarkModeKey,
      value,
    );
  }

  Future<bool> getDarkMode() async {
    return await _preferences.getBool(_isDarkModeKey) ?? false;
  }
}