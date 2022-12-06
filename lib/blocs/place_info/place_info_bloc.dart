import 'package:booking_app/models/api/user_reservation_model.dart';
import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/models/models.dart';
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

        // `get: /place/{event.placeId}/tables`
        final reservedTables = [
          ReservationModel(
            1,
            5,
            DateTime(2022, 12, 7, 21).millisecondsSinceEpoch,
            DateTime(2022, 12, 7, 22).millisecondsSinceEpoch,
          ),
          ReservationModel(
            2,
            6,
            DateTime(2022, 12, 7, 21).millisecondsSinceEpoch,
            DateTime(2022, 12, 7, 22).millisecondsSinceEpoch,
          ),
        ];

        //INSERT RESERVATIONS INTO DB??

        //`get: /profile/tables`
        final userReservedTables = [
          UserReservationModel(
              1, 2, 5, reservedTables[0].from, reservedTables[0].to)
        ];

        final availableTables = place.tables.where((table) {
          for (var reservation in reservedTables) {
            //TODO: add date validation

            if (table?.id == reservation.tableId &&
                userReservedTables.indexWhere((userTable) =>
                        userTable.tableId == reservation.tableId &&
                        userTable.placeId == table?.placeId) ==
                    -1) {
              return false;
            }
          }
          return true;
        }).toList();

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
        emit(PlaceInfoLoaded(place.tables));
      }
    });
  }
}
