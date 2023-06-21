// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginStart extends AuthEvent {
  final String email;
  final String password;
  const LoginStart({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegistrationLoad extends AuthEvent {}

class RegistrationStart extends AuthEvent {
  final String email;
  final String password;
  const RegistrationStart({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
