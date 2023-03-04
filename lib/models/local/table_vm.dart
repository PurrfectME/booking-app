// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:booking_app/models/db/table_model.dart';

class TableViewModel extends Equatable {
  final TableModel table;
  final List<Uint8List> imagesBytes;

  const TableViewModel(
    this.table,
    this.imagesBytes,
  );

  TableViewModel copyWith({
    TableModel? table,
    List<Uint8List>? imagesBytes,
  }) =>
      TableViewModel(
        table ?? this.table,
        imagesBytes ?? this.imagesBytes,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'table': table.toMap(),
        'imagesBytes': imagesBytes,
      };

  factory TableViewModel.fromMap(Map<String, dynamic> map) => TableViewModel(
        TableModel.fromMap(map['table'] as Map<String, dynamic>),
        (map['imagesBytes'] as List<List<int>>)
            .map(Uint8List.fromList)
            .toList(),
      );

  String toJson() => json.encode(toMap());

  factory TableViewModel.fromJson(String source) =>
      TableViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [table, imagesBytes];
}
