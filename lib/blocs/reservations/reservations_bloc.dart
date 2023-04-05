import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/reservation_vm.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:equatable/equatable.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc() : super(ReservationsLoading()) {
    on<ReservationsEvent>((event, emit) async {
      if (event is ReservationsLoad) {
        emit(ReservationsLoading());

        switch (event.status) {
          case ReservationStatus.fresh:
            //TODO: достать всю инфу одним запросом
            final result = await filterReservations(
              event.placeId,
              event.start,
              event.end,
              false,
              event.status,
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            } else {
              final List<ReservationViewModel> res;

              res =
                  result.where((x) => x.start.isAfter(DateTime.now())).toList();
              emit(ReservationsLoaded(data: res, placeId: event.placeId));
            }

            break;
          case ReservationStatus.opened:
            final result = await filterReservations(
              event.placeId,
              event.start,
              event.end,
              true,
              event.status,
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            } else {
              final List<ReservationViewModel> res;

              res = result
                  .where((x) =>
                      x.end.isAfter(DateTime.now()) &&
                      DateTime.now().difference(x.end).inMinutes > 20)
                  .toList();
              emit(ReservationsLoaded(data: res, placeId: event.placeId));
            }

            emit(ReservationsLoaded(data: result, placeId: event.placeId));
            break;
          case ReservationStatus.waiting:
            final result = await filterReservations(
              event.placeId,
              event.start,
              event.end,
              false,
              event.status,
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            } else {
              final List<ReservationViewModel> res;

              res = result
                  .where((x) => x.start.isBefore(DateTime.now()))
                  .toList();
              emit(ReservationsLoaded(data: res, placeId: event.placeId));
            }

            break;
          case ReservationStatus.closing:
            final result = await filterReservations(
              event.placeId,
              event.start,
              event.end,
              true,
              event.status,
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            } else {
              final List<ReservationViewModel> res;

              res = result
                  .where(
                      (x) => DateTime.now().difference(x.end).inMinutes <= 20)
                  .toList();
              emit(ReservationsLoaded(data: res, placeId: event.placeId));
            }

            break;
          case ReservationStatus.cancelled:
            final result = await DbProvider.db.getArchivedReservations(
                event.placeId, DateTime.now().millisecondsSinceEpoch, 1);

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            }

            final a = <ReservationViewModel>[];

            for (final x in result) {
              final table =
                  await DbProvider.db.getTableById(x.placeId, x.tableId);

              a.add(ReservationViewModel(
                id: x.id!,
                placeId: x.placeId,
                tableId: x.tableId,
                tableNumber: table!.number,
                name: x.name!,
                guests: x.guests,
                phoneNumber: x.phoneNumber!,
                start: DateTime.fromMillisecondsSinceEpoch(x.start),
                end: DateTime.fromMillisecondsSinceEpoch(x.end),
                status: event.status,
                comment: x.comment,
                excludeReshuffle: x.excludeReshuffle,
                isOpened: x.isOpened,
                isCancelled: x.isCancelled,
              ));
            }

            emit(ReservationsLoaded(data: a, placeId: event.placeId));
            break;
          default:
            emit(ReservationsLoaded(placeId: event.placeId, data: const []));
        }
      }
    });
  }

  Future<List<ReservationViewModel>> filterReservations(
    int placeId,
    int start,
    int end,
    bool isOpened,
    ReservationStatus status,
  ) async {
    final result = <ReservationViewModel>[];

    final reservations = await DbProvider.db
        .getReservationsByTime(placeId, start, end, isOpened ? 1 : 0);

    if (reservations.isEmpty) {
      return [];
    }

    for (final x in reservations) {
      final table = await DbProvider.db.getTableById(x.placeId, x.tableId);

      result.add(ReservationViewModel(
        id: x.id!,
        placeId: x.placeId,
        tableId: x.tableId,
        tableNumber: table!.number,
        name: x.name!,
        guests: x.guests,
        phoneNumber: x.phoneNumber!,
        start: DateTime.fromMillisecondsSinceEpoch(x.start),
        end: DateTime.fromMillisecondsSinceEpoch(x.end),
        status: status,
        excludeReshuffle: x.excludeReshuffle,
        comment: x.comment,
        isOpened: x.isOpened,
        isCancelled: x.isCancelled,
      ));
    }

    return result;
  }
}
