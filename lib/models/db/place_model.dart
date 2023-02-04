import 'dart:convert';

import 'package:booking_app/models/models.dart';

class PlaceModel {
  int id;
  String name;
  String description;
  int logoId;
  int updateDate;
  List<TableModel> tables;

  PlaceModel(this.id, this.name, this.description, this.logoId, this.updateDate,
      this.tables);

  List<Object?> get props =>
      [id, name, description, logoId, updateDate, tables];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'logoId': logoId,
      'updateDate': updateDate,
      // 'tables': tables.map((x) => x.toMap()).toList(),
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
        map['id'] as int,
        map['name'] as String,
        map['description'] as String,
        map['logoId'] as int,
        map['updateDate'] as int, []);
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
