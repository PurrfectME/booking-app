// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class ReservationViewModel extends Equatable {
  final int id;
  final int tableId;
  final int tableNumber;
  final String name;
  final int guests;
  final String phoneNumber;
  final DateTime start;
  final DateTime end;
  const ReservationViewModel({
    required this.id,
    required this.tableId,
    required this.tableNumber,
    required this.name,
    required this.guests,
    required this.phoneNumber,
    required this.start,
    required this.end,
  });

  ReservationViewModel copyWith({
    int? id,
    int? tableId,
    int? tableNumber,
    String? name,
    int? guests,
    String? phoneNumber,
    DateTime? start,
    DateTime? end,
  }) =>
      ReservationViewModel(
        id: id ?? this.id,
        tableId: tableId ?? this.tableId,
        tableNumber: tableNumber ?? this.tableNumber,
        name: name ?? this.name,
        guests: guests ?? this.guests,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        start: start ?? this.start,
        end: end ?? this.end,
      );

  @override
  List<Object?> get props =>
      [id, tableId, tableNumber, name, phoneNumber, guests, start, end];
}
