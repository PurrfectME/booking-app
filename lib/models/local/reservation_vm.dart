// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/screens/screens.dart';
import 'package:equatable/equatable.dart';

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
  final ReservationStatus status;

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
          status: status ?? this.status);

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
        status
      ];
}
