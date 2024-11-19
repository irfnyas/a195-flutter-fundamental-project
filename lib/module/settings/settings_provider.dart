import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/modal.dart';
import '../notification/notification_provider.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this.prefs) {
    readSettingsPreferences();
  }

  final SharedPreferences prefs;

  final kPrefsIsDarkMode = 'kPrefsIsDarkMode';
  final kPrefsIsNotifEnabled = 'kPrefsIsNotifEnabled';

  ThemeMode themeMode = ThemeMode.system;
  bool isNotifEnabled = true;

  Future<void> readSettingsPreferences() async {
    final prefsIsDarkMode = prefs.getBool(kPrefsIsDarkMode);
    final prefsIsNotifEnabled = prefs.getBool(kPrefsIsNotifEnabled);

    themeMode = switch (prefsIsDarkMode) {
      true => ThemeMode.dark,
      false => ThemeMode.light,
      _ => ThemeMode.system
    };

    isNotifEnabled = prefsIsNotifEnabled == true;
  }

  void switchThemeMode(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    prefs.setBool(kPrefsIsDarkMode, themeMode == ThemeMode.dark);

    final message = 'Theme changed to ${isDarkMode ? 'light' : 'dark'} mode';
    showSnackbar(context, message);

    notifyListeners();
  }

  void switchNotifStatus(BuildContext context) {
    isNotifEnabled = !isNotifEnabled;
    prefs.setBool(kPrefsIsNotifEnabled, isNotifEnabled);

    final message = 'Notification ${isNotifEnabled ? 'enabled' : 'disabled'}';
    showSnackbar(context, message);

    isNotifEnabled
        ? context.read<NotificationProvider>().scheduleDailyNotification()
        : context.read<NotificationProvider>().cancelAllPendingNotifications();

    notifyListeners();
  }
}
