import 'package:booking_app/models/models.dart';
import 'package:hive/hive.dart';

part 'dish.g.dart';

@HiveType(typeId: 6)
class Dish extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  List<Product> ingredients;

  @HiveField(4)
  List<Tag> tags;

  @HiveField(5)
  String description;

  @HiveField(6)
  String mediaId;
  Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.tags,
    required this.description,
    required this.mediaId,
  });

  Dish copyWith({
    int? id,
    String? name,
    double? price,
    HiveList<Product>? ingredients,
    HiveList<Tag>? tags,
    String? description,
    String? mediaId,
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      ingredients: ingredients ?? this.ingredients,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      mediaId: mediaId ?? this.mediaId,
    );
  }
}
