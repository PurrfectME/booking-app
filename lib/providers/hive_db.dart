import 'package:booking_app/models/models.dart';
import 'package:dartx/dartx.dart';
import 'package:hive_flutter/adapters.dart';

class HiveProvider {
  static BoxCollection? _collection;

  HiveProvider();

  Future<BoxCollection> get collection async => _collection ??= await initDb();

  Future<BoxCollection> initDb() async => await BoxCollection.open('UReserveDB',
      {'places, tables, reservations, users, tableImages, userReservations'});

  static Future initHive() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter<PlaceModel>(PlaceModelAdapter())
      ..registerAdapter<TableModel>(TableModelAdapter())
      ..registerAdapter<ReservationModel>(ReservationModelAdapter())
      ..registerAdapter<UserModel>(UserModelAdapter());
  }

  static Future<int> createUser(UserModel model) async {
    final usersBox = await Hive.openBox<UserModel>('users');

    return await usersBox.add(model);
  }

  static Future createPlaces(List<PlaceModel> models) async {
    final placesBox = await Hive.openBox<PlaceModel>('places');

    await placesBox.addAll(models);

    for (final place in models) {
      await (await Hive.openBox<TableModel>('tables')).addAll(place.tables);
    }
  }

  static Future<List<PlaceModel>> getPlaces() async {
    final a = (await Hive.openBox<PlaceModel>('places')).values.toList();
    return a;
  }

  static Future<PlaceModel?> getPlaceById(int id) async {
    final placesBox = await Hive.openBox<PlaceModel>('places');

    return placesBox.get(id);
  }

  static Future<List<ReservationModel>> getReservations(int placeId) async {
    final reservationsBox =
        await Hive.openBox<ReservationModel>('reservations');

    if (reservationsBox.isEmpty) return [];

    return reservationsBox.values.toList();
  }

  static Future deleteAllPlaces() async {
    await (await Hive.openBox<PlaceModel>('places')).clear();
  }

  static Future deleteAllTables() async {
    await (await Hive.openBox<TableModel>('tables')).clear();
  }

  static Future<List<UserModel>> getUsers() async {
    final users = (await Hive.openBox<UserModel>('users')).values.toList();
    return users;
  }

  static Future<UserModel> getUserById(int id) async =>
      (await Hive.openBox<UserModel>('users'))
          .values
          .firstWhere((x) => x.id == id);

  static Future<UserModel?> getUserByPhoneNumber(String number) async {
    final user = (await Hive.openBox<UserModel>('users'))
        .values
        .firstOrNullWhere((user) => user.login == number);

    return user;
  }

  static Future<int> createReservation(ReservationModel model) async =>
      await (await Hive.openBox<ReservationModel>('reservations')).add(model);

  static Future<List<TableModel>> getTables(int placeId) async =>
      (await Hive.openBox<TableModel>('tables'))
          .values
          .where((table) => table.placeId == placeId)
          .toList();
}
