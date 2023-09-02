import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/category_model.dart';
import 'package:booking_app/models/db/food_model.dart';
import 'package:booking_app/models/local/create_food.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuLoading()) {
    on<MenuEvent>((event, emit) async {
      if (event is MenuLoad) {
        emit(MenuLoading());

        final categories = await HiveProvider.getCategories(event.placeId);

        emit(MenuLoaded(placeId: event.placeId, categories: categories));
      } else if (event is CreateCategory) {
        await HiveProvider.createCategory(
            CategoryModel(id: 0, name: event.name, placeId: event.placeId));

        final categories = await HiveProvider.getCategories(event.placeId);

        emit(MenuLoaded(placeId: event.placeId, categories: categories));
      } else if (event is FoodLoad) {
        final food = await HiveProvider.getFood(event.placeId);

        emit(FoodLoaded(food: food, placeId: event.placeId));
      } else if (event is CreateFood) {
        await HiveProvider.createFood(event.model, event.placeId);

        final food = await HiveProvider.getFood(event.placeId);

        emit(FoodLoaded(placeId: event.placeId, food: food));
      } else {
        emit(MenuLoading());
      }
    });
  }
}
