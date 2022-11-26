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

  // Create the database and the PlaceModel table
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
          'FOREIGN KEY (placeId) REFERENCES places (id))');
    });
  }

  // Insert PlaceMode on database
  Future<int> createPlaceModel(PlaceModel model) async {
    final db = await database;
    final res = await db?.insert("places", model.toMap());
    return res!;
  }

  // Delete all PlaceModels
  Future<int> deleteAllPlaceModels() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM places');

    return res;
  }

  Future<List<PlaceModel>> getAllPlaceModes() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM places");

    List<PlaceModel> list =
        res.isNotEmpty ? res.map((c) => PlaceModel.fromMap(c)).toList() : [];

    return list;
  }
}
