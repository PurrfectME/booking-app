import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/reservation_vm.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:equatable/equatable.dart';

part 'reservation_info_event.dart';
part 'reservation_info_state.dart';

class ReservationInfoBloc
    extends Bloc<ReservationInfoEvent, ReservationInfoState> {
  ReservationInfoBloc() : super(ReservationInfoLoading()) {
    on<ReservationInfoEvent>((event, emit) async {
      if (event is ReservationInfoLoad) {
        emit(ReservationInfoLoading());

        final reservation = await DbProvider.db
            .getReservationsById(event.placeId, event.reservationId);

        final table = await DbProvider.db
            .getTableById(event.placeId, reservation.tableId);

        emit(ReservationInfoLoaded(
            data: ReservationViewModel(
                id: reservation.id!,
                tableId: reservation.tableId,
                tableNumber: table!.number,
                name: reservation.name!,
                guests: reservation.guests,
                phoneNumber: reservation.phoneNumber!,
                start: DateTime.fromMillisecondsSinceEpoch(reservation.start),
                end: DateTime.fromMillisecondsSinceEpoch(reservation.end),
                status: event.status)));
      }
    });
  }
}
