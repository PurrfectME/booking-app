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
        final result = await _initReservations(tables!);

        emit(ReservationsLoaded(result));
      } else if (event is RemoveReservation) {
        final isDeleted = await DbProvider.db
            .deleteReservation(event.reservationId, event.placeId);

        emit(RemoveReservationSuccess(tableNumber: event.tableNumber));
        emit(ReservationsLoaded(await _initReservations(tables!)));
      }
    });
  }

  Future<List<ReservationViewModel>> _initReservations(
      List<TableModel> tables) async {
    final reservations = await DbProvider.db.getReservations();

    return tables
        .map((table) => ReservationViewModel(
            table: table,
            reservations: reservations
                .where((reserv) => reserv.tableId == table.id)
                .toList()))
        .toList();
  }
}
