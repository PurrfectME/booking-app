// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table_position.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class TablePosition extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  int id;

  @HiveField(1)
  @JsonKey(name: 'tableId')
  int tableId;

  @HiveField(2)
  @JsonKey(name: 'placeId')
  int placeId;

  @HiveField(3)
  @JsonKey(name: 'x')
  double x;

  @HiveField(4)
  @JsonKey(name: 'y')
  double y;

  @HiveField(5)
  @JsonKey(name: 'color')
  int color;

  TablePosition(
      {required this.id,
      required this.tableId,
      required this.placeId,
      required this.x,
      required this.y,
      required this.color});

  TablePosition copyWith({
    int? id,
    int? tableId,
    int? placeId,
    double? x,
    double? y,
    int? color,
  }) =>
      TablePosition(
        id: id ?? this.id,
        tableId: tableId ?? this.tableId,
        placeId: placeId ?? this.placeId,
        x: x ?? this.x,
        y: y ?? this.y,
        color: color ?? this.color,
      );
}
