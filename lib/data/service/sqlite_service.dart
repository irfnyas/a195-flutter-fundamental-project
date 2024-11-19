import 'package:sqflite/sqflite.dart';

import '../model/restaurant_model.dart';

class SqliteService {
  SqliteService._();

  static const kDb = 'restaurant.db';
  static const kWishlistTable = 'wishlist';
  static const version = 1;

  static Future<Database> initializeDb() async {
    return openDatabase(
      kDb,
      version: version,
      onCreate: (Database db, int ver) async {
        await createTables(db);
      },
    );
  }

  static Future<void> createTables(Database db) async {
    await db.execute(
      """CREATE TABLE $kWishlistTable(
       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       name TEXT,
       restaurantId TEXT,
       pictureId TEXT,
       city TEXT,
       rating REAL
     )
     """,
    );
  }

  static Future<List<Restaurant>> getAllItems() async {
    final db = await initializeDb();
    final results = await db.query(kWishlistTable, orderBy: 'id');

    return results.map((result) => Restaurant.fromJson(result)).toList();
  }

  static Future<Restaurant?> getItemById(String id) async {
    final db = await initializeDb();
    final results = await db.query(
      kWishlistTable,
      where: 'restaurantId = ?',
      whereArgs: [id],
      limit: 1,
    );

    return results.map((result) => Restaurant.fromJson(result)).firstOrNull;
  }

  static Future<int> insertItem(Restaurant restaurant) async {
    final db = await initializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      kWishlistTable,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> removeItem(String id) async {
    final db = await initializeDb();

    final result = await db.delete(
      kWishlistTable,
      where: 'restaurantId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
