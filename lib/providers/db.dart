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
    final path = join(documentsDirectory.path, 'booking_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE IF NOT EXISTS Tables('
          'id INTEGER PRIMARY KEY,'
          'placeId INTEGER NOT NULL,'
          'number INTEGER NOT NULL,'
          'image INTEGER,'
          'guests INTEGER NOT NULL,'
          'FOREIGN KEY (placeId) REFERENCES Places (id)'
          ');'
          //
          'CREATE TABLE IF NOT EXISTS Places('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'description TEXT,'
          'logo INTEGER,'
          'gallery TEXT,'
          'updateDate TEXT,'
          // 'tables TEXT,'
          ');');
    });
  }

  // Insert PlaceMode on database
  Future<int> createPlaceModel(PlaceModel model) async {
    final db = await database;
    final res = await db!.insert('Places', model.toMap());

    return res;
  }

  // Delete all PlaceModels
  Future<int> deleteAllPlaceModels() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM Places');

    return res;
  }

  Future<List<PlaceModel>> getAllPlaceModes() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM Places");

    List<PlaceModel> list =
        res.isNotEmpty ? res.map((c) => PlaceModel.fromMap(c)).toList() : [];

    return list;
  }
}
