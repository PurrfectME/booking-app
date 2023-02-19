// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:booking_app/models/local/table_reservation_vm.dart';

class PlaceInfoViewModel {
  List<TableReservationViewModel> tables;
  Image logo;
  String placeName;
  PlaceInfoViewModel({
    required this.tables,
    required this.logo,
    required this.placeName,
  });

  PlaceInfoViewModel copyWith({
    List<TableReservationViewModel>? tables,
    Image? logo,
    String? placeName,
  }) {
    return PlaceInfoViewModel(
      tables: tables ?? this.tables,
      logo: logo ?? this.logo,
      placeName: placeName ?? this.placeName,
    );
  }
}
