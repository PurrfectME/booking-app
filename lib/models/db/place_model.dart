import 'dart:convert';

import 'package:booking_app/models/models.dart';

class PlaceModel {
  int id;
  String name;
  String description;
  int logo;
  //TODO: у заведения только одно фото
  List<int> gallery;
  int updateDate;
  List<TableModel?> tables;

  PlaceModel(this.id, this.name, this.description, this.gallery, this.logo,
      this.updateDate, this.tables);

  List<Object?> get props =>
      [id, name, description, gallery, logo, updateDate, tables];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'gallery': gallery,
      'updateDate': updateDate,
      // 'tables': tables.map((x) => x.toMap()).toList(),
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
        map['id'] as int,
        map['name'] as String,
        map['description'] as String,
        List<int>.from((map['gallery'] as List<int>)),
        map['logo'] as int,
        map['updateDate'] as int, []);
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
