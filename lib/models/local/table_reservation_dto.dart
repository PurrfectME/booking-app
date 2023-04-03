// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_positional_boolean_parameters
import 'package:booking_app/models/models.dart';
import 'package:flutter/foundation.dart';

class TableReservationDto {
  TableModel table;
  int? from;
  int? to;
  bool isReservedByUser;
  List<Uint8List> imagesBytes;

  TableReservationDto(
    this.table,
    this.from,
    this.to,
    this.isReservedByUser,
    this.imagesBytes,
  );

  TableReservationDto copyWith({
    TableModel? table,
    int? from,
    int? to,
    bool? isReservedByUser,
    String? placeName,
    List<Uint8List>? imagesBytes,
  }) =>
      TableReservationDto(
        table ?? this.table,
        from ?? this.from,
        to ?? this.to,
        isReservedByUser ?? this.isReservedByUser,
        imagesBytes ?? this.imagesBytes,
      );
}
