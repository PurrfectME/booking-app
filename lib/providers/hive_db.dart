import 'package:booking_app/models/db/ingredient.dart';
import 'package:booking_app/models/local/create_dish.dart';
import 'package:booking_app/models/models.dart';
import 'package:dartx/dartx.dart';
import 'package:hive_flutter/adapters.dart';

import '../screens/reservations/reservations_screen.dart';
import '../utils/status_helper.dart';

class HiveProvider {
  HiveProvider();

  static Future initHive() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter<PlaceModel>(PlaceModelAdapter())
      ..registerAdapter<TableModel>(TableModelAdapter())
      ..registerAdapter<ReservationModel>(ReservationModelAdapter())
      ..registerAdapter<UserModel>(UserModelAdapter())
      ..registerAdapter<TablePosition>(TablePositionAdapter())
      ..registerAdapter<Dish>(DishAdapter())
      ..registerAdapter<Tag>(TagAdapter())
      ..registerAdapter<Product>(ProductAdapter());
  }

  static Future<UserModel> createUser(UserModel model) async {
    final usersBox = await Hive.openBox<UserModel>('users');
    final user = model.copyWith();

    final id = await usersBox.add(user);
    user.id = id;

    await user.save();

    return user;
  }

  static Future createPlaces(List<PlaceModel> models) async {
    final placesBox = await Hive.openBox<PlaceModel>('places');

    await placesBox.addAll(models);

    for (final place in models) {
      await (await Hive.openBox<TableModel>('tables')).addAll(place.tables);
    }
  }

  static Future<PlaceModel> createPlace(PlaceModel model) async {
    final placesBox = await Hive.openBox<PlaceModel>('places');
    final place = model.copyWith();

    final id = await placesBox.add(place);
    place.id = id;

    await place.save();

    return place;
  }

  static Future<List<PlaceModel>> getPlaces() async {
    final a = (await Hive.openBox<PlaceModel>('places')).values.toList();
    return a;
  }

  static Future<PlaceModel?> getPlaceById(int id) async {
    final placesBox = (await Hive.openBox<PlaceModel>('places'))
        .values
        .firstWhere((x) => x.id == id);

    return placesBox;
  }

  static Future<List<PlaceModel>> getPlacesByOwnerId(int ownerId) async {
    final places = (await Hive.openBox<PlaceModel>('places'))
        .values
        .where((x) => x.ownerId == ownerId)
        .toList();

    if (places.isEmpty) {
      return [];
    }

    return places;
  }

  static Future<List<ReservationModel>> getReservations(int placeId) async {
    final reservationsBox =
        await Hive.openBox<ReservationModel>('reservations');

    if (reservationsBox.isEmpty) return [];

    return reservationsBox.values.toList();
  }

  static Future<List<ReservationModel>> getTableReservations(
          int placeId, int tableId) async =>
      (await Hive.openBox<ReservationModel>('reservations'))
          .values
          .where((x) => x.placeId == placeId && x.tableId == tableId)
          .toList();

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

  static Future<UserModel?> getUserByEmail(String email) async {
    final user = (await Hive.openBox<UserModel>('users'))
        .values
        .firstOrNullWhere((user) => user.email == email);

    return user;
  }

  static Future<int> createReservation(ReservationModel model) async {
    //TODO: fix this cringe
    final box = await Hive.openBox<ReservationModel>('reservations');
    final id = await box.add(model);

    await model.delete();

    final a = model.copyWith(id: id);

    await box.add(a);

    return id;
  }

  static Future<List<TableModel>> getTables(int placeId) async =>
      (await Hive.openBox<TableModel>('tables'))
          .values
          .where((table) => table.placeId == placeId)
          .toList();

  static Future<TableModel> getTableById(int placeId, int tableId) async =>
      (await Hive.openBox<TableModel>('tables'))
          .values
          .firstWhere((x) => x.placeId == placeId && x.id == tableId);

  static Future<List<ReservationModel>> getReservationsByTime(
    int placeId,
    int start,
    int end,
    int status,
  ) async {
    final reservations = (await Hive.openBox<ReservationModel>('reservations'))
        .values
        .where(
          (x) =>
              x.placeId == placeId &&
              ((x.start >= start && x.start <= end) ||
                  //это условие для заявок, созданных по факту
                  (x.start <= start && x.start <= end)) &&
              x.status == status,
        )
        .toList();

    return reservations;
  }

  static Future<bool> updateReservation(
      int placeId, int id, Map<String, Object?> map) async {
    final toUpdate = (await Hive.openBox<ReservationModel>('reservations'))
        .values
        .firstWhere((x) => x.placeId == placeId && x.id == id);

//TODO: fix this cringe
    if (map['phoneNumber'] != null) {
      toUpdate.phoneNumber = map['phoneNumber'] as String;
    }
    if (map['name'] != null) {
      toUpdate.name = map['name'] as String;
    }
    if (map['guests'] != null) {
      toUpdate.guests = map['guests'] as int;
    }
    if (map['start'] != null) {
      toUpdate.start = map['start'] as int;
    }
    if (map['end'] != null) {
      toUpdate.end = map['end'] as int;
    }
    if (map['excludeReshuffle'] != null) {
      toUpdate.excludeReshuffle = map['excludeReshuffle'] as bool;
    }
    if (map['comment'] != null) {
      toUpdate.comment = map['comment'] as String;
    }
    if (map['status'] != null) {
      toUpdate.status = map['status'] as int;
    }

    await toUpdate.save();

    return true;
  }

  static Future<ReservationModel> getReservationsById(
      int placeId, int id) async {
    final reservBox = await Hive.openBox<ReservationModel>('reservations');

    return reservBox.values
        .firstWhere((x) => x.placeId == placeId && x.id == id);
  }

  static Future<bool> openReservation(int placeId, int id, int? start) async {
    final reservBox = await Hive.openBox<ReservationModel>('reservations');

    final toUpdate =
        reservBox.values.firstWhere((x) => x.placeId == placeId && x.id == id);

    toUpdate.status = StatusHelper.fromStatus(ReservationStatus.opened);

    if (start != null) {
      toUpdate.start = start;
    }

    await toUpdate.save();

    return true;
  }

  static Future<bool> cancelReservation(int placeId, int id) async {
    final reservBox = await Hive.openBox<ReservationModel>('reservations');

    final toUpdate =
        reservBox.values.firstWhere((x) => x.placeId == placeId && x.id == id);

    toUpdate.status = StatusHelper.fromStatus(ReservationStatus.cancelled);

    await toUpdate.save();

    return true;
  }

  static Future<List<ReservationModel>> getArchivedReservations(
    int placeId,
    int currentTime,
    int? status,
  ) async {
    final reservBox = await Hive.openBox<ReservationModel>('reservations');

    if (status != null) {
      return reservBox.values
          .where((x) => x.placeId == placeId && x.status == status)
          .toList();
    } else {
      return reservBox.values
          .where((x) => x.placeId == placeId && x.end <= currentTime)
          .toList();
    }
  }

  static Future changeBookingType(int placeId) async {
    final placesBox = await Hive.openBox<PlaceModel>('places');

    final place = placesBox.values.firstWhere((x) => x.id == placeId);
    place.allowBooking = !place.allowBooking;
    await place.save();
  }

  static Future createTable(TableModel model) async {
    final tablesBox = await Hive.openBox<TableModel>('tables');
    final table = model.copyWith();

    final id = await tablesBox.add(table);
    table.id = id;

    await table.save();
  }

  static Future<List<TablePosition>> getTablePositions(int placeId) async {
    final positions = await Hive.openBox<TablePosition>('tablesPositions');

    return positions.values.where((x) => x.placeId == placeId).toList();
  }

  static Future removeTablesSchemeByPlaceId(int placeId) async {
    final box = await Hive.openBox<TablePosition>('tablesPositions');

    final schemeToDelete =
        box.values.where((x) => x.placeId == placeId).map((e) => e.id).toList();

    await box.deleteAll(schemeToDelete);
  }

  static Future addTablesScheme(List<TablePosition> positions) async {
    final box = await Hive.openBox<TablePosition>('tablesPositions');

    positions.map((x) async {
      final id = await box.add(x);
      x.id = id;

      await x.save();
    }).toList();
  }

  // static Future<List<CategoryModel>> getCategories(int placeId) async {
  //   final box = await Hive.openBox<CategoryModel>('categories');

  //   return box.values.where((x) => x.placeId == placeId).toList();
  // }

  // static Future createCategory(CategoryModel model) async {
  //   final box = await Hive.openBox<CategoryModel>('categories');

  //   final category = model.copyWith();

  //   final id = await box.add(category);
  //   category.id = id;

  //   await category.save();
  // }

  static Future<List<Ingredient>> getIngredients() async =>
      (await Hive.openBox<Ingredient>('ingredients')).values.toList();

  static Future<List<Product>> getProducts() async =>
      (await Hive.openBox<Product>('products')).values.toList();

  static Future createProduct(Product data) async {
    final box = await Hive.openBox<Product>('products');

    final id = await box.add(data);
  }

  static Future createIngredient(Ingredient data) async {
    final box = await Hive.openBox<Ingredient>('ingredients');

    final id = await box.add(data);
    data.id = id;

    return await data.save();
  }

  static Future<List<Dish>> getDishes() async =>
      (await Hive.openBox<Dish>('dish')).values.toList();

  static Future createDish(CreateDishModel model) async {
    final box = await Hive.openBox<Dish>('dish');

    final dish = Dish(
        id: -1,
        name: model.name,
        price: model.price,
        ingredients: null,
        tags: null,
        description: model.description,
        mediaId: model.mediaId);

    final id = await box.add(dish);

    dish
      ..tags = HiveList(box)
      ..ingredients = HiveList(box);

    final tags = await Hive.openBox<Tag>('tags');

    model.tags.map((e) async {
      final tag = Tag(id: 0, name: e);
      final tagId = await tags.add(tag);
      tag.id = tagId;
      await tag.save();

      dish.tags!.add(tag);
    });

    dish.id = id;

    return await dish.save();
  }
}
