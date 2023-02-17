import 'package:bloc/bloc.dart';
import 'package:booking_app/blocs/reservations/reservations_state.dart';
import 'package:booking_app/models/local/reservations_vm.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';

part 'reservations_event.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc() : super(ReservationsLoading()) {
    on<ReservationsEvent>((event, emit) async {
      emit(ReservationsLoading());
      if (event is ReservationsLoad) {
        final reservations = await DbProvider.db.getReservations();

        final result = event.tables.map((table) {
            var reservationIndex = reservations.indexWhere((res) => res.tableId == table.id);


          bool isReserved = 


          return ReservationViewModel(
            from: 
              isReserved: isReserved,
              table: TableModel(table.id, table.number, table.image,
                  table.guests, table.placeId));
        }).toList();

        emit(ReservationsLoaded(result));
      }
    });
  }
}
