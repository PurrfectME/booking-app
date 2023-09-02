import 'package:hive/hive.dart';

part 'tag_model.g.dart';

@HiveType(typeId: 9)
class TagModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;
  TagModel({
    required this.id,
    required this.name,
  });

  TagModel copyWith({
    int? id,
    String? name,
  }) =>
      TagModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );
}
