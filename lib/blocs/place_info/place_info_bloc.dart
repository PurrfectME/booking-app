import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/models/db/user_reservation_model.dart';
import 'package:booking_app/models/local/place_info_vm.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/services/image/image_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'place_info_event.dart';
part 'place_info_state.dart';

class PlaceInfoBloc extends Bloc<PlaceInfoEvent, PlaceInfoState> {
  final PlaceModel place;
  List<TableReservationViewModel> availableTables = [];

  PlaceInfoBloc({required this.place}) : super(PlaceInfoLoading()) {
    on<PlaceInfoEvent>((event, emit) async {
      if (event is PlaceInfoLoad) {
        emit(PlaceInfoLoading());
        availableTables.clear();

        //TODO: !!!!!!!!!!!!!отображать столы если выбрана другая дата

        //мы сохраняем локально в бд резервации юзера, а просто таблицу со всеми резервациями нет
        //а как менеджить момент когда с одного телефона два юзера разных зайдут,(бд одна)
        //тогда помимо юзер резерваций нужно сохранять и в обычные
        //TODO: `get: /place/{event.placeId}/tables`
        // final reservedTablesResponse = [
        //   ReservationModel(
        //     2,
        //     7,
        //     DateTime(2022, 12, 7, 22).millisecondsSinceEpoch,
        //     DateTime(2022, 12, 7, 23).millisecondsSinceEpoch,
        //   ),
        //   ReservationModel(
        //     1,
        //     5,
        //     DateTime(2022, 12, 7, 22).millisecondsSinceEpoch,
        //     DateTime(2022, 12, 7, 23).millisecondsSinceEpoch,
        //   ),
        // ];

        //TODO: `get: /profile/tables`
        // final userReservedTablesResponse = [
        //   UserReservationModel(
        //       1,
        //       2,
        //       5,
        //       reservedTablesResponse[0].start,
        //       reservedTablesResponse[0].end,
        //       DateTime.now().millisecondsSinceEpoch)
        // ];

        final reservedTablesResponse = await DbProvider.db.getReservations();

        // final userReservedTablesResponse =
        //     await DbProvider.db.getAllUserReservations();

        //INSERT USER RESERVATIONS INTO DB?? add update_date to user reservations

        //TODO: надо будет удалять из бд резервации, которые уже прошли, чтобы не захламлять бд телефона

        // await DbProvider.db.createAllReservations(
        //     reservedTablesResponse, userReservedTablesResponse);

        final tableIds = <int>[];

        if (reservedTablesResponse.isNotEmpty) {
          for (final table in place.tables) {
            //TODO: add date validation
            final reserved = reservedTablesResponse.any((reservation) {
              final start =
                  DateTime.fromMillisecondsSinceEpoch(reservation.start);
              final end = DateTime.fromMillisecondsSinceEpoch(reservation.end);
              final selected =
                  DateTime.fromMillisecondsSinceEpoch(event.dateInMilliseconds);

              if (table.id == reservation.tableId) {
                if (selected.isAfter(start) && selected.isBefore(end)) {
                  return true;
                }

                if ((selected.isAfter(
                            start.subtract(const Duration(hours: 3))) &&
                        selected.isBefore(end)) ||
                    selected.isAtSameMomentAs(end)) {
                  return true;
                } else {
                  return false;
                }
              } else {
                return false;
              }
            });

            if (!reserved) {
              tableIds.add(table.id);
              availableTables.add(TableReservationViewModel(
                  table,
                  null,
                  null,
                  // userReservedTables[currentUserReservationIndex].from,
                  // userReservedTables[currentUserReservationIndex].to,
                  false,
                  []));
            }
          }
        } else {
          tableIds.addAll(place.tables.map((e) => e.id));
          availableTables
              .addAll(place.tables.map((e) => TableReservationViewModel(
                  e,
                  null,
                  null,
                  // userReservedTables[currentUserReservationIndex].from,
                  // userReservedTables[currentUserReservationIndex].to,
                  false,
                  [])));
        }

        final a = await DbProvider.db.getUserReservationsLastUpdateDate();

        final tableImages = await DbProvider.db.getTableImages(tableIds);

        //TODO: better performance when sorted tableImages, availableTables?
        // tableImages.sort((a, b) => a.tableId.compareTo(b.tableId));

//TODO: optimize here
        if (tableImages.isNotEmpty) {
          for (var i = 0; i < availableTables.length; i++) {
            final imageToAdd = ImageService.imageFromBase64String(tableImages
                .firstWhere((tableImage) =>
                    availableTables[i].table.id == tableImage.tableId)
                .base64Images);

            availableTables[i].images.add(imageToAdd);
          }
        }

        emit(PlaceInfoLoaded(PlaceInfoViewModel(
            placeId: place.id,
            tables: availableTables,
            logo: ImageService.imageFromBase64String(place.base64Logo),
            placeName: place.name)));
      } else if (event is PlaceTableReserve) {
        // api call
        // final response = await api.reserveTable(id: event.id)

        // if ok
        // if (response.status == 200)
        if (true) {
          final resultId = await DbProvider.db.createUserReservation(
              UserReservationModel(
                  id: null,
                  placeId: event.placeId,
                  tableId: event.id,
                  start: event.start.millisecondsSinceEpoch,
                  end: event.end.millisecondsSinceEpoch,
                  updateDate: DateTime.now().millisecondsSinceEpoch,
                  guests: event.guests));

          final resId = await DbProvider.db.createReservation(ReservationModel(
              id: null,
              tableId: event.id,
              placeId: event.placeId,
              start: event.start.millisecondsSinceEpoch,
              end: event.end.millisecondsSinceEpoch,
              guests: event.guests));

          final tableIndex =
              availableTables.indexWhere((table) => table.table.id == event.id);

          if (tableIndex != -1) {
            availableTables[tableIndex] =
                availableTables[tableIndex].copyWith(isReservedByUser: true);
          }
          emit(PlaceTableReserveSuccess(id: event.id));
        } else {
          //TODO: RESERVE ERROR IN MODal
        }
        emit(PlaceInfoLoaded(PlaceInfoViewModel(
            placeId: place.id,
            tables: availableTables,
            logo: ImageService.imageFromBase64String(place.base64Logo),
            placeName: place.name)));
      }
    });
  }
}
