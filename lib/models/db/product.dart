import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 8)
class Product extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String type;

  Product({
    required this.name,
    required this.amount,
    required this.type,
  });
}
