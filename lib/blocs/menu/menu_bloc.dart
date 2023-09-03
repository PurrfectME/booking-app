import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuLoading()) {
    on<MenuEvent>((event, emit) async {
      if (event is MenuLoad) {
        emit(MenuLoading());

        emit(MenuLoaded(placeId: event.placeId));
      } else {
        emit(MenuLoading());
      }
    });
  }
}
