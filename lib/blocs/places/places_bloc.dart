import 'dart:typed_data';

import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesLoading()) {
    on<PlacesEvent>((event, emit) async {
      if (event is PlacesLoad) {
        // await DbProvider.db.deleteAllPlaceModels();
        // await DbProvider.db.deleteAllTables();
        emit(PlacesLoading());

        final lastUpdate = await DbProvider.db.getPlacesLastUpdateDate();
        final a = DateTime.fromMillisecondsSinceEpoch(lastUpdate);

        //TODO: `get: /places?update_date=date`

        final placesResponse = [
          PlaceModel(16, "NEFT", "desc", Uint8List.fromList([1, 2]), 1,
              DateTime(2022, 11, 30, 17, 20).millisecondsSinceEpoch, [
            TableModel(15, 1, 1, 6, 16),
          ]),
          PlaceModel(7, "NEFT", "desc", Uint8List.fromList([1, 2]), 1,
              DateTime.now().millisecondsSinceEpoch, [
            TableModel(16, 1, 1, 6, 7),
          ]),
          PlaceModel(
              6,
              "NEFT",
              "desc",
              Uint8List.fromList([1, 2]),
              1,
              DateTime.now().millisecondsSinceEpoch,
              [TableModel(9, 1, 1, 6, 6)]),
          PlaceModel(17, "NEFT", "desc", Uint8List.fromList([1, 2]), 1,
              DateTime(2022, 11, 30, 17, 20).millisecondsSinceEpoch, [
            TableModel(10, 1, 1, 6, 17),
          ]),
          PlaceModel(
              18,
              "NEFT",
              "desc",
              Uint8List.fromList([1, 2]),
              1,
              DateTime.now().millisecondsSinceEpoch,
              [TableModel(11, 1, 1, 6, 18)]),
          PlaceModel(9, "NEFT", "desc", Uint8List.fromList([1, 2]), 1,
              DateTime(2022, 11, 30, 17, 20).millisecondsSinceEpoch, [
            TableModel(12, 1, 1, 6, 9),
          ]),
          PlaceModel(
              120,
              "NEFT",
              "desc",
              Uint8List.fromList([1, 2]),
              1,
              DateTime.now().millisecondsSinceEpoch,
              [TableModel(13, 1, 1, 6, 120)]),
        ];

        // await DbProvider.db.createPlaceModels(placesResponse);

        final actualPlaces = await DbProvider.db.getAllPlaceModels();

        emit(PlacesLoaded(actualPlaces));
      }
    });
  }
}
