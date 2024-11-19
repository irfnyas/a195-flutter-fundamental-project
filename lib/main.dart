import 'package:a195_flutter_fundamental_project/module/notification/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/service/api_service.dart';
import 'module/detail/detail_provider.dart';
import 'module/home/home_provider.dart';
import 'module/notification/notification_service.dart';
import 'module/settings/settings_provider.dart';
import 'module/wishlist/wishlist_provider.dart';
import 'util/route.dart';
import 'util/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiService(),
        ),
        Provider(create: (context) => NotificationService()..init()),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(
            context.read<NotificationService>(),
          )..requestPermissions(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (_, provider, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: provider.themeMode,
          darkTheme: darkTheme,
          theme: lightTheme,
          initialRoute: RouteEnum.values.first.name,
          routes: routes,
        );
      },
    );
  }
}
