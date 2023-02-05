// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TableImageModel {
  int id;
  int tableId;
  String images;
  String base64Images;
  TableImageModel({
    required this.id,
    required this.tableId,
    required this.images,
    required this.base64Images,
  });

  TableImageModel copyWith({
    int? id,
    int? tableId,
    String? images,
    String? base64Images,
  }) {
    return TableImageModel(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      images: images ?? this.images,
      base64Images: base64Images ?? this.base64Images,
    );
  }

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
      id: map['id'] as int,
      tableId: map['tableId'] as int,
      images: map['images'] as String,
      base64Images: map['base64Images'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableImageModel.fromJson(String source) =>
      TableImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
