import 'package:booking_app/api/api.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/request/signin.dart';
import 'package:booking_app/models/response/signin.dart';

class AuthService {
  static AuthService? _instance;

  factory AuthService() => _instance ??= AuthService._();

  AuthService._();

  Future<SignInResponse> signIn(SignInRequest request) async {
    //TODO: handle errors
    final response =
        await Api().dio.post<String>(Constants.signIn, data: request.toJson());

    return SignInResponse.fromJson(response.data!);
  }
}
