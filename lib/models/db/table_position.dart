import 'package:hive/hive.dart';

part 'table_position.g.dart';

@HiveType(typeId: 5)
class TablePosition extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int tableId;

  @HiveField(2)
  int placeId;

  @HiveField(3)
  double x;

  @HiveField(4)
  double y;

  @HiveField(5)
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
