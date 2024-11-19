import 'package:a195_flutter_fundamental_project/data/model/restaurant_model.dart';
import 'package:a195_flutter_fundamental_project/data/service/sqlite_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;

  final restaurantTest = Restaurant(
    id: '1',
    name: 'Restaurant 1',
    pictureId: '1',
    city: 'City 1',
    rating: 4.1,
  );

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    database = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await SqliteService.createTables(database);
  });

  tearDownAll(() async {
    await database.close();
  });

  group('SqliteService Tests', () {
    test('insertItem inserts a restaurant into the database', () async {
      // Arrange
      final restaurant = restaurantTest;

      // Act
      final result = await SqliteService.insertItem(restaurant);

      // Assert
      expect(result, isNonZero);
    });

    test('getAllItems retrieves all restaurants from the database', () async {
      // Arrange
      await SqliteService.insertItem(restaurantTest);

      // Act
      final results = await SqliteService.getAllItems();

      // Assert
      expect(results.length, greaterThanOrEqualTo(1));
    });

    test('getItemById retrieves a specific restaurant by Id', () async {
      // Arrange
      await SqliteService.insertItem(restaurantTest);

      // Act
      final result = await SqliteService.getItemById('1');

      // Assert
      expect(result?.name, 'Restaurant 1');
    });

    test('removeItem deletes a restaurant from the database', () async {
      // Arrange
      await SqliteService.removeItem('1');
      await SqliteService.insertItem(restaurantTest);

      // Act
      final deleteResult = await SqliteService.removeItem('1');
      final result = await SqliteService.getItemById('1');

      // Assert
      expect(deleteResult, 1);
      expect(result, isNull);
    });
  });
}
