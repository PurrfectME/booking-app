part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginStart extends LoginEvent {
  final String login;

  const LoginStart(this.login);

  @override
  List<Object> get props => [login];
}
