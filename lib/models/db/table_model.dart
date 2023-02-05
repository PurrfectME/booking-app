// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TableModel extends Equatable {
  int? id;
  int number;
  int guests;
  int placeId;

  TableModel(this.id, this.number, this.guests, this.placeId);

  @override
  List<Object?> get props => [id, number, guests, placeId];

  TableModel copyWith(
      {int? id, int? number, List<int>? images, int? guests, int? placeId}) {
    return TableModel(id ?? this.id, number ?? this.number,
        guests ?? this.guests, placeId ?? this.placeId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'guests': guests,
      'placeId': placeId,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      map['id'] != null ? map['id'] as int : null,
      map['number'] as int,
      map['guests'] as int,
      map['placeId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
