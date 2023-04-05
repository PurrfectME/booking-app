// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:booking_app/screens/screens.dart';

class ReservationViewModel extends Equatable {
  final int id;
  final int placeId;
  final int tableId;
  final int tableNumber;
  final String name;
  final int guests;
  final String phoneNumber;
  final DateTime start;
  final DateTime end;
  final ReservationStatus? status;
  final String? comment;
  final bool excludeReshuffle;
  final bool isOpened;
  final bool isCancelled;

  const ReservationViewModel({
    required this.id,
    required this.placeId,
    required this.tableId,
    required this.tableNumber,
    required this.name,
    required this.guests,
    required this.phoneNumber,
    required this.start,
    required this.end,
    required this.status,
    required this.comment,
    required this.excludeReshuffle,
    required this.isCancelled,
    required this.isOpened,
  });

  ReservationViewModel copyWith({
    int? id,
    int? placeId,
    int? tableId,
    int? tableNumber,
    String? name,
    int? guests,
    String? phoneNumber,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
    String? comment,
    bool? excludeReshuffle,
    bool? isCancelled,
    bool? isOpened,
  }) =>
      ReservationViewModel(
          id: id ?? this.id,
          placeId: placeId ?? this.placeId,
          tableId: tableId ?? this.tableId,
          tableNumber: tableNumber ?? this.tableNumber,
          name: name ?? this.name,
          guests: guests ?? this.guests,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          start: start ?? this.start,
          end: end ?? this.end,
          status: status ?? this.status,
          comment: comment ?? this.comment,
          excludeReshuffle: excludeReshuffle ?? this.excludeReshuffle,
          isCancelled: isCancelled ?? this.isCancelled,
          isOpened: isOpened ?? this.isOpened);

  @override
  List<Object?> get props => [
        id,
        placeId,
        tableId,
        tableNumber,
        name,
        phoneNumber,
        guests,
        start,
        end,
        status,
        comment,
        excludeReshuffle,
        isCancelled,
        isOpened,
      ];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'placeId': placeId,
        'tableId': tableId,
        'tableNumber': tableNumber,
        'name': name,
        'guests': guests,
        'phoneNumber': phoneNumber,
        'start': start.millisecondsSinceEpoch,
        'end': end.millisecondsSinceEpoch,
        // 'status': status.toMap(),
        'comment': comment,
        'excludeReshuffle': excludeReshuffle,
        'isCancelled': isCancelled,
        'isOpened': isOpened,
      };

  factory ReservationViewModel.fromMap(Map<String, dynamic> map) =>
      ReservationViewModel(
        id: map['id'] as int,
        placeId: map['placeId'] as int,
        tableId: map['tableId'] as int,
        tableNumber: map['tableNumber'] as int,
        name: map['name'] as String,
        guests: map['guests'] as int,
        phoneNumber: map['phoneNumber'] as String,
        start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(map['end'] as int),
        status: null,
        comment: map['comment'] != null ? map['comment'] as String : null,
        excludeReshuffle: map['excludeReshuffle'] as bool,
        isCancelled: map['isCancelled'] == 1,
        isOpened: map['isOpened'] == 1,
      );

  String toJson() => json.encode(toMap());

  factory ReservationViewModel.fromJson(String source) =>
      ReservationViewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
