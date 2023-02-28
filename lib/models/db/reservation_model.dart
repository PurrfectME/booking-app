// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReservationModel {
  int? id;
  int placeId;
  int tableId;
  int userId;
  int start;
  int end;
  int guests;
  ReservationModel({
    this.id,
    required this.placeId,
    required this.tableId,
    required this.userId,
    required this.start,
    required this.end,
    required this.guests,
  });

  ReservationModel copyWith({
    int? id,
    int? placeId,
    int? tableId,
    int? userId,
    int? start,
    int? end,
    int? guests,
  }) =>
      ReservationModel(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        tableId: tableId ?? this.tableId,
        userId: userId ?? this.userId,
        start: start ?? this.start,
        end: end ?? this.end,
        guests: guests ?? this.guests,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'placeId': placeId,
        'tableId': tableId,
        'userId': userId,
        'start': start,
        'end': end,
        'guests': guests,
      };

  factory ReservationModel.fromMap(Map<String, dynamic> map) =>
      ReservationModel(
        id: map['id'] != null ? map['id'] as int : null,
        placeId: map['placeId'] as int,
        tableId: map['tableId'] as int,
        userId: map['userId'] as int,
        start: map['start'] as int,
        end: map['end'] as int,
        guests: map['guests'] as int,
      );

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
