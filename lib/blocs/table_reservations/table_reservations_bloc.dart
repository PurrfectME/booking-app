import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:equatable/equatable.dart';

import '../../utils/status_helper.dart';

part 'table_reservations_event.dart';
part 'table_reservations_state.dart';

class TableReservationsBloc
    extends Bloc<TableReservationsEvent, TableReservationsState> {
  final List<TableModel>? tables;
  TableReservationsBloc(this.tables) : super(TableReservationsLoading()) {
    on<TableReservationsEvent>((event, emit) async {
      if (event is TableReservationsLoad) {
        emit(TableReservationsLoading());
        final result = await _initReservations(tables!, event.placeId);

        emit(TableReservationsLoaded(result));
      } else if (event is AdminTableReserve) {
        emit(TableReservationsLoading());
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
            excludeReshuffle: false,
            comment: 'event.',
            status: StatusHelper.fromStatus(ReservationStatus.fresh)));

        final currentTables = await DbProvider.db.getTables(event.placeId);

        final result = await _initReservations(currentTables, event.placeId);
        emit(TableReservationsLoaded(result));
      } else if (event is TableRemoveReservation) {
        emit(TableReservationsLoading());

        final isDeleted = await DbProvider.db
            .deleteReservation(event.reservationId, event.placeId);

        emit(TableRemoveReservationSuccess(tableNumber: event.tableNumber));
        emit(TableReservationsLoaded(
            await _initReservations(tables!, event.placeId)));
      } else if (event is AdminEditReservation) {
        emit(TableReservationsLoading());

        final user = await DbProvider.db.getByPhoneNumber(event.phoneNumber);

        final result = await DbProvider.db.updateReservationOld(
            ReservationModel(
                id: event.reservationId,
                placeId: event.placeId,
                tableId: event.tableId,
                start: event.start.millisecondsSinceEpoch,
                end: event.end.millisecondsSinceEpoch,
                guests: event.guests,
                phoneNumber: event.phoneNumber,
                name: event.name,
                userId: user?.id,
                excludeReshuffle: false,
                comment: event.comment,
                status: 0));

        emit(TableEditReservationSuccess());
        emit(TableReservationsLoaded(
            await _initReservations(tables!, event.placeId)));
      }
    });
  }

  Future<List<TableReservationViewModel>> _initReservations(
      List<TableModel> tables, int placeId) async {
    final userReservations = (await DbProvider.db.getReservations(placeId))
        .where((x) =>
            StatusHelper.toStatus(x.reservation.status) !=
            ReservationStatus.cancelled);

    final result = <TableReservationViewModel>[];

    for (final table in tables) {
      final reservations = userReservations
          .where((x) => x.reservation.tableId == table.id)
          .toList();

      reservations
          .sort((a, b) => a.reservation.start.compareTo(b.reservation.start));
      result.add(
          TableReservationViewModel(table: table, reservations: reservations));
    }

    return result;
  }
}
