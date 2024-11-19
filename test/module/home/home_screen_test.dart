import 'package:a195_flutter_fundamental_project/data/model/api_response_model.dart';
import 'package:a195_flutter_fundamental_project/data/model/restaurant_model.dart';
import 'package:a195_flutter_fundamental_project/data/service/api_service.dart';
import 'package:a195_flutter_fundamental_project/module/home/home_provider.dart';
import 'package:a195_flutter_fundamental_project/module/home/home_screen.dart';
import 'package:a195_flutter_fundamental_project/module/notification/notification_provider.dart';
import 'package:a195_flutter_fundamental_project/module/settings/settings_provider.dart';
import 'package:a195_flutter_fundamental_project/util/view_result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_screen_test.mocks.dart';

@GenerateMocks([ApiService, SettingsProvider, NotificationProvider])
void main() {
  late MockApiService mockApiService;
  late HomeProvider homeProvider;
  late SettingsProvider settingsProvider;

  setUp(() async {
    mockApiService = MockApiService();
    homeProvider = HomeProvider(mockApiService);
    settingsProvider = MockSettingsProvider();
  });

  group('HomeScreen Tests', () {
    Widget createHomeScreen(HomeProvider provider) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>.value(
            value: homeProvider,
          ),
          ChangeNotifierProvider<SettingsProvider>.value(
            value: settingsProvider,
          ),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      );
    }

    testWidgets('displays loading indicator while fetching data',
        (tester) async {
      // Arrange
      when(mockApiService.getRestaurants())
          .thenAnswer((_) async => ApiResponse(error: false, restaurants: []));
      when(settingsProvider.isNotifEnabled).thenReturn(false);
      homeProvider.resultState = ViewLoadingState();

      // Act
      await tester.pumpWidget(createHomeScreen(homeProvider));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message on ViewErrorState', (tester) async {
      // Arrange
      when(mockApiService.getRestaurants()).thenThrow(Exception());
      when(settingsProvider.isNotifEnabled).thenReturn(false);

      // Act
      await homeProvider.fetchData();
      await tester.pumpWidget(createHomeScreen(homeProvider));
      await tester.pump();

      // Assert
      expect(find.byType(HomeErrorView), findsOneWidget);
    });

    testWidgets('displays list of restaurants on ViewLoadedState',
        (tester) async {
      // Arrange
      final mockRestaurants = [
        Restaurant(
          id: '1',
          name: 'Restaurant 1',
          description: 'Description 1',
          pictureId: '1',
          city: 'City 1',
          rating: 4.1,
        ),
        Restaurant(
          id: '2',
          name: 'Restaurant 2',
          description: 'Description 2',
          pictureId: '2',
          city: 'City 2',
          rating: 4.2,
        )
      ];

      when(mockApiService.getRestaurants()).thenAnswer(
        (_) async => ApiResponse(
          error: false,
          restaurants: mockRestaurants,
        ),
      );
      when(settingsProvider.isNotifEnabled).thenReturn(false);

      // Act
      await homeProvider.fetchData();
      await tester.pumpWidget(createHomeScreen(homeProvider));
      await tester.pump();

      // Assert
      expect(find.byType(RestaurantCard), findsNWidgets(2));
    });
  });
}
