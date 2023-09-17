// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 14)
class User extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String role;

  @HiveField(2)
  String name;
  User({
    required this.id,
    required this.role,
    required this.name,
  });

  User copyWith({
    int? id,
    String? role,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        role: role ?? this.role,
        name: name ?? this.name,
      );
}
