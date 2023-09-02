import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/food_model.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodLoading()) {
    on<FoodEvent>((event, emit) async {
      if (event is FoodLoad) {
        final food = await HiveProvider.getFood(event.placeId);

        emit(FoodLoaded(food: food, placeId: event.placeId));
      } else {
        emit(FoodLoading());
      }
    });
  }
}
