import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';

part 'table_info_event.dart';
part 'table_info_state.dart';

class TableInfoBloc extends Bloc<TableInfoEvent, TableInfoState> {
  TableInfoBloc() : super(TableInfoLoading()) {
    on<TableInfoEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is TableInfoLoad) {
        emit(TableInfoLoading());

        final tableReservations = await DbProvider.db
            .getTableReservations(event.placeId, event.table.id);

        final result = TableInfoViewModel(
            table: event.table, reservations: tableReservations);

        emit(TableInfoLoaded(data: result));
      }
    });
  }
}
