import 'dart:io';

import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/models/db/user_reservation_model.dart';
import 'package:booking_app/scripts/scripts.dart';
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
      await db.execute(places);
      await db.execute(tables);
      await db.execute(reservations);
      await db.execute(userReservations);
    });
  }

  // Insert PlaceModels in database
  Future<List<Object?>> createPlaceModels(List<PlaceModel> models) async {
    final db = await database;
    final batch = db!.batch();

    for (var place in models) {
      batch.insert("places", place.toMap());

      for (var table in place.tables) {
        batch.insert("tables", table!.toMap());
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

    if (res.isEmpty) {
      return [];
    }

    final places = <PlaceModel>[];

    for (var map in res) {
      final placeId = map['id'] as int;

      var index = places.indexWhere((x) => x.id == placeId);
      if (index != -1) {
        places[index].tables.add(TableModel(
            map['tableId'] as int,
            map['number'] as int,
            map['image'] as int,
            map['guests'] as int,
            map['placeId'] as int));
      } else {
        final placeToAdd = PlaceModel.fromMap(map);
        placeToAdd.tables.add(TableModel(
            map['tableId'] as int,
            map['number'] as int,
            map['image'] as int,
            map['guests'] as int,
            map['placeId'] as int));

        places.add(placeToAdd);
      }
    }

    return places;
  }

  Future<int> getLastUpdateDate(String tableName) async {
    final db = await database;
    final result = await db!.rawQuery('SELECT updateDate FROM $tableName '
        'ORDER BY updateDate DESC LIMIT 1');

    return result.isNotEmpty ? result.first.values.first as int : 0;
  }

  Future<int> getPlacesLastUpdateDate() => getLastUpdateDate("places");

  Future<int> getUserReservationsLastUpdateDate() =>
      getLastUpdateDate("user_reservations");

  Future<List<Object?>> createReservations(
      List<ReservationModel> models) async {
    final db = await database;
    final batch = db!.batch();

    for (var reservation in models) {
      batch.insert("reservations", reservation.toMap());
    }

    return await batch.commit(noResult: true);
  }

  Future<List<Object?>> createUserReservations(
      List<UserReservationModel> models) async {
    final db = await database;
    final batch = db!.batch();

    for (var reservation in models) {
      batch.insert("user_reservations", reservation.toMap());
    }

    return await batch.commit(noResult: true);
  }

  Future<List<Object?>> createAllReservations(
      List<ReservationModel> reservations,
      List<UserReservationModel> userReservations) async {
    final db = await database;
    final batch = db!.batch();

    for (var reservation in userReservations) {
      batch.insert("user_reservations", reservation.toMap());
    }

    for (var reservation in reservations) {
      batch.insert("reservations", reservation.toMap());
    }

    return await batch.commit(noResult: true);
  }

  Future<List<ReservationModel>> getReservations() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM reservations");

    if (res.isEmpty) {
      return [];
    }

    final reservations = <ReservationModel>[];

    for (var reservation in res) {
      reservations.add(ReservationModel.fromMap(reservation));
    }

    return reservations;
  }

  Future<List<UserReservationModel>> getAllUserReservations() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM user_reservations");

    if (res.isEmpty) {
      return [];
    }

    final reservations = <UserReservationModel>[];

    for (var reservation in res) {
      reservations.add(UserReservationModel.fromMap(reservation));
    }

    return reservations;
  }
}
