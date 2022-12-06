// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserReservationModel {
  int id;
  int placeId;
  int tableId;
  int from;
  int to;

  UserReservationModel(
    this.id,
    this.placeId,
    this.tableId,
    this.from,
    this.to,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'placeId': placeId,
      'tableId': tableId,
      'from': from,
      'to': to,
    };
  }

  factory UserReservationModel.fromMap(Map<String, dynamic> map) {
    return UserReservationModel(
      map['id'] as int,
      map['placeId'] as int,
      map['tableId'] as int,
      map['from'] as int,
      map['to'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReservationModel.fromJson(String source) =>
      UserReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
