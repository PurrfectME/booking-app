import 'package:hive/hive.dart';

part 'order_item.g.dart';

@HiveType(typeId: 13)
class OrderItem extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int createDate;

  @HiveField(2)
  String note;

  @HiveField(3)
  String waiter;

  @HiveField(4)
  int guest;

  OrderItem({
    required this.id,
    required this.createDate,
    required this.note,
    required this.waiter,
    required this.guest,
  });
}
