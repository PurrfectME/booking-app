import 'package:bloc/bloc.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/reservation_vm.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:equatable/equatable.dart';

part 'reservation_info_event.dart';
part 'reservation_info_state.dart';

class ReservationInfoBloc
    extends Bloc<ReservationInfoEvent, ReservationInfoState> {
  final TableReservationsBloc trBloc;
  final ReservationsBloc rBloc;
  ReservationInfoBloc({required this.trBloc, required this.rBloc})
      : super(ReservationInfoLoading()) {
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
                placeId: reservation.placeId,
                tableId: reservation.tableId,
                tableNumber: table!.number,
                name: reservation.name!,
                guests: reservation.guests,
                phoneNumber: reservation.phoneNumber!,
                start: DateTime.fromMillisecondsSinceEpoch(reservation.start),
                end: DateTime.fromMillisecondsSinceEpoch(reservation.end),
                status: event.status)));
      } else if (event is ReservationOpen) {
        final isUpdated = await DbProvider.db
            .openReservation(event.placeId, event.reservationId);
        if (isUpdated) {
          emit(ReservationInfoUpdated());

          final updatedReservation = await DbProvider.db
              .getReservationsById(event.placeId, event.reservationId);

          final table = await DbProvider.db
              .getTableById(event.placeId, updatedReservation.tableId);

          emit(ReservationInfoLoaded(
              data: ReservationViewModel(
                  id: updatedReservation.id!,
                  placeId: updatedReservation.placeId,
                  tableId: updatedReservation.tableId,
                  tableNumber: table!.number,
                  name: updatedReservation.name!,
                  guests: updatedReservation.guests,
                  phoneNumber: updatedReservation.phoneNumber!,
                  start: DateTime.fromMillisecondsSinceEpoch(
                      updatedReservation.start),
                  end: DateTime.fromMillisecondsSinceEpoch(
                      updatedReservation.end),
                  status: ReservationStatus.opened)));

          final now = DateTime.now();
          rBloc.add(ReservationsLoad(
              placeId: event.placeId,
              start:
                  DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
              end: DateTime(now.year, now.month, now.day + 1)
                      .millisecondsSinceEpoch -
                  1,
              status: ReservationStatus.opened));

          //TODO: здесь не рендериться нормально когда с резер инфо нажимаешь назад на резервации
          trBloc.add(TableReservationsLoad(placeId: event.placeId));
        } else {
          emit(const ReservationInfoError(error: 'Ошибка открытия заявки'));
        }
      }
    });
  }
}
