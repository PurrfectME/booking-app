part of 'archive_bloc.dart';

abstract class ArchiveState extends Equatable {
  const ArchiveState();

  @override
  List<Object> get props => [];
}

class ArchiveLoading extends ArchiveState {}

class ArchiveLoaded extends ArchiveState {
  final List<ReservationViewModel> data;

  const ArchiveLoaded(this.data);

  @override
  List<Object> get props => [data];
}
