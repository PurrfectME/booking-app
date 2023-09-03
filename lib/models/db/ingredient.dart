import 'package:hive/hive.dart';
part 'ingredient.g.dart';

@HiveType(typeId: 9)
class Ingredient extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String amount;
  Ingredient({
    required this.id,
    required this.name,
    required this.amount,
  });
}
