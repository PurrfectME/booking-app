import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginStart) {
        emit(LoginLoading());

        await Future.delayed(Duration(seconds: 2));

        emit(LoginSuccess());
      }
    });
  }
}
