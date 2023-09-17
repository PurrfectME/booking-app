// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;
  final List<Role> roles;
  const UsersLoaded({
    required this.users,
    required this.roles,
  });

  @override
  List<Object> get props => [users, roles];
}

class UsersError extends UserState {
  final String error;
  const UsersError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class UsersSaved extends UserState {}
