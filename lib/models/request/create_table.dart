import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateTableRequest {
  int number;
  int image;
  int guests;
  CreateTableRequest({
    required this.number,
    required this.image,
    required this.guests,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'image': image,
      'guests': guests,
    };
  }

  factory CreateTableRequest.fromMap(Map<String, dynamic> map) {
    return CreateTableRequest(
      number: map['number'] as int,
      image: map['image'] as int,
      guests: map['guests'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateTableRequest.fromJson(String source) =>
      CreateTableRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
