// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TableImageModel {
  int? id;
  int tableId;
  Uint8List imageBytes;
  TableImageModel({
    this.id,
    required this.tableId,
    required this.imageBytes,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'tableId': tableId,
        'imageBytes': imageBytes,
      };

  factory TableImageModel.fromMap(Map<String, dynamic> map) => TableImageModel(
        id: map['id'] != null ? map['id'] as int : null,
        tableId: map['tableId'] as int,
        imageBytes: Uint8List.fromList(map['imageBytes'] as List<int>),
      );

  String toJson() => json.encode(toMap());

  factory TableImageModel.fromJson(String source) =>
      TableImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TableImageModel copyWith({
    int? id,
    int? tableId,
    Uint8List? imageBytes,
  }) {
    return TableImageModel(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      imageBytes: imageBytes ?? this.imageBytes,
    );
  }
}
