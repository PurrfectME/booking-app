// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/models/db/table_model.dart';

class ReservationViewModel {
  //TODO: edit here to model with images
  TableModel table;
  List<ReservationModel> reservations;
  ReservationViewModel({
    required this.table,
    required this.reservations,
  });

  ReservationViewModel copyWith({
    TableModel? table,
    List<ReservationModel>? reservations,
  }) =>
      ReservationViewModel(
        table: table ?? this.table,
        reservations: reservations ?? this.reservations,
      );
}
