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
        emit(PlacesLoading());

//call to api
        await Future.delayed(Duration(seconds: 2));

        // final data = [
        //   PlaceModel(1, "NEFT", "desc", [1, 2], 1, DateTime.now(), []),
        //   PlaceModel(2, "NEFT", "desc", [1, 2], 1, DateTime.now(), []),
        //   PlaceModel(3, "NEFT", "desc", [1, 2], 1, DateTime.now(), []),
        // ];

        await DbProvider.db.createPlaceModel(PlaceModel(
            1,
            "NEFT",
            "desc",
            [1, 2],
            1,
            DateTime.now(),
            [
              TableModel(1, 1, 1, 6),
              TableModel(2, 1, 1, 6),
              TableModel(3, 1, 1, 6),
              TableModel(4, 1, 1, 6)
            ]));

        final actualPlace = await DbProvider.db.getAllPlaceModes();

        emit(PlacesLoaded(actualPlace));
      }
    });
  }
}
