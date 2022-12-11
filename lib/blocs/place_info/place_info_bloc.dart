import 'package:booking_app/models/db/user_reservation_model.dart';
import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'place_info_event.dart';
part 'place_info_state.dart';

class PlaceInfoBloc extends Bloc<PlaceInfoEvent, PlaceInfoState> {
  final PlaceModel place;

  PlaceInfoBloc({required this.place}) : super(PlaceInfoLoading()) {
    on<PlaceInfoEvent>((event, emit) async {
      if (event is PlaceInfoLoad) {
        emit(PlaceInfoLoading());

        //мы сохраняем локально в бд резервации юзера, а просто таблицу со всеми резервациями нет
        //а как менеджить момент когда с одного телефона два юзера разных зайдут,(бд одна)
        //тогда помимо юзер резерваций нужно сохранять и в обычные

        //TODO: `get: /place/{event.placeId}/tables`
        final reservedTablesResponse = [
          ReservationModel(
            2,
            6,
            DateTime(2022, 12, 7, 22).millisecondsSinceEpoch,
            DateTime(2022, 12, 7, 23).millisecondsSinceEpoch,
          ),
          ReservationModel(
            1,
            5,
            DateTime(2022, 12, 7, 22).millisecondsSinceEpoch,
            DateTime(2022, 12, 7, 23).millisecondsSinceEpoch,
          ),
        ];

        //TODO: `get: /profile/tables`
        final userReservedTablesResponse = [
          UserReservationModel(
              1,
              2,
              5,
              reservedTablesResponse[0].start,
              reservedTablesResponse[0].end,
              DateTime.now().millisecondsSinceEpoch)
        ];

        //INSERT USER RESERVATIONS INTO DB?? add update_date to user reservations

        //TODO: надо будет удалять из бд резервации, которые уже прошли, чтобы не захламлять бд телефона

        await DbProvider.db.createAllReservations(
            reservedTablesResponse, userReservedTablesResponse);

        final availableTables = <TableViewModel>[];

        for (var table in place.tables) {
          if (table == null) {
            continue;
          }

          //TODO: add date validation
          final reserved = reservedTablesResponse
              .any((reservation) => table.id == reservation.tableId);

          if (reserved) {
            final currentUserReservationIndex =
                userReservedTablesResponse.indexWhere((userTable) =>
                    userTable.tableId == table.id &&
                    userTable.placeId == table.placeId);

            if (currentUserReservationIndex != -1) {
              availableTables.add(TableViewModel(
                  table,
                  null,
                  null,
                  // userReservedTables[currentUserReservationIndex].from,
                  // userReservedTables[currentUserReservationIndex].to,
                  true));
            }
          } else {
            availableTables.add(TableViewModel(
                table,
                null,
                null,
                // userReservedTables[currentUserReservationIndex].from,
                // userReservedTables[currentUserReservationIndex].to,
                false));
          }
        }

        final a = await DbProvider.db.getUserReservationsLastUpdateDate();

        emit(PlaceInfoLoaded(availableTables));
      } else if (event is PlaceTableReserve) {
        // api call
        // final response = await api.reserveTable(id: event.id)

        // if ok
        // if (response.status == 200)
        if (true) {
          // final tableIndex = tables.indexWhere((table) => table.id == event.id);
          // if (tableIndex > -1) {
          //   tables[tableIndex] = tables[tableIndex].copyWith(isFree: false);
          // }
          emit(PlaceTableReserveSuccess(id: event.id));
        } else {
          // RESERVE ERROR IN MODal
        }
        emit(PlaceInfoLoaded([]));
      }
    });
  }
}
