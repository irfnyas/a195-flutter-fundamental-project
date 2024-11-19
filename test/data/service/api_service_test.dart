import 'package:a195_flutter_fundamental_project/data/model/api_response_model.dart';
import 'package:a195_flutter_fundamental_project/data/model/restaurant_model.dart';
import 'package:a195_flutter_fundamental_project/data/service/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiService Tests', () {
    late ApiService apiService;

    setUpAll(() => apiService = ApiService());

    test('getRestaurants returns 200 when successful', () async {
      // Arrange
      final mockApiResponse = ApiResponse(error: false);

      // Act
      final result = await apiService.getRestaurants();

      // Assert
      expect(result.error, mockApiResponse.error);
      expect(result.restaurants is List<Restaurant>, true);
    });

    test('getRestaurant returns 200 when successful', () async {
      // Arrange
      final mockApiResponse = ApiResponse(error: false);
      const mockRestaurantId = 'rqdv5juczeskfw1e867';

      // Act
      final result = await apiService.getRestaurant(mockRestaurantId);

      // Assert
      expect(result.error, mockApiResponse.error);
      expect(result.restaurant is Restaurant, true);
    });
  });
}
