import 'package:hive/hive.dart';

part 'tag.g.dart';

@HiveType(typeId: 9)
class Tag extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;
  Tag({
    required this.id,
    required this.name,
  });

  Tag copyWith({
    int? id,
    String? name,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
      );
}
