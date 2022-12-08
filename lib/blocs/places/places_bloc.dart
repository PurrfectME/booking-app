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
        emit(PlacesLoading());

        int lastUpdate = await DbProvider.db.getLastUpdateDate();
        final a = DateTime.fromMillisecondsSinceEpoch(lastUpdate);

        //TODO: `get: /places?update_date=date`

        // final placesResponse = [
        //   PlaceModel(1, "NEFT", "desc", Uint8List.fromList([1, 2]), 1,
        //       DateTime(2022, 11, 30, 17, 20).millisecondsSinceEpoch, [
        //     TableModel(1, 1, 1, 6, 1),
        //     TableModel(2, 1, 1, 6, 1),
        //     TableModel(3, 1, 1, 6, 1),
        //     TableModel(4, 1, 1, 6, 1)
        //   ]),
        //   PlaceModel(2, "NEFT", "desc", Uint8List.fromList([1, 2]), 1,
        //       DateTime.now().millisecondsSinceEpoch, [
        //     TableModel(5, 1, 1, 6, 2),
        //     TableModel(6, 1, 1, 6, 2),
        //     TableModel(7, 1, 1, 6, 2),
        //     TableModel(8, 1, 1, 6, 2)
        //   ]),
        // ];

        // await DbProvider.db.createPlaceModels(placesResponse);

        final actualPlaces = await DbProvider.db.getAllPlaceModels();

        emit(PlacesLoaded(actualPlaces));
      }
    });
  }
}
