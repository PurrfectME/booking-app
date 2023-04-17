// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booking_app/models/models.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PlaceModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  @HiveField(2)
  @JsonKey(name: 'description')
  final String description;

  @HiveField(3)
  @JsonKey(name: 'logoId')
  final int logoId;

  @HiveField(4)
  @JsonKey(name: 'base64Logo')
  final String? base64Logo;

  @HiveField(5)
  @JsonKey(name: 'updateDate')
  final int updateDate;

  @HiveField(6)
  @JsonKey(name: 'tables')
  final List<TableModel> tables;

  PlaceModel(this.id, this.name, this.description, this.logoId, this.base64Logo,
      this.updateDate, this.tables);

  PlaceModel copyWith({
    int? id,
    String? name,
    String? description,
    int? logoId,
    String? base64Logo,
    int? updateDate,
    List<TableModel>? tables,
  }) =>
      PlaceModel(
        id ?? this.id,
        name ?? this.name,
        description ?? this.description,
        logoId ?? this.logoId,
        base64Logo ?? this.base64Logo,
        updateDate ?? this.updateDate,
        tables ?? this.tables,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'description': description,
        'logoId': logoId,
        'base64Logo': base64Logo,
        'updateDate': updateDate,
      };

  factory PlaceModel.fromMap(Map<String, dynamic> map) => PlaceModel(
      map['id'] as int,
      map['name'] as String,
      map['description'] as String,
      map['logoId'] as int,
      map['base64Logo'] as String?,
      map['updateDate'] as int, []);

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
