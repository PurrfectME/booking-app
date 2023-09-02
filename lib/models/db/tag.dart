// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

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
