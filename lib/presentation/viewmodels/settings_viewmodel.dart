import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  Locale _locale = const Locale('fr'); // Langue par défaut

  Locale get locale => _locale;

  void changeLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }
}
