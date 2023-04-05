// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booking_app/models/models.dart';
import 'package:equatable/equatable.dart';

class TableInfoViewModel extends Equatable {
  final TableModel table;
  final List<ReservationModel> reservations;
  const TableInfoViewModel({
    required this.table,
    required this.reservations,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'table': table.toMap(),
        'reservations': reservations.map((x) => x.toMap()).toList(),
      };

  factory TableInfoViewModel.fromMap(Map<String, dynamic> map) =>
      TableInfoViewModel(
        table: TableModel.fromMap(map['table'] as Map<String, dynamic>),
        reservations: List<ReservationModel>.from(
          (map['reservations'] as List<int>).map<ReservationModel>(
            (x) => ReservationModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );

  String toJson() => json.encode(toMap());

  factory TableInfoViewModel.fromJson(String source) =>
      TableInfoViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [table, reservations];
}
