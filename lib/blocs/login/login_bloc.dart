import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/user_model.dart';
import 'package:booking_app/models/request/signin.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/services/auth/auth_service.dart';
import 'package:equatable/equatable.dart';

import '../../providers/hive_db.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginStart) {
        emit(LoginLoading());

        // final response =
        //     await AuthService().signIn(SignInRequest(login: event.login));

        var user = UserModel(
          login: event.login,
          firstSignIn: true,
          accessToken: 'response.accessToken',
          refreshToken: 'response.refreshToken',
        );

        // user = user.copyWith(id: await HiveProvider.createUser(user));
        if (user.firstSignIn) {
          user = user.copyWith(id: await HiveProvider.createUser(user));
        }

        // final a = await HiveProvider.getUsers();

        emit(LoginSuccess(user: user));
      }
    });
  }
}
