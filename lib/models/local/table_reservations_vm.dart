// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/models.dart';
import 'package:equatable/equatable.dart';

class TableReservationViewModel extends Equatable {
  final TableModel table;
  final List<UserReservationModel> reservations;
  const TableReservationViewModel({
    required this.table,
    required this.reservations,
  });

  TableReservationViewModel copyWith({
    TableModel? table,
    List<UserReservationModel>? reservations,
  }) =>
      TableReservationViewModel(
        table: table ?? this.table,
        reservations: reservations ?? this.reservations,
      );

  @override
  List<Object?> get props => [table, reservations];
}
