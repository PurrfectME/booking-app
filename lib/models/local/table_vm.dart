// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:booking_app/models/db/table_model.dart';

class TableViewModel {
  TableModel table;
  List<Image> images;
  List<Uint8List>? imagesBytes;
  TableViewModel(
    this.table,
    this.images,
    this.imagesBytes,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'table': table.toMap(),
      'image': images,
    };
  }

  factory TableViewModel.fromMap(Map<String, dynamic> map) {
    return TableViewModel(
        TableModel.fromMap(map['table'] as Map<String, dynamic>),
        List<Image>.from((map['images'] as List<Image>)),
        map['imagesBytes'] as List<Uint8List>);
  }

  String toJson() => json.encode(toMap());

  factory TableViewModel.fromJson(String source) =>
      TableViewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
