// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservations_bloc.dart';

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

class ReservationsLoad extends ReservationsEvent {
  final List<TableModel> tables;
  const ReservationsLoad({
    required this.tables,
  });
}
