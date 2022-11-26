part of 'extra_info_bloc.dart';

abstract class ExtraInfoState extends Equatable {
  const ExtraInfoState();

  @override
  List<Object> get props => [];
}

class ExtraInfoInitial extends ExtraInfoState {}

class ExtraInfoLoading extends ExtraInfoState {}

class ExtraInfoError extends ExtraInfoState {
  final String error;

  const ExtraInfoError(this.error);

  @override
  List<Object> get props => [error];
}

class ExtraInfoSuccess extends ExtraInfoState {}
