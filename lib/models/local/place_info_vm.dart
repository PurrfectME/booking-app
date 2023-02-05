// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:booking_app/models/local/table_vm.dart';
import 'package:flutter/material.dart';

class PlaceInfoViewModel {
  List<TableViewModel> tables;
  Image logo;
  PlaceInfoViewModel(
    this.tables,
    this.logo,
  );

  PlaceInfoViewModel copyWith({
    List<TableViewModel>? table,
    Image? logo,
  }) {
    return PlaceInfoViewModel(
      table ?? tables,
      logo ?? this.logo,
    );
  }
}
