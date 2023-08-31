import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/category_model.dart';
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
        await HiveProvider.createCategory(CategoryModel(
            id: 0,
            name: event.name,
            subCategories: null,
            placeId: event.placeId));

        final categories = await HiveProvider.getCategories(event.placeId);

        emit(MenuLoaded(placeId: event.placeId, categories: categories));
      } else {
        emit(MenuLoading());
      }
    });
  }
}
