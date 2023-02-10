// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TableImageModel {
  int? id;
  int tableId;
  String images;
  String base64Images;
  TableImageModel(
    this.id,
    this.tableId,
    this.images,
    this.base64Images,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tableId': tableId,
      'images': images,
      'base64Images': base64Images,
    };
  }

  factory TableImageModel.fromMap(Map<String, dynamic> map) {
    return TableImageModel(
      map['id'] as int,
      map['tableId'] as int,
      map['images'] as String,
      map['base64Images'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableImageModel.fromJson(String source) =>
      TableImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TableImageModel copyWith({
    int? id,
    int? tableId,
    String? images,
    String? base64Images,
  }) {
    return TableImageModel(
      id ?? this.id,
      tableId ?? this.tableId,
      images ?? this.images,
      base64Images ?? this.base64Images,
    );
  }
}
