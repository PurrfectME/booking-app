// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booking_app/models/db/table_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TableViewModel extends Equatable {
  final TableModel table;
  final List<Image> images;
  final List<Uint8List> imagesBytes;

  const TableViewModel(
    this.table,
    this.images,
    this.imagesBytes,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'table': table.toMap(),
        'image': images,
      };

  factory TableViewModel.fromMap(Map<String, dynamic> map) => TableViewModel(
        TableModel.fromMap(map['table'] as Map<String, dynamic>),
        List<Image>.from(map['images'] as List<Image>),
        map['imagesBytes'] as List<Uint8List>,
      );

  String toJson() => json.encode(toMap());

  factory TableViewModel.fromJson(String source) =>
      TableViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [table, images, imagesBytes];

  TableViewModel copyWith({
    TableModel? table,
    List<Image>? images,
    List<Uint8List>? imagesBytes,
  }) =>
      TableViewModel(
        table ?? this.table,
        images ?? this.images,
        imagesBytes ?? this.imagesBytes,
      );
}
