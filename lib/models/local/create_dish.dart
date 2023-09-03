import 'package:booking_app/models/local/ingredient_model.dart';

class CreateDishModel {
  String name;
  double price;
  List<String> tags;
  List<IngredientModel> ingredients;
  String description;
  String mediaId;
  CreateDishModel({
    required this.name,
    required this.price,
    required this.tags,
    required this.ingredients,
    required this.description,
    required this.mediaId,
  });
}
