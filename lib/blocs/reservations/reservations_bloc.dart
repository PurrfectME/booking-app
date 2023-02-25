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

    final r = <ReservationModel>[];

    for (final userReserv in userReservations) {
      r.addAll(userReserv.reservations);
    }

    final result = <ReservationViewModel>[];

    for (final table in tables) {
      for (final reserv in userReservations) {
        final a =
            reserv.reservations.where((r) => r.tableId == table.id).toList();

//TODO: засунуть юзера в резервации на конкретный стол
        result.add(ReservationViewModel(
            table: table, reservations: a, user: reserv.user));
      }
    }

    return result;
  }
}
