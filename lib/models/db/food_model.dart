import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class FoodModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  int id;

  @HiveField(1)
  @JsonKey(name: 'name')
  String name;

  @HiveField(2)
  @JsonKey(name: 'price')
  double price;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
  });
}
