// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserReservationModel {
  int? id;
  int placeId;
  int tableId;
  int start;
  int end;
  int updateDate;
  int guests;
  UserReservationModel({
    this.id,
    required this.placeId,
    required this.tableId,
    required this.start,
    required this.end,
    required this.updateDate,
    required this.guests,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'placeId': placeId,
        'tableId': tableId,
        'start': start,
        'end': end,
        'updateDate': updateDate,
        'guests': guests,
      };

  factory UserReservationModel.fromMap(Map<String, dynamic> map) =>
      UserReservationModel(
        id: map['id'] != null ? map['id'] as int : null,
        placeId: map['placeId'] as int,
        tableId: map['tableId'] as int,
        start: map['start'] as int,
        end: map['end'] as int,
        updateDate: map['updateDate'] as int,
        guests: map['guests'] as int,
      );

  String toJson() => json.encode(toMap());

  factory UserReservationModel.fromJson(String source) =>
      UserReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserReservationModel copyWith({
    int? id,
    int? placeId,
    int? tableId,
    int? start,
    int? end,
    int? updateDate,
    int? guests,
  }) =>
      UserReservationModel(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        tableId: tableId ?? this.tableId,
        start: start ?? this.start,
        end: end ?? this.end,
        updateDate: updateDate ?? this.updateDate,
        guests: guests ?? this.guests,
      );
}
