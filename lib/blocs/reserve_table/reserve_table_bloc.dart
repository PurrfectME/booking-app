import 'package:bloc/bloc.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';

part 'reserve_table_event.dart';
part 'reserve_table_state.dart';

class ReserveTableBloc extends Bloc<ReserveTableEvent, ReserveTableState> {
  ReserveTableBloc() : super(ReserveTableLoading()) {
    on<ReserveTableEvent>((event, emit) async {
      if (event is ReserveTableLoad) {
        emit(ReserveTableLoading());

        emit(
            ReserveTableLoaded(placeId: event.placeId, tableId: event.tableId));
      } else if (event is AdminReserveTable) {
        final user = await DbProvider.db.getByPhoneNumber(event.phoneNumber);

        final resId = await DbProvider.db.createReservation(ReservationModel(
            id: null,
            tableId: event.tableId,
            placeId: event.placeId,
            userId: user?.id,
            phoneNumber: event.phoneNumber,
            name: event.name,
            start: event.start.millisecondsSinceEpoch,
            end: event.end.millisecondsSinceEpoch,
            guests: event.guests,
            isOpened: false,
            excludeReshuffle: event.excludeReshuffle));

        // final currentTables = await DbProvider.db.getTables(event.placeId);

        // reservationsBloc.add(ReservationsLoad(placeId: event.placeId));

        // tableInfoBloc
        //     .add(TableInfoLoad(placeId: event.placeId, tableId: event.tableId));
        emit(ReserveTableSuccess(
            tableId: event.tableId, placeId: event.placeId));
      }
    });
  }
}
