import 'package:booking_app/models/db/product_model.dart';
import 'package:booking_app/models/db/tag.dart';
import 'package:hive/hive.dart';

part 'food_model.g.dart';

@HiveType(typeId: 6)
class FoodModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  HiveList<ProductModel> ingredients;

  @HiveField(4)
  HiveList<Tag> tags;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.tags,
  });

  FoodModel copyWith({
    int? id,
    String? name,
    double? price,
    HiveList<ProductModel>? ingredients,
    HiveList<Tag>? tags,
  }) =>
      FoodModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        ingredients: ingredients ?? this.ingredients,
        tags: tags ?? this.tags,
      );
}
