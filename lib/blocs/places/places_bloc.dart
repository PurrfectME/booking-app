import 'package:bloc/bloc.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:equatable/equatable.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesLoading()) {
    on<PlacesEvent>((event, emit) async {
      if (event is PlacesLoad) {
        emit(PlacesLoading());

//call to api
        await Future.delayed(Duration(seconds: 5));

        final data = [
          PlaceModel(name: "NEFT", currentGuests: 30, maxGuests: 100),
          PlaceModel(name: "FABRIQ", currentGuests: 6, maxGuests: 56),
          PlaceModel(name: "EMBER", currentGuests: 19, maxGuests: 76),
        ];

        emit(PlacesLoaded(data));
      }
    });
  }
}
