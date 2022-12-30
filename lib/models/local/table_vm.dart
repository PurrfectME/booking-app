// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/models.dart';

class TableViewModel {
  TableModel table;
  int? from;
  int? to;
  bool isReservedByUser;
  String placeName;
  TableViewModel(
      this.table, this.from, this.to, this.isReservedByUser, this.placeName);

  TableViewModel copyWith({
    TableModel? table,
    int? from,
    int? to,
    bool? isReservedByUser,
  }) {
    return TableViewModel(table ?? this.table, from ?? this.from, to ?? this.to,
        isReservedByUser ?? this.isReservedByUser, placeName);
  }
}
