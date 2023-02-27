// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/models.dart';

class ReservationViewModel {
  TableModel table;
  List<UserReservationModel> reservations;
  ReservationViewModel({required this.table, required this.reservations});

  ReservationViewModel copyWith(
          {TableModel? table, List<UserReservationModel>? reservations}) =>
      ReservationViewModel(
          table: table ?? this.table,
          reservations: reservations ?? this.reservations);
}
