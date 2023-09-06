import 'package:hive/hive.dart';

part 'table_position.g.dart';

@HiveType(typeId: 5)
class TablePosition extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int tableId;

  @HiveField(2)
  double x;

  @HiveField(3)
  double y;

  @HiveField(4)
  int color;

  TablePosition(
      {required this.id,
      required this.tableId,
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
        x: x ?? this.x,
        y: y ?? this.y,
        color: color ?? this.color,
      );
}
