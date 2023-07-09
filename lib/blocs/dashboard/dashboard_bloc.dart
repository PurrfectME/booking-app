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

        // places
        //   ..add(PlaceModel(1, 'NEFT', 'description', 2, 'base64Logo', 1, [], 1,
        //       'Минск', 'Аранская 8', true))
        //   ..add(PlaceModel(1, 'NEFT', 'description', 2, 'base64Logo', 1, [], 1,
        //       'Минск', 'Аранская 8', true))
        //   ..add(PlaceModel(1, 'NEFT', 'description', 2, 'base64Logo', 1, [], 1,
        //       'Минск', 'Аранская 8', true));

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
      }
    });
  }
}
