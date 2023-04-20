import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/reservation_vm.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:equatable/equatable.dart';

import '../../utils/status_helper.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc() : super(ReservationsLoading()) {
    on<ReservationsEvent>((event, emit) async {
      if (event is ReservationsLoad) {
        emit(ReservationsLoading());

        //TODO: вытягивать всегда сразу все резервации,
        //TODO: сортровать по переменным статуса и держать в блоке

        switch (event.status) {
          case ReservationStatus.fresh:
            //TODO: достать всю инфу одним запросом
            final result = await filterReservations(
              event.placeId,
              event.start,
              event.end,
              StatusHelper.fromStatus(ReservationStatus.fresh),
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            } else {
              //костыль на то, чтобы поменять статус на waiting
              final now = DateTime.now();
              final waitings = result
                  .where((x) =>
                      x.start.millisecondsSinceEpoch <
                          DateTime(now.year, now.month, now.day, now.hour,
                                  now.minute)
                              .millisecondsSinceEpoch &&
                      x.end.millisecondsSinceEpoch >
                          DateTime(now.year, now.month, now.day, now.hour,
                                  now.minute)
                              .millisecondsSinceEpoch)
                  .toList();

              result.removeWhere((x) =>
                  x.start.millisecondsSinceEpoch <
                      DateTime(now.year, now.month, now.day, now.hour,
                              now.minute)
                          .millisecondsSinceEpoch &&
                  x.end.millisecondsSinceEpoch >
                      DateTime(now.year, now.month, now.day, now.hour,
                              now.minute)
                          .millisecondsSinceEpoch);

              for (final x in waitings) {
                await HiveProvider.updateReservation(
                  event.placeId,
                  x.id,
                  {
                    'status': StatusHelper.fromStatus(ReservationStatus.waiting)
                  },
                );
              }
            }

            emit(ReservationsLoaded(data: result, placeId: event.placeId));
            break;
          case ReservationStatus.opened:
            final result = await filterReservations(
              event.placeId,
              event.start,
              event.end,
              StatusHelper.fromStatus(ReservationStatus.opened),
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            }

            emit(ReservationsLoaded(data: result, placeId: event.placeId));
            break;
          case ReservationStatus.waiting:
            final result = await filterReservations(
              event.placeId,
              event.start,
              event.end,
              StatusHelper.fromStatus(ReservationStatus.waiting),
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            }

            emit(ReservationsLoaded(data: result, placeId: event.placeId));

            break;
          case ReservationStatus.closing:
            final result = await filterReservations(
              event.placeId,
              event.start,
              event.end,
              StatusHelper.fromStatus(ReservationStatus.closing),
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            }

            emit(ReservationsLoaded(data: result, placeId: event.placeId));

            break;
          case ReservationStatus.cancelled:
            final result = await HiveProvider.getArchivedReservations(
                event.placeId,
                DateTime.now().millisecondsSinceEpoch,
                StatusHelper.fromStatus(ReservationStatus.cancelled));

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            }

            final a = <ReservationViewModel>[];

            for (final x in result) {
              final table =
                  await HiveProvider.getTableById(x.placeId, x.tableId);

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
    int status,
  ) async {
    final result = <ReservationViewModel>[];

    final reservations =
        await HiveProvider.getReservationsByTime(placeId, start, end, status);

    if (reservations.isEmpty) {
      return [];
    }

    for (final x in reservations) {
      final table = await HiveProvider.getTableById(x.placeId, x.tableId);

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
        status: StatusHelper.toStatus(x.status),
        excludeReshuffle: x.excludeReshuffle,
        comment: x.comment,
      ));
    }

    return result;
  }
}
