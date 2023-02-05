// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking_app/models/models.dart';

class TableViewModel {
  TableModel table;
  int? from;
  int? to;
  bool isReservedByUser;
  String placeName;
  List<Image> images;

  TableViewModel(this.table, this.from, this.to, this.isReservedByUser,
      this.placeName, this.images);

  TableViewModel copyWith({
    TableModel? table,
    int? from,
    int? to,
    bool? isReservedByUser,
    String? placeName,
    List<Image>? images,
  }) {
    return TableViewModel(
      table ?? this.table,
      from ?? this.from,
      to ?? this.to,
      isReservedByUser ?? this.isReservedByUser,
      placeName ?? this.placeName,
      images ?? this.images,
    );
  }
}
