// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class ReservationModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  int? id;

  @HiveField(1)
  @JsonKey(name: 'placeId')
  int placeId;

  @HiveField(2)
  @JsonKey(name: 'tableId')
  int tableId;

  @HiveField(3)
  @JsonKey(name: 'userId')
  int? userId;

  @HiveField(4)
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;

  @HiveField(5)
  @JsonKey(name: 'name')
  String? name;

  @HiveField(6)
  @JsonKey(name: 'start')
  int start;

  @HiveField(7)
  @JsonKey(name: 'end')
  int end;

  @HiveField(8)
  @JsonKey(name: 'guests')
  int guests;

  @HiveField(9)
  @JsonKey(name: 'excludeReshuffle')
  bool excludeReshuffle;

  @HiveField(10)
  @JsonKey(name: 'comment')
  String? comment;

  @HiveField(11)
  @JsonKey(name: 'status')
  int status;

  ReservationModel(
      {required this.id,
      required this.placeId,
      required this.tableId,
      required this.userId,
      required this.phoneNumber,
      required this.name,
      required this.start,
      required this.end,
      required this.guests,
      required this.excludeReshuffle,
      required this.comment,
      required this.status});

  ReservationModel copyWith({
    int? id,
    int? placeId,
    int? tableId,
    int? userId,
    String? phoneNumber,
    String? name,
    int? start,
    int? end,
    int? guests,
    bool? isOpened,
    bool? isCancelled,
    bool? excludeReshuffle,
    String? comment,
    int? status,
  }) =>
      ReservationModel(
          id: id ?? this.id,
          placeId: placeId ?? this.placeId,
          tableId: tableId ?? this.tableId,
          userId: userId ?? this.userId,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          name: name ?? this.name,
          start: start ?? this.start,
          end: end ?? this.end,
          guests: guests ?? this.guests,
          excludeReshuffle: excludeReshuffle ?? this.excludeReshuffle,
          comment: comment ?? this.comment,
          status: status ?? this.status);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'placeId': placeId,
        'tableId': tableId,
        'userId': userId,
        'phoneNumber': phoneNumber,
        'name': name,
        'start': start,
        'end': end,
        'guests': guests,
        'excludeReshuffle': excludeReshuffle ? 1 : 0,
        'comment': comment,
        'status': status,
      };

  factory ReservationModel.fromMap(Map<String, dynamic> map) =>
      ReservationModel(
        id: map['id'] != null ? map['id'] as int : null,
        placeId: map['placeId'] as int,
        tableId: map['tableId'] as int,
        userId: map['userId'] != null ? map['userId'] as int : null,
        phoneNumber:
            map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
        name: map['name'] != null ? map['name'] as String : null,
        start: map['start'] as int,
        end: map['end'] as int,
        guests: map['guests'] as int,
        excludeReshuffle: map['excludeReshuffle'] == 1,
        comment: map['comment'] != null ? map['comment'] as String : null,
        status: map['status'] as int,
      );

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
