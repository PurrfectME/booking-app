// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_positional_boolean_parameters
import 'package:booking_app/models/models.dart';
import 'package:flutter/foundation.dart';

class TableReservationViewModel {
  TableModel table;
  int? from;
  int? to;
  bool isReservedByUser;
  List<Uint8List> imagesBytes;

  TableReservationViewModel(
    this.table,
    this.from,
    this.to,
    this.isReservedByUser,
    this.imagesBytes,
  );

  TableReservationViewModel copyWith({
    TableModel? table,
    int? from,
    int? to,
    bool? isReservedByUser,
    String? placeName,
    List<Uint8List>? imagesBytes,
  }) =>
      TableReservationViewModel(
        table ?? this.table,
        from ?? this.from,
        to ?? this.to,
        isReservedByUser ?? this.isReservedByUser,
        imagesBytes ?? this.imagesBytes,
      );
}
