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
  int placeId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.placeId,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    int? placeId,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        placeId: placeId ?? this.placeId,
      );
}
