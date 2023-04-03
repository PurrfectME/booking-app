part of 'reservation_info_bloc.dart';

abstract class ReservationInfoState extends Equatable {
  const ReservationInfoState();

  @override
  List<Object> get props => [];
}

class ReservationInfoLoading extends ReservationInfoState {}
