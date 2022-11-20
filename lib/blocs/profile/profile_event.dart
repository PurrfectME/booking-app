part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class AddProfileName extends ProfileEvent {
  final String name;

  const AddProfileName(this.name);

  @override
  List<Object> get props => [name];
}
