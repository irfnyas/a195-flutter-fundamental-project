import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api/api_service.dart';
import 'main_provider.dart';
import 'module/detail/detail_provider.dart';
import 'module/home/home_provider.dart';
import 'util/route.dart';
import 'util/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailProvider(context.read<ApiService>()),
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
    return Consumer<MainProvider>(
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
