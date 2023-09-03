import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 8)
class Product extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int amount;

  @HiveField(3)
  int placeId;

  Product({
    required this.id,
    required this.name,
    required this.amount,
    required this.placeId,
  });

  Product copyWith({
    int? id,
    String? name,
    int? amount,
    int? placeId,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        placeId: placeId ?? this.placeId,
      );
}
