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
      }
    });
  }
}
