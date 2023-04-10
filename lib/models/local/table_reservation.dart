// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/models.dart';
import 'package:equatable/equatable.dart';

class TableReservation extends Equatable {
  final TableModel table;
  final ReservationModel? reservation;
  const TableReservation({
    required this.table,
    required this.reservation,
  });

  TableReservation copyWith({
    TableModel? table,
    ReservationModel? reservation,
  }) =>
      TableReservation(
        table: table ?? this.table,
        reservation: reservation ?? this.reservation,
      );

  @override
  List<Object?> get props => [table, reservation];
}
