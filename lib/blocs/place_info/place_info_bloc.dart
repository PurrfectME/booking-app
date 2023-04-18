import 'dart:typed_data';

import 'package:booking_app/models/db/table_image_model.dart';
import 'package:booking_app/models/db/user_reservation_model.dart';
import 'package:booking_app/models/local/place_info_vm.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:booking_app/services/image/image_service.dart';
import 'package:booking_app/utils/status_helper.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/hive_db.dart';

part 'place_info_event.dart';
part 'place_info_state.dart';

class PlaceInfoBloc extends Bloc<PlaceInfoEvent, PlaceInfoState> {
  final int id;

  PlaceModel? place;
  List<TableReservationDto> availableTables = [];

  PlaceInfoBloc({
    required this.id,
  }) : super(PlaceInfoLoading()) {
    on<PlaceInfoEvent>((event, emit) async {
      place = await HiveProvider.getPlaceById(id);

      if (event is PlaceInfoLoad) {
        emit(PlaceInfoLoading());
        availableTables.clear();

        final reservedTablesResponse =
            await HiveProvider.getReservations(place!.id);

        // final userReservedTablesResponse =
        //     await DbProvider.db.getAllUserReservations();

        //INSERT USER RESERVATIONS INTO DB?? add update_date to user reservations

        //TODO: надо будет удалять из бд резервации, которые уже прошли, чтобы не захламлять бд телефона

        // await DbProvider.db.createAllReservations(
        //     reservedTablesResponse, userReservedTablesResponse);

        final tableIds = <int>[];

        if (reservedTablesResponse.isNotEmpty) {
          for (final table in place!.tables) {
            final reserved = reservedTablesResponse.any((x) {
              final start = DateTime.fromMillisecondsSinceEpoch(x.start);
              final end = DateTime.fromMillisecondsSinceEpoch(x.end);
              final selected = event.selectedDateTime;

              if (table.id == x.tableId) {
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
              availableTables.add(TableReservationDto(
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
          tableIds.addAll(place!.tables.map((e) => e.id));
          availableTables.addAll(place!.tables.map((e) => TableReservationDto(
              e,
              null,
              null,
              // userReservedTables[currentUserReservationIndex].from,
              // userReservedTables[currentUserReservationIndex].to,
              false,
              [])));
        }

        // final a = await DbProvider.db.getUserReservationsLastUpdateDate();

        // final tableImages = await DbProvider.db.getTableImages(tableIds);
        final tableImages = <TableImageModel>[];
        //TODO: better performance when sorted tableImages, availableTables?
        // tableImages.sort((a, b) => a.tableId.compareTo(b.tableId));

//TODO: optimize here
        if (tableImages.isNotEmpty) {
          for (var i = 0; i < availableTables.length; i++) {
            final tempTables = List<TableReservationDto>.from(availableTables);
            availableTables.forEachIndexed((table, index) {
              final imagesModel = tableImages
                  .where((x) => x.tableId == table.table.id)
                  .toList();

              tempTables[index] = table.copyWith(
                  imagesBytes: List.from(
                      imagesModel.map<Uint8List>((e) => e.imageBytes)));
            });
            availableTables = tempTables;
          }
        }

        emit(PlaceInfoLoaded(PlaceInfoViewModel(
            placeId: place!.id,
            tables: availableTables,
            logo: ImageService.imageFromBase64String(place!.base64Logo),
            placeName: place!.name)));
      } else if (event is UserTableReserve) {
        // api call
        // final response = await api.reserveTable(id: event.id)

        // if ok
        // if (response.status == 200)
        // ignore: literal_only_boolean_expressions
        if (true) {
          final resultId = await DbProvider.db.createUserReservation(
              LocalUserReservationModel(
                  placeId: id,
                  tableId: event.tableId,
                  start: event.start.millisecondsSinceEpoch,
                  end: event.end.millisecondsSinceEpoch,
                  updateDate: DateTime.now().millisecondsSinceEpoch,
                  guests: event.guests));

          final currentUser = await DbProvider.db.getCurrentUser();

          final resId = await DbProvider.db.createReservation(ReservationModel(
              id: null,
              tableId: event.tableId,
              placeId: id,
              userId: currentUser.id,
              name: currentUser.name,
              phoneNumber: currentUser.login,
              start: event.start.millisecondsSinceEpoch,
              end: event.end.millisecondsSinceEpoch,
              guests: event.guests,
              excludeReshuffle: false,
              comment: 'user.comment',
              status: StatusHelper.fromStatus(ReservationStatus.fresh)));

          final tableIndex = availableTables
              .indexWhere((table) => table.table.id == event.tableId);

          if (tableIndex != -1) {
            availableTables[tableIndex] =
                availableTables[tableIndex].copyWith(isReservedByUser: true);
          }
          emit(PlaceTableReserveSuccess(id: event.tableId));
        } else {
          //TODO: RESERVE ERROR IN MODal
        }
        emit(PlaceInfoLoaded(PlaceInfoViewModel(
            placeId: place!.id,
            tables: availableTables,
            logo: ImageService.imageFromBase64String(place!.base64Logo),
            placeName: place!.name)));
      }
    });
  }
}
