// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:booking_app/models/local/table_reservation_vm.dart';
import 'package:flutter/material.dart';

class PlaceInfoViewModel {
  int placeId;
  List<TableReservationViewModel> tables;
  Image logo;
  String placeName;
  PlaceInfoViewModel({
    required this.placeId,
    required this.tables,
    required this.logo,
    required this.placeName,
  });

  PlaceInfoViewModel copyWith({
    int? placeId,
    List<TableReservationViewModel>? tables,
    Image? logo,
    String? placeName,
  }) {
    return PlaceInfoViewModel(
      placeId: placeId ?? this.placeId,
      tables: tables ?? this.tables,
      logo: logo ?? this.logo,
      placeName: placeName ?? this.placeName,
    );
  }
}
