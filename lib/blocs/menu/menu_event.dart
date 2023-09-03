// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'menu_bloc.dart';

class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class MenuLoad extends MenuEvent {
  final int placeId;
  const MenuLoad({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}
