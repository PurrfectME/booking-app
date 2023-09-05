// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'kitchen.g.dart';

@HiveType(typeId: 11)
class Kitchen extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double amount;

  @HiveField(3)
  int date;

  @HiveField(4)
  String user;

  Kitchen({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.user,
  });
}
