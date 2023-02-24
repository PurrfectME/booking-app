part of 'extra_info_bloc.dart';

abstract class ExtraInfoEvent extends Equatable {
  const ExtraInfoEvent();

  @override
  List<Object> get props => [];
}

class ExtraInfoLoad extends ExtraInfoEvent {
  final UserModel user;

  const ExtraInfoLoad({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateProfileName extends ExtraInfoEvent {
  final UserModel user;

  const UpdateProfileName({required this.user});

  @override
  List<Object> get props => [user];
}
