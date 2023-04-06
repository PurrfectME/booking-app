import 'package:bloc/bloc.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/reservation_vm.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:booking_app/utils/status_helper.dart';
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
          status: event.status,
          comment: reservation.comment,
          excludeReshuffle: reservation.excludeReshuffle,
        )));
      } else if (event is ReservationOpen) {
        final isUpdated = await DbProvider.db
            .openReservation(event.placeId, event.reservationId, event.start);
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
                  status: ReservationStatus.opened,
                  comment: updatedReservation.comment,
                  excludeReshuffle: updatedReservation.excludeReshuffle)));

          final now = DateTime.now();
          rBloc.add(ReservationsLoad(
              placeId: event.placeId,
              start:
                  DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
              end: DateTime(now.year, now.month, now.day + 1)
                      .millisecondsSinceEpoch -
                  1,
              //TODO: при открытии стола, когда возвращаемся назад на скрин с резервациями, то та резервация которая была фреш и которую мы открыли созраняет старое значение
              status: ReservationStatus.opened));

          //TODO: здесь не рендериться нормально когда с резер инфо нажимаешь назад на резервации
          trBloc.add(TableReservationsLoad(placeId: event.placeId));
        } else {
          emit(const ReservationInfoError(error: 'Ошибка открытия заявки'));
        }
      } else if (event is ReservationCancel) {
        final isCancelled = await DbProvider.db
            .cancelReservation(event.placeId, event.reservationId);

        if (isCancelled) {
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
            start:
                DateTime.fromMillisecondsSinceEpoch(updatedReservation.start),
            end: DateTime.fromMillisecondsSinceEpoch(updatedReservation.end),
            status: ReservationStatus.cancelled,
            comment: updatedReservation.comment,
            excludeReshuffle: updatedReservation.excludeReshuffle,
          )));

          //load reservs
          final now = DateTime.now();
          rBloc.add(ReservationsLoad(
              placeId: event.placeId,
              start:
                  DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
              end: DateTime(now.year, now.month, now.day + 1)
                      .millisecondsSinceEpoch -
                  1,
              status: ReservationStatus.opened));

          trBloc.add(TableReservationsLoad(placeId: event.placeId));
        } else {
          emit(const ReservationInfoError(error: 'Ошибка отмены заявки'));
        }
      } else if (event is ReservationInfoEdit) {
        //TODO: а если во время редактирования время поменять
        //TODO: то и заявка статус должна сменить, хотя это крайний кейс
        //потому что если гость пришёл раньше, то у завяки статус на открыта поменяется
        final map = {
          'phoneNumber': event.phoneNumber,
          'name': event.name,
          'guests': event.guests,
          'start': event.start.millisecondsSinceEpoch,
          'end': event.end.millisecondsSinceEpoch,
          'excludeReshuffle': event.excludeReshuffle,
          'comment': event.comment,
        };
        final isUpdated = await DbProvider.db
            .updateReservation(event.placeId, event.reservationId, map);

        if (isUpdated) {
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
            start:
                DateTime.fromMillisecondsSinceEpoch(updatedReservation.start),
            end: DateTime.fromMillisecondsSinceEpoch(updatedReservation.end),
            status: StatusHelper.toStatus(updatedReservation.status),
            comment: updatedReservation.comment,
            excludeReshuffle: updatedReservation.excludeReshuffle,
          )));

          final now = DateTime.now();
          rBloc.add(ReservationsLoad(
              placeId: event.placeId,
              start:
                  DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
              end: DateTime(now.year, now.month, now.day + 1)
                      .millisecondsSinceEpoch -
                  1,
              status: ReservationStatus.fresh));

          trBloc.add(TableReservationsLoad(placeId: event.placeId));
        } else {
          emit(const ReservationInfoError(error: 'Ошибка обновления заявки'));
        }
      } else if (event is ReservationWait) {
        final isAwaited = await DbProvider.db.updateReservation(
          event.placeId,
          event.reservationId,
          {'status': StatusHelper.fromStatus(ReservationStatus.waiting)},
        );

        if (isAwaited) {
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
            start:
                DateTime.fromMillisecondsSinceEpoch(updatedReservation.start),
            end: DateTime.fromMillisecondsSinceEpoch(updatedReservation.end),
            status: StatusHelper.toStatus(updatedReservation.status),
            comment: updatedReservation.comment,
            excludeReshuffle: updatedReservation.excludeReshuffle,
          )));

          //load reservs
          final now = DateTime.now();
          rBloc.add(ReservationsLoad(
              placeId: event.placeId,
              start:
                  DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
              end: DateTime(now.year, now.month, now.day + 1)
                      .millisecondsSinceEpoch -
                  1,
              status: ReservationStatus.waiting));

          trBloc.add(TableReservationsLoad(placeId: event.placeId));
        } else {
          emit(const ReservationInfoError(
              error: 'Ошибка смены статуса на ожидание'));
        }
      }
    });
  }
}
