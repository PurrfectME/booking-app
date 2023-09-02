import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 8)
class ProductModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int amount;

  @HiveField(3)
  int placeId;

  ProductModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.placeId,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    int? amount,
    int? placeId,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        placeId: placeId ?? this.placeId,
      );
}
