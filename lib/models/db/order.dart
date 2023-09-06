import 'package:booking_app/models/db/order_item.dart';
import 'package:hive/hive.dart';

part 'order.g.dart';

@HiveType(typeId: 12)
class Order extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int table;

  @HiveField(2)
  int openDate;

  @HiveField(3)
  int closeDate;

  @HiveField(4)
  List<OrderItem> items;

  @HiveField(5)
  int cardId;

  @HiveField(6)
  String administrator;

  @HiveField(7)
  int guests;

  Order({
    required this.id,
    required this.table,
    required this.openDate,
    required this.closeDate,
    required this.items,
    required this.cardId,
    required this.administrator,
    required this.guests,
  });
}
