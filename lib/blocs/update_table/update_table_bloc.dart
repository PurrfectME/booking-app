import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/table_model.dart';
import 'package:equatable/equatable.dart';

part 'update_table_event.dart';
part 'update_table_state.dart';

class UpdateTableBloc extends Bloc<UpdateTableEvent, UpdateTableState> {
  UpdateTableBloc() : super(UpdateTableLoading()) {
    on<UpdateTableEvent>((event, emit) {
      if (event is UpdateTableLoad) {
        emit(UpdateTableLoading());

        // final place = await DbProvider.db.getPlaceById(event.id);

        emit(UpdateTableLoaded(event.data));
      }
    });
  }
}
