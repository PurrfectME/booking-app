// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TableModel extends Equatable {
  final int id;
  final int number;
  final int guests;
  final int placeId;

  const TableModel(this.id, this.number, this.guests, this.placeId);

  @override
  List<Object?> get props => [id, number, guests, placeId];

  TableModel copyWith({
    int? id,
    int? number,
    List<int>? images,
    int? guests,
    int? placeId,
  }) =>
      TableModel(
        id ?? this.id,
        number ?? this.number,
        guests ?? this.guests,
        placeId ?? this.placeId,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'number': number,
        'guests': guests,
        'placeId': placeId,
      };

  factory TableModel.fromMap(Map<String, dynamic> map) => TableModel(
        map['id'] as int,
        map['number'] as int,
        map['guests'] as int,
        map['placeId'] as int,
      );

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
