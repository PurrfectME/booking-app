part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginStart extends LoginEvent {
  final String phoneNumber;

  const LoginStart(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}