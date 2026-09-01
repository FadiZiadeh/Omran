import 'package:flutter/material.dart';
import 'package:omran/core/services/storage_service.dart';

class LocaleController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final languageCode = await _storageService.getLocale();

    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) {
      return;
    }

    _locale = locale;

    await _storageService.setLocale(locale.languageCode);

    notifyListeners();
  }
}

final localeController = LocaleController();