import 'package:bloc/bloc.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:equatable/equatable.dart';

import '../../services/reshuffle/reshuffle_service.dart';
import '../../utils/status_helper.dart';

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
        final user = await HiveProvider.getUserByPhoneNumber(event.phoneNumber);

        final resId = await HiveProvider.createReservation(ReservationModel(
            id: null,
            tableId: event.tableId,
            placeId: event.placeId,
            userId: user?.id,
            phoneNumber: event.phoneNumber,
            name: event.name,
            start: event.start.millisecondsSinceEpoch,
            end: event.end.millisecondsSinceEpoch,
            guests: event.guests,
            excludeReshuffle: event.excludeReshuffle,
            comment: event.comment,
            status: event.inFact
                ? StatusHelper.fromStatus(ReservationStatus.opened)
                : StatusHelper.fromStatus(ReservationStatus.fresh)));

        // await const ReshuffleService().makeReshuffle(event.placeId);
        emit(ReserveTableSuccess(
            tableId: event.tableId, placeId: event.placeId));
      }
    });
  }
}
