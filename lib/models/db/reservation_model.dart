// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReservationModel {
  int? id;
  int tableId;
  int start;
  int end;
  int guests;
  ReservationModel({
    this.id,
    required this.tableId,
    required this.start,
    required this.end,
    required this.guests,
  });

  ReservationModel copyWith({
    int? id,
    int? tableId,
    int? start,
    int? end,
    int? guests,
  }) =>
      ReservationModel(
        id: id ?? this.id,
        tableId: tableId ?? this.tableId,
        start: start ?? this.start,
        end: end ?? this.end,
        guests: guests ?? this.guests,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'tableId': tableId,
        'start': start,
        'end': end,
        'guests': guests,
      };

  factory ReservationModel.fromMap(Map<String, dynamic> map) =>
      ReservationModel(
        id: map['id'] != null ? map['id'] as int : null,
        tableId: map['tableId'] as int,
        start: map['start'] as int,
        end: map['end'] as int,
        guests: map['guests'] as int,
      );

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
