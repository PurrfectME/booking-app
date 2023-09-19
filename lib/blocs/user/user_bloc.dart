import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/role.dart';
import 'package:booking_app/models/db/user.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  List<User> users = [];
  List<Role> roles = [];

  UserBloc() : super(UsersLoading()) {
    on<UserEvent>((event, emit) async {
      final a = await HiveProvider.getRoles();
      if (a.isEmpty) {
        await HiveProvider.createRole("Админ");
        await HiveProvider.createRole("Официант");
        await HiveProvider.createRole("Шеф");
      }

      if (event is UsersLoad) {
        emit(UsersLoading());

        users = await HiveProvider.getUsers();
        roles = await HiveProvider.getRoles();

        emit(UsersLoaded(users: users, roles: roles));
      } else if (event is AddUser) {
        await HiveProvider.createUser(User(id: -1, role: "Админ", name: "имя"));

        users = await HiveProvider.getUsers();

        emit(UsersLoaded(users: users, roles: roles));
      } else if (event is EditUser) {
        users.firstWhere((x) => x.id == event.id)
          ..role = event.role
          ..name = event.name;

        emit(UsersLoading());

        emit(UsersLoaded(users: users, roles: roles));
      } else if (event is SaveUsers) {
        for (var i = 0; i < users.length; i++) {
          await users[i].save();
        }

        emit(UsersSaved());

        emit(UsersLoaded(users: users, roles: roles));
      } else if (event is RemoveUser) {
        await event.user.delete();

        users = await HiveProvider.getUsers();

        emit(UsersLoaded(users: users, roles: roles));
      } else {
        emit(const UsersError(error: 'Ошибка'));
      }
    });
  }
}
