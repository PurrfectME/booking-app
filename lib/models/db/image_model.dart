import 'dart:convert';

class ImageModel {
  int id;
  int tableId;
  List<String> images;
  List<String> base64Images;
  ImageModel({
    required this.id,
    required this.tableId,
    required this.images,
    required this.base64Images,
  });

  ImageModel copyWith({
    int? id,
    int? tableId,
    List<String>? images,
    List<String>? base64Images,
  }) {
    return ImageModel(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      images: images ?? this.images,
      base64Images: base64Images ?? this.base64Images,
    );
  }

  @override
  String toString() {
    return images.join(',');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tableId': tableId,
      'images': images,
      'base64Images': base64Images,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
        id: map['id'] as int,
        tableId: map['tableId'] as int,
        images: List<String>.from((map['images'] as List<String>)),
        base64Images: List<String>.from((map['base64Images'] as List<String>)));
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
