// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 7)
class CategoryModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  HiveList? subCategories;

  @HiveField(3)
  int placeId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.subCategories,
    required this.placeId,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    HiveList? subCategories,
    int? placeId,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        subCategories: subCategories ?? this.subCategories,
        placeId: placeId ?? this.placeId,
      );
}
