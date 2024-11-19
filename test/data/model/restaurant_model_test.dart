import 'package:a195_flutter_fundamental_project/data/model/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Restaurant Model Tests', () {
    test('Restaurant parses JSON correctly', () {
      // Arrange
      final mockJson = {
        'id': '1',
        'name': 'Restaurant 1',
        'description': 'Description 1',
        'pictureId': '1',
        'city': 'City 1',
        'rating': 4.1
      };

      // Act
      final restaurant = Restaurant.fromJson(mockJson);

      // Assert
      expect(restaurant.name, 'Restaurant 1');
    });

    test('Restaurant converts to JSON correctly', () {
      // Arrange
      final mockRestaurant = Restaurant(
        id: '1',
        name: 'Restaurant 1',
        pictureId: '1',
        city: 'City 1',
        rating: 4.1,
      );

      // Act
      final json = mockRestaurant.toJson();

      // Assert
      expect(json['name'], 'Restaurant 1');
    });

    test('Restaurant parses list of JSON objects correctly', () {
      // Arrange
      final mockJsonArray = [
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
      ];

      // Act
      final restaurants = Restaurant.fromArray(mockJsonArray);

      // Assert
      expect(restaurants.length, 2);
      expect(restaurants[0].name, 'Restaurant 1');
      expect(restaurants[1].name, 'Restaurant 2');
    });

    test('Restaurant handles empty JSON gracefully', () {
      // Arrange
      final mockJson = <String, dynamic>{};

      // Act
      final restaurant = Restaurant.fromJson(mockJson);

      // Assert
      expect(restaurant.name, isNull);
    });
  });
}
