// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/dish_model.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

import '../../models/local/create_dish.dart';

part 'dish_event.dart';
part 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  DishBloc() : super(DishLoading()) {
    on<DishEvent>((event, emit) async {
      if (event is DishLoad) {
        final dishData = await _getDishes();

        final products = await HiveProvider.getProducts();
        final productsList = products
            .map((x) =>
                ProductModel(name: x.name, amount: x.amount, type: x.type))
            .toList();

        emit(DishLoaded(
          dishes: dishData.dishes,
          products: productsList,
          tags: dishData.tags,
        ));
      } else if (event is CreateDish) {
        await HiveProvider.createDish(event.model);

        final dishData = await _getDishes();

        final products = await HiveProvider.getProducts();
        final productsList = products
            .map((x) =>
                ProductModel(name: x.name, amount: x.amount, type: x.type))
            .toList();

        emit(DishLoaded(
          dishes: dishData.dishes,
          products: productsList,
          tags: dishData.tags,
        ));
      } else if (event is FilterByTags) {
        emit(DishLoading());
        List<DishModel> filteredDishes;
        if (event.tags.isNotEmpty) {
          filteredDishes = (await HiveProvider.filterByTags(event.tags))
              .map((e) => DishModel(
                  id: e.id,
                  name: e.name,
                  price: e.price,
                  ingredients: e.ingredients
                      .map((e) => IngredientModel(
                          name: e.name, amount: e.amount.toString()))
                      .toList(),
                  tags: e.tags,
                  description: e.description,
                  mediaId: e.mediaId))
              .toList();
        } else {
          final dishData = await _getDishes();

          filteredDishes = dishData.dishes;
        }

        final products = await HiveProvider.getProducts();
        final productsList = products
            .map((x) =>
                ProductModel(name: x.name, amount: x.amount, type: x.type))
            .toList();

        emit(DishLoaded(
            dishes: filteredDishes,
            tags: event.allTags,
            products: productsList));
      } else {
        emit(DishLoading());
      }
    });
  }

  Future<DishData> _getDishes() async {
    final dishes = await HiveProvider.getDishes();
    final tags = <String>[];

    final dishesList = dishes.map((x) {
      final ingredients = x.ingredients
          .map(
              (e) => IngredientModel(name: e.name, amount: e.amount.toString()))
          .toList();

      tags.addAll(x.tags.map((e) => e.name));

      return DishModel(
          id: x.id,
          name: x.name,
          price: x.price,
          ingredients: ingredients,
          tags: x.tags,
          description: x.description,
          mediaId: x.mediaId);
    }).toList();

    return DishData(dishes: dishesList, tags: tags.toSet().toList());
  }
}

class DishData {
  final List<DishModel> dishes;
  final List<String> tags;
  DishData({
    required this.dishes,
    required this.tags,
  });
}
