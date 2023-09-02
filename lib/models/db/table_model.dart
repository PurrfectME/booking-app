import 'dart:convert';
import 'package:hive/hive.dart';

part 'table_model.g.dart';

@HiveType(typeId: 4)
class TableModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int number;

  @HiveField(2)
  int guests;

  @HiveField(3)
  int placeId;

  TableModel({
    required this.id,
    required this.number,
    required this.guests,
    required this.placeId,
  });

  TableModel copyWith({
    int? id,
    int? number,
    int? guests,
    int? placeId,
  }) =>
      TableModel(
        id: id ?? this.id,
        number: number ?? this.number,
        guests: guests ?? this.guests,
        placeId: placeId ?? this.placeId,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'number': number,
        'guests': guests,
        'placeId': placeId,
      };

  factory TableModel.fromMap(Map<String, dynamic> map) => TableModel(
        id: map['id'] as int,
        number: map['number'] as int,
        guests: map['guests'] as int,
        placeId: map['placeId'] as int,
      );

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
