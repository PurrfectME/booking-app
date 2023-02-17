// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:booking_app/models/local/table_reservation_vm.dart';
import 'package:flutter/material.dart';

class PlaceInfoViewModel {
  List<TableReservationViewModel> tables;
  Image logo;
  PlaceInfoViewModel(
    this.tables,
    this.logo,
  );

  PlaceInfoViewModel copyWith({
    List<TableReservationViewModel>? table,
    Image? logo,
  }) =>
      PlaceInfoViewModel(
        table ?? tables,
        logo ?? this.logo,
      );
}
