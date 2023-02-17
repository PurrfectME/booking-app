// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_positional_boolean_parameters
import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';

class TableReservationViewModel {
  TableModel table;
  int? from;
  int? to;
  bool isReservedByUser;
  String placeName;
  List<Image> images;

  TableReservationViewModel(
    this.table,
    this.from,
    this.to,
    this.isReservedByUser,
    this.placeName,
    this.images,
  );

  TableReservationViewModel copyWith({
    TableModel? table,
    int? from,
    int? to,
    bool? isReservedByUser,
    String? placeName,
    List<Image>? images,
  }) =>
      TableReservationViewModel(
        table ?? this.table,
        from ?? this.from,
        to ?? this.to,
        isReservedByUser ?? this.isReservedByUser,
        placeName ?? this.placeName,
        images ?? this.images,
      );
}
