import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/dish_model.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

import '../../models/db/ingredient.dart';
import '../../models/local/create_dish.dart';

part 'dish_event.dart';
part 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  DishBloc() : super(DishLoading()) {
    on<DishEvent>((event, emit) async {
      if (event is DishLoad) {
        final dishesList = await _getDishes();

        final products = await HiveProvider.getProducts();
        final productsList = products
            .map((x) =>
                ProductModel(name: x.name, amount: x.amount, type: x.type))
            .toList();

        emit(DishLoaded(dishes: dishesList, products: productsList));
      } else if (event is CreateDish) {
        await HiveProvider.createDish(event.model);

        final dishesList = await _getDishes();

        final products = await HiveProvider.getProducts();
        final productsList = products
            .map((x) =>
                ProductModel(name: x.name, amount: x.amount, type: x.type))
            .toList();

        emit(DishLoaded(dishes: dishesList, products: productsList));
      } else {
        emit(DishLoading());
      }
    });
  }

  Future<List<DishModel>> _getDishes() async {
    final dishes = await HiveProvider.getDishes();

    final dishesList = dishes.map((x) {
      final ingredients = x.ingredients?.cast<Ingredient>();
      final tags = x.tags?.cast<Tag>();

      return DishModel(
          id: x.id,
          name: x.name,
          price: x.price,
          ingredients: ingredients,
          tags: tags,
          description: x.description,
          mediaId: x.mediaId);
    }).toList();

    return dishesList;
  }
}
