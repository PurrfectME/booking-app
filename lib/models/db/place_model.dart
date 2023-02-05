// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booking_app/models/models.dart';

class PlaceModel {
  int id;
  String name;
  String description;
  int logoId;
  String? base64Logo;
  int updateDate;
  List<TableModel> tables;

  PlaceModel(this.id, this.name, this.description, this.logoId, this.base64Logo,
      this.updateDate, this.tables);

  List<Object?> get props =>
      [id, name, description, logoId, base64Logo, updateDate, tables];

  PlaceModel copyWith({
    int? id,
    String? name,
    String? description,
    int? logoId,
    String? base64Logo,
    int? updateDate,
    List<TableModel>? tables,
  }) {
    return PlaceModel(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      logoId ?? this.logoId,
      base64Logo ?? this.base64Logo,
      updateDate ?? this.updateDate,
      tables ?? this.tables,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'logoId': logoId,
      'base64Logo': base64Logo,
      'updateDate': updateDate,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
        map['id'] as int,
        map['name'] as String,
        map['description'] as String,
        map['logoId'] as int,
        map['base64Logo'] as String?,
        map['updateDate'] as int, []);
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
