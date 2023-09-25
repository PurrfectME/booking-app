// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UsersLoad extends UserEvent {}

class AddUser extends UserEvent {}

class AddRole extends UserEvent {}

class EditUser extends UserEvent {
  final int id;
  final String role;
  final String name;
  const EditUser({
    required this.id,
    required this.role,
    required this.name,
  });

  @override
  List<Object> get props => [id, role, name];
}

class EditRole extends UserEvent {
  final int id;
  final String name;
  const EditRole({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}

class SaveUsers extends UserEvent {}

class RemoveUser extends UserEvent {
  final User user;
  const RemoveUser({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class RemoveRole extends UserEvent {
  final Role role;
  const RemoveRole({
    required this.role,
  });

  @override
  List<Object> get props => [role];
}
