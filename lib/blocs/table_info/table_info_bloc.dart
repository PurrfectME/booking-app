import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:booking_app/utils/status_helper.dart';
import 'package:equatable/equatable.dart';

part 'table_info_event.dart';
part 'table_info_state.dart';

class TableInfoBloc extends Bloc<TableInfoEvent, TableInfoState> {
  TableInfoBloc() : super(TableInfoLoading()) {
    on<TableInfoEvent>((event, emit) async {
      if (event is TableInfoLoad) {
        emit(TableInfoLoading());

        final table =
            await HiveProvider.getTableById(event.placeId, event.tableId);

        final tableReservations = (await HiveProvider.getTableReservations(
                table!.placeId, table.id))
            .where((x) =>
                StatusHelper.toStatus(x.status) != ReservationStatus.cancelled);

        final res = tableReservations.where((x) {
          final start = DateTime.fromMillisecondsSinceEpoch(x.start);
          final now = DateTime.now();
          //TODO: 20 - максимальное время ожидания гостя
          if (start.isAfter(now) || now.difference(start).inMinutes < 20) {
            return true;
          }

          return false;
        }).toList();

        final result = TableInfoViewModel(table: table, reservations: res);

        emit(TableInfoLoaded(data: result));
      }
    });
  }
}
