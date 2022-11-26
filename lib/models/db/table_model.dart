import 'dart:convert';

import 'package:equatable/equatable.dart';

class TableModel extends Equatable {
  int id;
  int number;
  int image;
  int guests;

  TableModel(this.id, this.number, this.image, this.guests);

  @override
  List<Object?> get props => [id, number, image, guests];

  TableModel copyWith({
    int? id,
    int? number,
    int? image,
    int? guests,
  }) {
    return TableModel(
      id ?? this.id,
      number ?? this.number,
      image ?? this.image,
      guests ?? this.guests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'image': image,
      'guests': guests,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      map['id'] as int,
      map['number'] as int,
      map['image'] as int,
      map['guests'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
