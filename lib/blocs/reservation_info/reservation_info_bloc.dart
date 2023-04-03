import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reservation_info_event.dart';
part 'reservation_info_state.dart';

class ReservationInfoBloc
    extends Bloc<ReservationInfoEvent, ReservationInfoState> {
  ReservationInfoBloc() : super(ReservationInfoLoading()) {
    on<ReservationInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
