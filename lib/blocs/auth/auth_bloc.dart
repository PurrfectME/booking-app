import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/user_model.dart';
import 'package:booking_app/models/request/signin.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/services/auth/auth_service.dart';
import 'package:equatable/equatable.dart';

import '../../providers/hive_db.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginStart) {
        emit(LoginLoading());

        // final response =
        //     await AuthService().signIn(SignInRequest(login: event.login));

        final user = await HiveProvider.getUserByEmail(event.email);

        if (user == null) {
          emit(const LoginError('Такого профиля не существует'));
        } else {
          emit(LoginSuccess(user: user));
        }
      } else if (event is RegistrationStart) {
        emit(RegistrationLoading());

        final user = UserModel(
          email: event.email,
          accessToken: 'response.accessToken',
          refreshToken: 'response.refreshToken',
        );

        final createdUser = await HiveProvider.createUser(user);

        emit(RegistrationSuccess(user: createdUser));
      } else if (event is RegistrationLoad) {
        emit(RegistrationLoading());

        emit(RegistrationLoaded());
      }
    });
  }
}
