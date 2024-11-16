import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void switchThemeMode(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
