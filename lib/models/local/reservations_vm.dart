// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/db/table_model.dart';
import 'package:booking_app/models/local/table_vm.dart';

class ReservationViewModel {
  bool isReserved;
  //TODO: edit here to model with images
  TableModel table;
  int from;
  int to;
  ReservationViewModel({
    required this.isReserved,
    required this.table,
    required this.from,
    required this.to,
  });

  ReservationViewModel copyWith({
    bool? isReserved,
    TableModel? table,
    int? from,
    int? to,
  }) {
    return ReservationViewModel(
      isReserved: isReserved ?? this.isReserved,
      table: table ?? this.table,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}
