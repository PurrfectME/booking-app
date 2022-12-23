import 'package:booking_app/constants/constants.dart';
import 'package:dio/dio.dart';

class Api {
  final dio = createDio();
  // final tokenDio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  // @override
  // void onRequest(
  //     RequestOptions options, RequestInterceptorHandler handler) async {
  //   var accessToken = await TokenRepository().getAccessToken();

  //   if (accessToken != null) {
  //     var expiration = await TokenRepository().getAccessTokenRemainingTime();

  //     if (expiration.inSeconds < 60) {
  //       dio.interceptors.requestLock.lock();

  //       // Call the refresh endpoint to get a new token
  //       await UserService().refresh().then((response) async {
  //         await TokenRepository().persistAccessToken(response.accessToken);
  //         accessToken = response.accessToken;
  //       }).catchError((error, stackTrace) {
  //         handler.reject(error, true);
  //       }).whenComplete(() => dio.interceptors.requestLock.unlock());
  //     }

  //     options.headers['Authorization'] = 'Bearer $accessToken';
  //   }

  //   return handler.next(options);
  // }
}
