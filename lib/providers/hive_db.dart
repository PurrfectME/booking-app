import 'package:booking_app/models/db/ingredient.dart';
import 'package:booking_app/models/db/order.dart';
import 'package:booking_app/models/db/order_item.dart';
import 'package:booking_app/models/db/role.dart';
import 'package:booking_app/models/db/user.dart';
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
      ..registerAdapter<Product>(ProductAdapter())
      ..registerAdapter<Ingredient>(IngredientAdapter())
      ..registerAdapter<Kitchen>(KitchenAdapter())
      ..registerAdapter<Order>(OrderAdapter())
      ..registerAdapter<OrderItem>(OrderItemAdapter())
      ..registerAdapter<User>(UserAdapter())
      ..registerAdapter<Role>(RoleAdapter());
  }

  static Future<UserModel> createUserModel(UserModel model) async {
    final usersBox = await Hive.openBox<UserModel>('usersModel');
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

  static Future<List<ReservationModel>> getReservations() async {
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

  static Future<List<UserModel>> getUserModels() async {
    final users = (await Hive.openBox<UserModel>('usersModel')).values.toList();
    return users;
  }

  static Future<UserModel> getUserById(int id) async =>
      (await Hive.openBox<UserModel>('usersModel'))
          .values
          .firstWhere((x) => x.id == id);

  static Future<UserModel?> getUserByEmail(String email) async {
    final user = (await Hive.openBox<UserModel>('usersModel'))
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

  static Future<List<TableModel>> getTables() async =>
      (await Hive.openBox<TableModel>('tables')).values.toList();

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

  static Future<List<TablePosition>> getTablePositions() async {
    final positions = await Hive.openBox<TablePosition>('tablesPositions');

    return positions.values.toList();
  }

  static Future removeTablesScheme() async {
    final box = await Hive.openBox<TablePosition>('tablesPositions');

    await box.clear();
  }

  static Future addTablesScheme(List<TablePosition> positions) async {
    final box = await Hive.openBox<TablePosition>('tablesPositions');

    positions.map((x) async {
      final id = await box.add(x);
      x.id = id;

      await x.save();
    }).toList();
  }

  static Future<List<Ingredient>> getIngredients() async =>
      (await Hive.openBox<Ingredient>('ingredients')).values.toList();

  static Future<List<Product>> getProducts() async =>
      (await Hive.openBox<Product>('products')).values.toList();

  static Future createProduct(Product data) async {
    final box = await Hive.openBox<Product>('products');

    await box.add(data);
  }

  static Future createIngredient(Ingredient data) async {
    final box = await Hive.openBox<Ingredient>('ingredients');

    await box.add(data);
  }

  static Future<List<Dish>> getDishes() async {
    final a = (await Hive.openBox<Dish>('dish')).values.toList();
    return a;
  }

  static Future<List<Dish>> getDishesByIds(List<int> ids) async {
    final a = (await Hive.openBox<Dish>('dish'))
        .values
        .where((x) => ids.contains(x.id))
        .toList();
    return a;
  }

  static Future createDish(CreateDishModel model) async {
    final box = await Hive.openBox<Dish>('dish');

    final dish = Dish(
        id: -1,
        name: model.name,
        price: model.price,
        ingredients: [],
        tags: [],
        description: model.description,
        mediaId: model.mediaId);

    final id = await box.add(dish);

    final tags = await Hive.openBox<Tag>('tags');

    for (final e in model.tags) {
      final tag = Tag(id: 0, name: e);
      final tagId = await tags.add(tag);
      tag.id = tagId;
      await tag.save();

      dish.tags.add(tag);
    }

    for (final e in model.ingredients) {
      final ingredient = Ingredient(name: e.name, amount: e.amount);
      await createIngredient(ingredient);

      dish.ingredients.add(Product(
          name: ingredient.name,
          amount: double.parse(ingredient.amount),
          type: "type"));
    }

    dish.id = id;

    await dish.save();
  }

  static Future<List<Dish>> filterByTags(List<String> tags) async {
    final result = (await Hive.openBox<Dish>('dish'))
        .values
        .where((x) => tags.containsAny(x.tags.map((e) => e.name).toList()))
        .toList();
    return result;
  }

  static Future<List<Kitchen>> getKitchenData() async =>
      (await Hive.openBox<Kitchen>('kitchen')).values.toList();

  static Future createKitchenItem(Kitchen data) async {
    final box = await Hive.openBox<Kitchen>('kitchen');

    final id = await box.add(data);

    data.id = id;

    await data.save();
  }

  static Future<int> createOrder(Order order) async {
    final box = await Hive.openBox<Order>('orders');

    final id = await box.add(order);
    order.id = id;

    await order.save();

    return id;
  }

  static Future<List<Order>> getOrders() async =>
      (await Hive.openBox<Order>('orders')).values.toList();

  static Future<Order> getOrderById(int id) async {
    final box = await Hive.openBox<Order>('orders');

    final result = box.values.firstWhere((x) => x.id == id);

    return result;
  }

  static Future deleteDishById(int id) async {
    final dishToDelete =
        (await Hive.openBox<Dish>('dish')).values.firstWhere((x) => x.id == id);

    await dishToDelete.delete();
  }

  static Future<List<User>> getUsers() async =>
      (await Hive.openBox<User>('users')).values.toList();

  static Future createUser(User user) async {
    final box = await Hive.openBox<User>('users');

    final id = await box.add(user);
    user.id = id;

    await user.save();
  }

  static Future<List<Role>> getRoles() async =>
      (await Hive.openBox<Role>('roles')).values.toList();

  static Future createRole(String role) async {
    final box = await Hive.openBox<Role>('roles');
    final r = Role(id: -1, name: role);
    final id = await box.add(r);
    r.id = id;

    await r.save();
  }
}
