import 'dart:convert';

class GetPlaceResponse {
  int id;
  String name;
  String description;
  int logoId;
  List<int> gallery;
  int updateDate;
  List<TableResponse>? tables;

  GetPlaceResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.logoId,
    required this.gallery,
    required this.updateDate,
    this.tables,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'description': description,
        'logoId': logoId,
        'gallery': gallery,
        'updateDate': updateDate,
        'tables': tables?.map((x) => x.toMap()).toList(),
      };

  factory GetPlaceResponse.fromMap(Map<String, dynamic> map) =>
      GetPlaceResponse(
        id: map['id'] as int,
        name: map['name'] as String,
        description: map['description'] as String,
        logoId: map['logoId'] as int,
        gallery: List<int>.from(map['gallery'] as List<int>),
        updateDate: map['updateDate'] as int,
        tables: map['tables'] != null
            ? List<TableResponse>.from(
                (map['tables'] as List<int>).map<TableResponse?>(
                  (x) => TableResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  String toJson() => json.encode(toMap());

  factory GetPlaceResponse.fromJson(String source) =>
      GetPlaceResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TableResponse {
  int id;
  int number;
  int image;
  int guests;
  int placeId;
  TableResponse(
    this.id,
    this.number,
    this.image,
    this.guests,
    this.placeId,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'number': number,
        'image': image,
        'guests': guests,
        'placeId': placeId,
      };

  factory TableResponse.fromMap(Map<String, dynamic> map) => TableResponse(
        map['id'] as int,
        map['number'] as int,
        map['image'] as int,
        map['guests'] as int,
        map['placeId'] as int,
      );

  String toJson() => json.encode(toMap());

  factory TableResponse.fromJson(String source) =>
      TableResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
