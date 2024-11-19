import 'package:a195_flutter_fundamental_project/data/model/api_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Api Response Model Tests', () {
    test('Api Response parses JSON correctly with restaurant list', () {
      // Arrange
      final mockJson = {
        'error': false,
        'message': 'success',
        'count': 2,
        'restaurants': [
          {
            'id': '1',
            'name': 'Restaurant 1',
            'description': 'Description 1',
            'pictureId': '1',
            'city': 'City 1',
            'rating': 4.1
          },
          {
            'id': '2',
            'name': 'Restaurant 2',
            'description': 'Description 2',
            'pictureId': '2',
            'city': 'City 2',
            'rating': 4.2
          }
        ]
      };

      // Act
      final apiResponse = ApiResponse.fromJson(mockJson);

      // Assert
      expect(apiResponse.error, false);
      expect(apiResponse.message, 'success');
      expect(apiResponse.count, 2);
      expect(apiResponse.restaurants, isNotNull);
      expect(apiResponse.restaurants!.length, 2);
      expect(apiResponse.restaurants![0].name, 'Restaurant 1');
      expect(apiResponse.restaurants![1].name, 'Restaurant 2');
    });

    test('Api Response parses JSON correctly with single restaurant', () {
      // Arrange
      final mockJson = {
        'error': false,
        'message': 'success',
        'restaurant': {
          'id': '1',
          'name': 'Restaurant 1',
          'description': 'Description 1',
          'pictureId': '1',
          'city': 'City 1',
          'rating': 4.1
        },
      };

      // Act
      final apiResponse = ApiResponse.fromJson(mockJson);

      // Assert
      expect(apiResponse.error, false);
      expect(apiResponse.message, 'success');
      expect(apiResponse.restaurant, isNotNull);
      expect(apiResponse.restaurant!.name, 'Restaurant 1');
    });

    test('Api Response handles empty JSON correctly', () {
      // Arrange
      final mockJson = <String, dynamic>{};

      // Act
      final apiResponse = ApiResponse.fromJson(mockJson);

      // Assert
      expect(apiResponse.error, isNull);
      expect(apiResponse.message, isNull);
      expect(apiResponse.restaurants, isNull);
      expect(apiResponse.restaurant, isNull);
    });
  });
}
