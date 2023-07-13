import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    on<DashboardEvent>((event, emit) async {
      if (event is DashboardLoad) {
        emit(DashboardLoading());

        final user = await HiveProvider.getUserById(event.userId);
        final places = await HiveProvider.getPlacesByOwnerId(event.userId);

        emit(DashboardLoaded(user: user, places: places));
      } else if (event is CreatePlace) {
        await HiveProvider.createPlace(PlaceModel(
          0,
          event.name,
          '',
          0,
          null,
          DateTime.now().millisecondsSinceEpoch,
          [],
          event.ownerId,
          event.city,
          event.address,
          false,
        ));

        final user = await HiveProvider.getUserById(event.ownerId);
        final places = await HiveProvider.getPlacesByOwnerId(event.ownerId);

        emit(DashboardLoaded(user: user, places: places));
      } else if (event is ChangeBookingType) {
        await HiveProvider.changeBookingType(event.placeId);

        final user = await HiveProvider.getUserById(event.ownerId);
        final places = await HiveProvider.getPlacesByOwnerId(event.ownerId);

        emit(DashboardLoaded(user: user, places: places));
      }
    });
  }
}
