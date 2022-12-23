import 'package:booking_app/api/api.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/request/user.dart';

class ProfileService {
  static ProfileService? _instance;

  factory ProfileService() => _instance ??= ProfileService._();

  ProfileService._();

  Future setUsername(UserRequest request) async {
    final response =
        await Api().dio.post(Constants.setUserName, data: request.toJson());

    return response.statusCode;
  }
}
