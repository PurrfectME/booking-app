import 'package:booking_app/api/api.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/models/response/get_user_reservation.dart';
import 'package:sprintf/sprintf.dart';

class TableService {
  static TableService? _instance;

  factory TableService() => _instance ??= TableService._();

  TableService._();

  Future<List<GetReservationResponse>> getReservations(int placeId) async {
    var response =
        await Api().dio.get(sprintf(Constants.getReservations, [placeId]));

    return List<GetReservationResponse>.from((response.data as List)
        .map((reservation) => GetReservationResponse.fromJson(reservation)));
  }

  Future reserverTable(ReserveTableRequest request) async {
    var response = await Api().dio.post(
        sprintf(Constants.reserveTable, [request.placeId, request.tableId]),
        data: request.toJson());

    return response;
  }

  Future<List<GetUserReservationResponse>> getUserReservations() async {
    var response = await Api().dio.get(Constants.getUserReservations);

    return List<GetUserReservationResponse>.from((response.data as List).map(
        (reservation) => GetUserReservationResponse.fromJson(reservation)));
  }
}
