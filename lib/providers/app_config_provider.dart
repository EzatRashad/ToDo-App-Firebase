import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  String applang = 'en';
  void changeTheme(ThemeMode newMode) {
    if (appTheme == newMode) {
      return;
    } else {
      appTheme = newMode;
      notifyListeners();
    }
  }

  void changeLang(String newLang) {
    if (applang == newLang) {
      return;
    } else {
      applang = newLang;
      notifyListeners();
    }
  }
}
