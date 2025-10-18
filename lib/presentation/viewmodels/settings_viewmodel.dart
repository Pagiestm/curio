import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  Locale _locale = const Locale('fr'); // Langue par défaut
  ThemeMode _themeMode = ThemeMode.light; // Thème par défaut

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  void changeLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }

  void changeThemeMode(ThemeMode newThemeMode) {
    if (_themeMode != newThemeMode) {
      _themeMode = newThemeMode;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
