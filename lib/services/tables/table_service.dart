import 'package:booking_app/api/api.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/models.dart';
import 'package:sprintf/sprintf.dart';

class TableService {
  static TableService? _instance;

  factory TableService() => _instance ??= TableService._();

  TableService._();

  Future<List<GetAvailableTable>> getReservations(int placeId) async {
    var response =
        await Api().dio.get(sprintf(Constants.getReservations, [placeId]));

    return List<GetAvailableTable>.from((response.data as List)
        .map((reservation) => GetAvailableTable.fromJson(reservation)));
  }
}
