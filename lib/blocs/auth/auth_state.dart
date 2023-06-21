// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginError extends AuthState {
  final String error;

  const LoginError(this.error);

  @override
  List<Object> get props => [error];
}

class LoginSuccess extends AuthState {
  final UserModel user;

  const LoginSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class RegistrationLoading extends AuthState {}

class RegistrationLoaded extends AuthState {}

class RegistrationSuccess extends AuthState {
  final UserModel user;
  const RegistrationSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class RegistrationError extends AuthState {
  final String error;
  const RegistrationError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
