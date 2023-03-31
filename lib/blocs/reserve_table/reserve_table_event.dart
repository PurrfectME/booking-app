// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reserve_table_bloc.dart';

abstract class ReserveTableEvent extends Equatable {
  const ReserveTableEvent();

  @override
  List<Object> get props => [];
}

class ReserveTableLoad extends ReserveTableEvent {
  final int tableId;
  final int placeId;
  const ReserveTableLoad({
    required this.tableId,
    required this.placeId,
  });

  @override
  List<Object> get props => [tableId, placeId];
}

class AdminReserveTable extends ReserveTableEvent {
  final int placeId;
  final int tableId;
  final int guests;
  final DateTime start;
  final DateTime end;
  final String phoneNumber;
  final String name;
  final bool excludeReshuffle;
  const AdminReserveTable({
    required this.placeId,
    required this.tableId,
    required this.guests,
    required this.start,
    required this.end,
    required this.phoneNumber,
    required this.name,
    required this.excludeReshuffle,
  });

  @override
  List<Object> get props => [
        placeId,
        tableId,
        guests,
        start,
        end,
        phoneNumber,
        name,
        excludeReshuffle
      ];
}
