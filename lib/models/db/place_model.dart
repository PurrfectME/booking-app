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
  int id;

  @HiveField(1)
  @JsonKey(name: 'name')
  String name;

  @HiveField(2)
  @JsonKey(name: 'description')
  String description;

  @HiveField(3)
  @JsonKey(name: 'logoId')
  int logoId;

  @HiveField(4)
  @JsonKey(name: 'base64Logo')
  String? base64Logo;

  @HiveField(5)
  @JsonKey(name: 'updateDate')
  int updateDate;

  @HiveField(6)
  @JsonKey(name: 'tables')
  List<TableModel> tables;

  @HiveField(7)
  @JsonKey(name: 'ownerId')
  int ownerId;

  PlaceModel(this.id, this.name, this.description, this.logoId, this.base64Logo,
      this.updateDate, this.tables, this.ownerId);

  PlaceModel copyWith({
    int? id,
    String? name,
    String? description,
    int? logoId,
    String? base64Logo,
    int? updateDate,
    List<TableModel>? tables,
    int? ownerId,
  }) =>
      PlaceModel(
          id ?? this.id,
          name ?? this.name,
          description ?? this.description,
          logoId ?? this.logoId,
          base64Logo ?? this.base64Logo,
          updateDate ?? this.updateDate,
          tables ?? this.tables,
          ownerId ?? this.ownerId);
}
