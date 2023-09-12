// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/local/ingredient_model.dart';

import '../db/tag.dart';

class DishModel {
  int id;

  String name;

  double price;

  List<IngredientModel> ingredients;

  List<Tag> tags;

  String description;

  String mediaId;

  DishModel({
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.tags,
    required this.description,
    required this.mediaId,
  });

  DishModel copyWith({
    int? id,
    String? name,
    double? price,
    List<IngredientModel>? ingredients,
    List<Tag>? tags,
    String? description,
    String? mediaId,
  }) =>
      DishModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        ingredients: ingredients ?? this.ingredients,
        tags: tags ?? this.tags,
        description: description ?? this.description,
        mediaId: mediaId ?? this.mediaId,
      );
}
