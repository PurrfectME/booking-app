import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_category_model.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class SubCategoryModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  int id;

  @HiveField(1)
  @JsonKey(name: 'name')
  String name;

  SubCategoryModel({
    required this.id,
    required this.name,
  });
}
