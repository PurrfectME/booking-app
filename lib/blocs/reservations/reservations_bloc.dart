import 'package:bloc/bloc.dart';
import 'package:booking_app/blocs/reservations/reservations_state.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';

part 'reservations_event.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final List<TableModel>? tables;
  ReservationsBloc(this.tables) : super(ReservationsLoading()) {
    on<ReservationsEvent>((event, emit) async {
      emit(ReservationsLoading());
      if (event is ReservationsLoad) {
        final result = await _initReservations(tables!, event.placeId);

        emit(ReservationsLoaded(result));
      } else if (event is AdminTableReserve) {
        final resId = await DbProvider.db.createReservation(ReservationModel(
            id: null,
            tableId: event.tableId,
            placeId: event.placeId,
            userId: null,
            phoneNumber: event.phoneNumber,
            name: event.name,
            start: event.start.millisecondsSinceEpoch,
            end: event.end.millisecondsSinceEpoch,
            guests: event.guests));

        emit(ReservationsLoaded(
            await _initReservations(tables!, event.placeId)));
      } else if (event is RemoveReservation) {
        final isDeleted = await DbProvider.db
            .deleteReservation(event.reservationId, event.placeId);

        emit(RemoveReservationSuccess(tableNumber: event.tableNumber));
        emit(ReservationsLoaded(
            await _initReservations(tables!, event.placeId)));
      }
    });
  }

  Future<List<ReservationViewModel>> _initReservations(
      List<TableModel> tables, int placeId) async {
    final userReservations = await DbProvider.db.getReservations(placeId);

    final result = <ReservationViewModel>[];

    for (final table in tables) {
      final reservations = userReservations
          .where((x) => x.reservation.tableId == table.id)
          .toList();

      reservations
          .sort((a, b) => a.reservation.start.compareTo(b.reservation.start));
      result
          .add(ReservationViewModel(table: table, reservations: reservations));
    }

    return result;
  }
}
