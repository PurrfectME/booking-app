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
        await DbProvider.db.deleteAllPlaceModels();
        await DbProvider.db.deleteAllTables();
        // await DbProvider.db.deleteAllUsers();

        emit(PlacesLoading());

        final lastUpdate = await DbProvider.db.getPlacesLastUpdateDate();
        final a = DateTime.fromMillisecondsSinceEpoch(lastUpdate);

        //TODO: `get: /places?update_date=date`

        final placesResponse = [
          PlaceModel(
            1,
            'NEFT',
            'desc',
            1,
            null,
            DateTime(2022, 11, 30, 17, 20).millisecondsSinceEpoch,
            [
              TableModel(id: 1, number: 1, guests: 6, placeId: 1),
              TableModel(id: 2, number: 2, guests: 4, placeId: 1),
            ],
          ),
          PlaceModel(
            2,
            'Flow',
            'desc',
            1,
            null,
            DateTime.now().millisecondsSinceEpoch,
            [
              TableModel(id: 1, number: 1, guests: 6, placeId: 2),
            ],
          ),
        ];

        await DbProvider.db.createPlaceModels(placesResponse);

        final actualPlaces = await DbProvider.db.getAllPlaceModels();

        //if no places emit NotFoundState

        emit(PlacesLoaded(actualPlaces));
      }
    });
  }
}
