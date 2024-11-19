import 'package:a195_flutter_fundamental_project/data/model/api_response_model.dart';
import 'package:a195_flutter_fundamental_project/data/model/restaurant_model.dart';
import 'package:a195_flutter_fundamental_project/data/service/api_service.dart';
import 'package:a195_flutter_fundamental_project/module/home/home_provider.dart';
import 'package:a195_flutter_fundamental_project/module/settings/settings_provider.dart';
import 'package:a195_flutter_fundamental_project/util/view_result_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_provider_test.mocks.dart';

@GenerateMocks([ApiService, SettingsProvider])
void main() {
  late MockApiService mockApiService;
  late HomeProvider homeProvider;

  setUp(() {
    mockApiService = MockApiService();
    homeProvider = HomeProvider(mockApiService);
  });

  group('HomeProvider Tests', () {
    test('fetchData updates state to ViewLoadedState on success', () async {
      // Arrange
      final mockRestaurants = [
        Restaurant(
          id: '1',
          name: 'Restaurant 1',
          description: 'Description 1',
          pictureId: '1',
          city: 'City 1',
          rating: 4.1,
        )
      ];

      when(mockApiService.getRestaurants()).thenAnswer(
        (_) async => ApiResponse(
          error: false,
          restaurants: mockRestaurants,
        ),
      );

      // Act
      await homeProvider.fetchData();

      // Assert
      expect(homeProvider.resultState, isA<ViewLoadedState>());
      expect(
        (homeProvider.resultState as ViewLoadedState).restaurants,
        mockRestaurants,
      );
    });

    test('fetchData updates state to ViewErrorState on failure', () async {
      // Arrange
      when(mockApiService.getRestaurants()).thenThrow(Exception());

      // Act
      await homeProvider.fetchData();

      // Assert
      expect(homeProvider.resultState, isA<ViewErrorState>());
      expect(
        (homeProvider.resultState as ViewErrorState).error,
        ApiService.exceptionMessage,
      );
    });
  });
}
