import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';

part 'update_place_event.dart';
part 'update_place_state.dart';

class UpdatePlaceBloc extends Bloc<UpdatePlaceEvent, UpdatePlaceState> {
  UpdatePlaceBloc() : super(UpdatePlaceLoading()) {
    on<UpdatePlaceEvent>((event, emit) async {
      if (event is UpdatePlaceLoad) {
        emit(UpdatePlaceLoading());

        final place = await DbProvider.db.getPlaceById(event.id);

        emit(UpdatePlaceLoaded(place));
      } else if (event is UpdatePlace) {
        final data = event.data
            .copyWith(updateDate: DateTime.now().millisecondsSinceEpoch);
        await DbProvider.db.updatePlace(data);

        emit(UpdatePlaceSuccess());
      }
    });
  }
}
