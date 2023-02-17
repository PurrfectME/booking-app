import 'package:booking_app/api/api.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/models/request/create_table.dart';
import 'package:booking_app/models/response/get_user_reservation.dart';
import 'package:sprintf/sprintf.dart';

class TableService {
  static TableService? _instance;

  factory TableService() => _instance ??= TableService._();

  TableService._();

  Future<List<GetReservationResponse>> getReservations(int placeId) async {
    final response = await Api()
        .dio
        .get<String>(sprintf(Constants.getReservations, [placeId]));

    return List<GetReservationResponse>.from((response.data as List)
        .map<GetReservationResponse>((dynamic reservation) =>
            GetReservationResponse.fromJson(reservation as String)));
  }

  Future reserverTable(ReserveTableRequest request) async {
    final response = await Api().dio.post<String>(
        sprintf(Constants.reserveTable, [request.placeId, request.tableId]),
        data: request.toJson());

    return response;
  }

  Future<List<GetUserReservationResponse>> getUserReservations() async {
    final response = await Api().dio.get<String>(Constants.getUserReservations);

    return List<GetUserReservationResponse>.from((response.data as List)
        .map<GetUserReservationResponse>((dynamic reservation) =>
            GetUserReservationResponse.fromJson(reservation as String)));
  }

  Future createTable(int placeId, CreateTableRequest request) async {
    final response = await Api().dio.post<String>(
        sprintf(Constants.createTable, [placeId]),
        data: request.toJson());

    return response;
  }

  Future updateTable(
      int placeId, int tableId, CreateTableRequest request) async {
    final response = await Api().dio.put<String>(
        sprintf(Constants.updateTable, [placeId, tableId]),
        data: request.toJson());

    return response;
  }

  Future deleteTable(int placeId, int tableId) async {
    final response = await Api()
        .dio
        .delete<String>(sprintf(Constants.updateTable, [placeId, tableId]));

    return response;
  }

  Future getBookedTables(int placeId, int tableId) async {
    final response = await Api()
        .dio
        .delete<String>(sprintf(Constants.updateTable, [placeId, tableId]));

    return response;
  }
}
