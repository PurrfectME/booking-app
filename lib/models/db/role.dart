import 'package:hive/hive.dart';

part 'role.g.dart';

@HiveType(typeId: 15)
class Role extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  Role({
    required this.id,
    required this.name,
  });
}
