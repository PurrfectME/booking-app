part of 'extra_info_bloc.dart';

abstract class ExtraInfoEvent extends Equatable {
  const ExtraInfoEvent();

  @override
  List<Object> get props => [];
}

class AddProfileName extends ExtraInfoEvent {
  final String name;

  const AddProfileName(this.name);

  @override
  List<Object> get props => [name];
}
