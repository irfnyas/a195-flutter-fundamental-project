import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (_, provider, __) => ListView(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: provider.themeMode == ThemeMode.system
                  ? Theme.of(context).brightness == Brightness.dark
                  : provider.themeMode == ThemeMode.dark,
              onChanged: (_) => provider.switchThemeMode(context),
            ),
            SwitchListTile(
              title: const Text('Notification'),
              value: provider.isNotifEnabled,
              onChanged: (_) => provider.switchNotifStatus(context),
            ),
          ],
        ),
      ),
    );
  }
}
