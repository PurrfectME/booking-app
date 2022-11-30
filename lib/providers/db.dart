import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:booking_app/models/models.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDb();

    return _database;
  }

  // Create the database and tables
  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'booking_manager_01.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS places(id INTEGER PRIMARY KEY, name TEXT, description TEXT, logo INTEGER, gallery BLOB, updateDate INTEGER)");

      await db.execute('CREATE TABLE IF NOT EXISTS tables('
          'id INTEGER PRIMARY KEY,'
          'placeId INTEGER NOT NULL,'
          'number INTEGER NOT NULL,'
          'image INTEGER,'
          'guests INTEGER NOT NULL,'
          'FOREIGN KEY (placeId) REFERENCES places (id) ON DELETE CASCADE)');
    });
  }

  // Insert PlaceModels in database
  Future<List<Object?>> createPlaceModels(List<PlaceModel> models) async {
    final db = await database;
    final batch = db!.batch();

    for (var place in models) {
      batch.insert("places", place.toMap());

      for (var table in place.tables) {
        batch.insert("tables", table.toMap());
      }
    }

    return await batch.commit(noResult: true);
  }

  // Delete all PlaceModels
  Future<int> deleteAllPlaceModels() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM places');

    return res;
  }

  Future<List<PlaceModel>> getAllPlaceModels() async {
    final db = await database;
    final res = await db!.rawQuery(
        'SELECT tables.id as tableId, tables.number, tables.image, '
        'tables.guests, tables.placeId, places.* FROM places LEFT JOIN tables on tables.placeId = places.id');

    final places = <PlaceModel>[];

    if (res.isEmpty) {
      return [];
    }

    for (var map in res) {
      final id = map['id'] as int;
      final placeId = map['placeId'] as int;

      if (placeId == id) {
        var index = places.indexWhere((x) => x.id == placeId);
        if (index != -1) {
          places[index].tables.add(TableModel(
              map['tableId'] as int,
              map['number'] as int,
              map['image'] as int,
              map['guests'] as int,
              placeId));
        } else {
          final placeToAdd = PlaceModel.fromMap(map);
          placeToAdd.tables.add(TableModel(
              map['tableId'] as int,
              map['number'] as int,
              map['image'] as int,
              map['guests'] as int,
              placeId));

          places.add(placeToAdd);
        }
      }
    }

    return places;
  }

  Future<int> getLastUpdateDate() async {
    final db = await database;
    final result = await db!.rawQuery('SELECT updateDate FROM places '
        'WHERE [updateDate] = (SELECT MAX([updateDate]) FROM places) LIMIT 1');

    return result.isNotEmpty ? result.first.values.first as int : 0;
  }
}
