import 'package:booking_app/models/db/table_image_model.dart';
import 'package:booking_app/models/db/user_reservation_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/scripts/scripts.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async => _database ??= await initDb();

  // Create the database and tables
  Future<Database> initDb() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'booking_manager_01.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: (Database db, int version) async {
      await db.execute(places);
      await db.execute(tables);
      await db.execute(reservations);
      await db.execute(userReservations);
      await db.execute(tableImages);
      await db.execute(user);
    });
  }

  Future updatePlace(PlaceModel place) async {
    final db = await database;
    final result = await db.update('places', place.toMap(),
        where: 'id = ?',
        whereArgs: [place.id],
        conflictAlgorithm: ConflictAlgorithm.replace);

    // var a = await getAllPlaceModels();

    return result;
  }

  Future updateTable(TableModel table) async {
    final db = await database;

    final tableResult = await db.update('tables', table.toMap(),
        where: 'id = ?',
        whereArgs: [table.id],
        conflictAlgorithm: ConflictAlgorithm.replace);

    return tableResult;
  }

  Future<List<Object?>> updateTableImages(
      int tableId, List<Uint8List> imagesBytesList) async {
    final db = await database;
    final batch = db.batch();

    batch.delete('tableImages', where: 'tableId = ?', whereArgs: [tableId]);

    for (final imageBytes in imagesBytesList) {
      batch.insert(
          'tableImages',
          TableImageModel(id: null, tableId: tableId, imageBytes: imageBytes)
              .toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    final result = await batch.commit();

    return result;
  }

  // Insert PlaceModels in database
  Future<List<Object?>> createPlaceModels(List<PlaceModel> models) async {
    final db = await database;
    final batch = db.batch();

    for (final place in models) {
      batch.insert('places', place.toMap());

      for (final table in place.tables) {
        batch.insert('tables', table.toMap());
      }
    }

    return await batch.commit(noResult: true);
  }

  // Delete all PlaceModels
  Future<int> deleteAllPlaceModels() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM places');

    return res;
  }

  Future<int> deleteAllTables() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM tables');

    return res;
  }

  Future<List<PlaceModel>> getAllPlaceModels() async {
    final db = await database;
    final res = await db.rawQuery('SELECT tables.id as tableId, tables.number, '
        'tables.guests, tables.placeId, places.* FROM places LEFT JOIN tables on tables.placeId = places.id');

    if (res.isEmpty) {
      return [];
    }

    final places = <PlaceModel>[];

    for (final map in res) {
      final placeId = map['id'] as int;

      final index = places.indexWhere((x) => x.id == placeId);
      if (index != -1) {
        places[index].tables.add(TableModel(map['tableId'] as int,
            map['number'] as int, map['guests'] as int, map['placeId'] as int));
      } else {
        final placeToAdd = PlaceModel.fromMap(map);
        placeToAdd.tables.add(TableModel(map['tableId'] as int,
            map['number'] as int, map['guests'] as int, map['placeId'] as int));

        places.add(placeToAdd);
      }
    }

    return places;
  }

  Future<PlaceModel> getPlaceById(int id) async {
    final db = await database;
    final result =
        await db.rawQuery('SELECT tables.id as tableId, tables.number, '
            'tables.guests, tables.placeId, places.* FROM places '
            'LEFT JOIN tables on tables.placeId = $id WHERE places.id = $id');

    final place = PlaceModel.fromMap(result[0]);

    for (final map in result) {
      place.tables.add(TableModel(map['tableId'] as int, map['number'] as int,
          map['guests'] as int, map['placeId'] as int));
    }

    return place;
  }

  Future<int> getLastUpdateDate(String tableName) async {
    final db = await database;
    final result = await db.rawQuery('SELECT updateDate FROM $tableName '
        'ORDER BY updateDate DESC LIMIT 1');

    return result.isNotEmpty ? result.first.values.first as int : 0;
  }

  Future<int> getPlacesLastUpdateDate() => getLastUpdateDate('places');

  Future<int> getUserReservationsLastUpdateDate() =>
      getLastUpdateDate('user_reservations');

  Future<List<Object?>> createReservations(
      List<ReservationModel> models) async {
    final db = await database;
    final batch = db.batch();

    for (final reservation in models) {
      batch.insert('reservations', reservation.toMap());
    }

    return await batch.commit(noResult: true);
  }

  Future<List<Object?>> createUserReservations(
      List<LocalUserReservationModel> models) async {
    final db = await database;
    final batch = db.batch();

    for (final reservation in models) {
      batch.insert('user_reservations', reservation.toMap());
    }

    return await batch.commit(noResult: true);
  }

  Future<int> createUserReservation(LocalUserReservationModel model) async {
    final db = await database;
    final result = await db.insert('user_reservations', model.toMap());

    return result;
  }

  Future<int> createReservation(ReservationModel model) async {
    final db = await database;
    final result = await db.insert('reservations', model.toMap());

    return result;
  }

  Future<List<Object?>> createAllReservations(
      List<ReservationModel> reservations,
      List<LocalUserReservationModel> userReservations) async {
    final db = await database;
    final batch = db.batch();

    for (final reservation in userReservations) {
      batch.insert('user_reservations', reservation.toMap());
    }

    for (final reservation in reservations) {
      batch.insert('reservations', reservation.toMap());
    }

    return await batch.commit(noResult: true);
  }

  Future<List<UserReservationModel>> getReservations(int placeId) async {
    final db = await database;
    final res = await db.rawQuery(
        'SELECT reservations.*, user.id as user_id, user.login, user.firstSignin, user.accessToken, user.refreshToken FROM reservations '
        'LEFT JOIN user on user_id = reservations.userId WHERE reservations.placeId = $placeId');

    if (res.isEmpty) {
      return [];
    }

    final userReservationsResult = <UserReservationModel>[];

    for (final map in res) {
      if (map['user_id'] == null && map['userId'] == null) {
        userReservationsResult.add(UserReservationModel(
            user: null, reservation: ReservationModel.fromMap(map)));
      } else {
        userReservationsResult.add(UserReservationModel(
            user: UserModel.fromMap(map),
            reservation: ReservationModel.fromMap(map)));
      }
    }

    return userReservationsResult;
  }

  Future<List<ReservationModel>> getReservationsByTime(
      int placeId, int start, int end, int isOpened) async {
    final db = await database;
    final res = await db.query('reservations',
        where: 'placeId = ? AND start BETWEEN ? AND ? AND isOpened = ?',
        whereArgs: [placeId, start, end, isOpened]);

    if (res.isEmpty) {
      return [];
    }

    final reservationsResult = <ReservationModel>[];

    for (final map in res) {
      reservationsResult.add(ReservationModel.fromMap(map));
    }

    return reservationsResult;
  }

  Future<ReservationModel> getReservationsById(int placeId, int id) async {
    final db = await database;
    final res = await db.query('reservations',
        where: 'placeId = ? AND id = ?', whereArgs: [placeId, id]);

    // if (res.isEmpty) {
    //   return null;
    // }

    return ReservationModel.fromMap(res.first);
  }

  Future<bool> openReservation(int placeId, int id) async {
    final db = await database;
    final res = await db.update(
      'reservations',
      {'isOpened': 1},
      where: 'placeId = ? AND id = ?',
      whereArgs: [placeId, id],
    );

    if (res == 0) {
      return false;
    }

    return true;
  }

  Future<TableModel?> getTableById(int placeId, int tableId) async {
    final db = await database;
    final res = await db.query('tables',
        where: 'placeId = ? AND id = ?', whereArgs: [placeId, tableId]);

    if (res.isEmpty) {
      return null;
    }

    return TableModel.fromMap(res.first);
  }

  Future<List<ReservationModel>> getTableReservations(
      int placeId, int tableId) async {
    final db = await database;
    final res = await db.rawQuery(
        'SELECT * from reservations WHERE reservations.placeId = $placeId AND reservations.tableId = $tableId');

    if (res.isEmpty) {
      return [];
    }

    final reservationsResult = <ReservationModel>[];

    for (final map in res) {
      reservationsResult.add(ReservationModel.fromMap(map));
    }

    return reservationsResult;
  }

  Future<int> updateReservation(ReservationModel model) async {
    final db = await database;
    final result = await db.update('reservations', model.toMap(),
        where: 'id = ?',
        whereArgs: [model.id],
        conflictAlgorithm: ConflictAlgorithm.replace);

    return result;
  }

  Future<List<LocalUserReservationModel>> getAllUserReservations() async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM user_reservations');

    if (res.isEmpty) {
      return [];
    }

    final reservations = <LocalUserReservationModel>[];

    for (final reservation in res) {
      reservations.add(LocalUserReservationModel.fromMap(reservation));
    }

    return reservations;
  }

  Future<List<TableImageModel>> getTableImages(List<int> tableIds) async {
    final db = await database;
    final result = await db.query(
      'tableImages',
      where: "tableId IN (${tableIds.map((_) => '?').join(', ')})",
      whereArgs: tableIds,
    );

    if (result.isEmpty) {
      return [];
    }

    final tableImageModels = <TableImageModel>[];

    for (final tableImage in result) {
      tableImageModels.add(TableImageModel.fromMap(tableImage));
    }

    return tableImageModels;
  }

  Future<List<TableModel>> getTables(int placeId) async {
    final db = await database;

    final result = await db
        .rawQuery('SELECT * FROM tables WHERE tables.placeId = $placeId');

    if (result.isEmpty) {
      return [];
    }

    final tables = <TableModel>[];

    for (final table in result) {
      tables.add(TableModel.fromMap(table));
    }

    return tables;
  }

  Future<List<TableModel>> getTablesByPlaceId(int placeId) async {
    final db = await database;
    final res =
        await db.rawQuery('SELECT * FROM tables WHERE placeId = $placeId');

    if (res.isEmpty) {
      return [];
    }

    final tables = <TableModel>[];

    for (final table in res) {
      tables.add(TableModel.fromMap(table));
    }

    return tables;
  }

  Future<int> deleteReservation(int reservationId, int placeId) async {
    final db = await database;
    final res = await db.delete('reservations',
        where: 'id = ? AND placeId = ?', whereArgs: [reservationId, placeId]);

    return res;
  }

  Future<int> createUser(UserModel user) async {
    final db = await database;
    final result = await db.insert('user', user.toMap());

    return result;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    final result = await db.update('user', user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);

    return result;
  }

//TODO: учесть ситуацию, когда есть несколько аккаунтов на одном телефоне
  Future<UserModel> getCurrentUser() async {
    final db = await database;
    final a = await db.query('user');
    final result = UserModel.fromMap(a.last);

    return result;
  }

  Future<UserModel?> getUserById(int id) async {
    final db = await database;
    final result = await db.query('user', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) {
      return null;
    }

    final user = UserModel.fromMap(result.first);

    return user;
  }

  Future<int> deleteAllUsers() async {
    final db = await database;
    final result = await db.delete('user');

    return result;
  }

  Future<UserModel?> getByPhoneNumber(String phone) async {
    final db = await database;
    final result =
        await db.query('user', where: 'login = ?', whereArgs: [phone]);

    if (result.isEmpty) {
      return null;
    }

    return UserModel.fromMap(result.first);
  }
}
