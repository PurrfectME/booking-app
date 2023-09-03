import 'package:booking_app/models/db/ingredient.dart';

import '../db/tag.dart';

class DishModel {
  int id;

  String name;

  double price;

  List<Ingredient>? ingredients;

  List<Tag>? tags;

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
}
