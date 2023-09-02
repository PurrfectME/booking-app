import 'dart:convert';

import 'package:booking_app/models/db/product_model.dart';
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
  //TODOL add TagModel
  HiveList<String> tags;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
  });

  FoodModel copyWith({
    int? id,
    String? name,
    double? price,
    HiveList<ProductModel>? ingredients,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'ingredients': ingredients.toMap(),
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      ingredients: map['ingredients'] as HiveList<ProductModel>,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
