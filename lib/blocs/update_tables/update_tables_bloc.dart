import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/table_model.dart';
import 'package:equatable/equatable.dart';

part 'update_tables_event.dart';
part 'update_tables_state.dart';

class UpdateTablesBloc extends Bloc<UpdateTablesEvent, UpdateTablesState> {
  UpdateTablesBloc() : super(UpdateTablesLoading()) {
    on<UpdateTablesEvent>((event, emit) {
      if (event is UpdateTablesLoad) {
        emit(UpdateTablesLoading());

        // final place = await DbProvider.db.getPlaceById(event.id);

        emit(UpdateTablesLoaded(event.data));
      }
    });
  }
}
