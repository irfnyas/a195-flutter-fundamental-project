import 'package:a195_flutter_fundamental_project/main.dart' as app;
import 'package:a195_flutter_fundamental_project/module/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('first time using app', (tester) async {
      // clear cache
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // load app widget
      await app.main();

      // home screen
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(RestaurantCard), findsWidgets);

      // nav to detail screen
      final firstRestaurantCard = find.byType(RestaurantCard).first;
      final firstRestaurantCardWidget =
          tester.firstWidget(find.byType(RestaurantCard)) as RestaurantCard;
      final restaurantName = firstRestaurantCardWidget.restaurant.name ?? '';

      await tester.tap(firstRestaurantCard);
      await tester.pump();
      expect(find.byType(Text), findsAtLeastNWidgets(1));

      await tester.pump(const Duration(seconds: 3));
      expect(find.text(restaurantName), findsAtLeastNWidgets(2));
    });
  });
}
