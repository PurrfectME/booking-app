import 'package:hive/hive.dart';
part 'ingredient.g.dart';

@HiveType(typeId: 9)
class Ingredient extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String amount;
  Ingredient({
    required this.name,
    required this.amount,
  });
}
