// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'table_position.g.dart';

@HiveType(typeId: 5)
class TablePosition extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int number;

  @HiveField(2)
  double x;

  @HiveField(3)
  double y;

  @HiveField(4)
  int guests;

  @HiveField(5)
  int vip;

  TablePosition({
    required this.id,
    required this.number,
    required this.x,
    required this.y,
    required this.guests,
    required this.vip,
  });
}
