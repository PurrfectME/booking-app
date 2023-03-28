import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';

part 'table_info_event.dart';
part 'table_info_state.dart';

class TableInfoBloc extends Bloc<TableInfoEvent, TableInfoState> {
  TableInfoBloc() : super(TableInfoLoading()) {
    on<TableInfoEvent>((event, emit) async {
      if (event is TableInfoLoad) {
        emit(TableInfoLoading());

        final tableReservations = (await DbProvider.db
                .getTableReservations(event.table.placeId, event.table.id))
            .where((x) {
          final start = DateTime.fromMillisecondsSinceEpoch(x.start);
          final now = DateTime.now();
          //TODO: 20 - максимальное время ожидания гостя
          if (start.isAfter(now) || now.difference(start).inMinutes < 20) {
            return true;
          }

          return false;
        }).toList();

        final result = TableInfoViewModel(
            table: event.table, reservations: tableReservations);

        emit(TableInfoLoaded(data: result));
      }
    });
  }
}
