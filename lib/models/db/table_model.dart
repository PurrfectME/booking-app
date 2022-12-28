import 'dart:convert';

import 'package:equatable/equatable.dart';

class TableModel extends Equatable {
  int? id;
  int number;
  int image;
  int guests;
  int placeId;

  TableModel(this.id, this.number, this.image, this.guests, this.placeId);

  @override
  List<Object?> get props => [id, number, image, guests, placeId];

  TableModel copyWith(
      {int? id, int? number, int? image, int? guests, int? placeId}) {
    return TableModel(id ?? this.id, number ?? this.number, image ?? this.image,
        guests ?? this.guests, placeId ?? this.placeId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'image': image,
      'guests': guests,
      'placeId': placeId
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      map['id'] as int,
      map['number'] as int,
      map['image'] as int,
      map['guests'] as int,
      map['placeId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
