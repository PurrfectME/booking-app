import 'dart:convert';

class UpdatePlaceRequest {
  int id;
  String name;
  int logo;
  String description;
  List<int> gallery;
  UpdatePlaceRequest({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.gallery,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'description': description,
      'gallery': gallery,
    };
  }

  factory UpdatePlaceRequest.fromMap(Map<String, dynamic> map) {
    return UpdatePlaceRequest(
        id: map['id'] as int,
        name: map['name'] as String,
        logo: map['logo'] as int,
        description: map['description'] as String,
        gallery: List<int>.from(
          (map['gallery'] as List<int>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory UpdatePlaceRequest.fromJson(String source) =>
      UpdatePlaceRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
