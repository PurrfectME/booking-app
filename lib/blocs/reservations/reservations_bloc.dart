import 'package:bloc/bloc.dart';
import 'package:booking_app/blocs/reserve_table/reserve_table_bloc.dart';
import 'package:booking_app/models/local/reservation_vm.dart';
import 'package:booking_app/models/models.dart';
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
              false,
              event.status,
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            }

            emit(ReservationsLoaded(data: result, placeId: event.placeId));

            break;
          case ReservationStatus.opened:
            final result = await filterReservations(
              event.placeId,
              event.start,
              true,
              event.status,
            );

            if (result.isEmpty) {
              emit(ReservationsLoaded(data: const [], placeId: event.placeId));
              break;
            }

            emit(ReservationsLoaded(data: result, placeId: event.placeId));
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
    bool isOpened,
    ReservationStatus status,
  ) async {
    final result = <ReservationViewModel>[];

    final reservations = await DbProvider.db
        .getReservationsByTime(placeId, start, isOpened ? 1 : 0);

    if (reservations.isEmpty) {
      return [];
    }

    for (final x in reservations) {
      final table = await DbProvider.db.getTableById(x.placeId, x.tableId);

      result.add(ReservationViewModel(
          id: x.id!,
          tableId: x.tableId,
          tableNumber: table!.number,
          name: x.name!,
          guests: x.guests,
          phoneNumber: x.phoneNumber!,
          start: DateTime.fromMillisecondsSinceEpoch(x.start),
          end: DateTime.fromMillisecondsSinceEpoch(x.end),
          status: status));
    }

    return result;
  }
}
