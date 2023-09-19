// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UsersLoad extends UserEvent {}

class AddUser extends UserEvent {}

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

class SaveUsers extends UserEvent {}

class RemoveUser extends UserEvent {
  final User user;
  const RemoveUser({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
