// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'archive_bloc.dart';

abstract class ArchiveEvent extends Equatable {
  const ArchiveEvent();

  @override
  List<Object> get props => [];
}

class ArchiveLoad extends ArchiveEvent {
  final int placeId;

  const ArchiveLoad({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}
