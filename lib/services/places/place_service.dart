import 'package:booking_app/api/api.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/models/request/update_place.dart';
import 'package:sprintf/sprintf.dart';

class PlaceService {
  static PlaceService? _instance;

  factory PlaceService() => _instance ??= PlaceService._();

  PlaceService._();

  Future<List<GetPlaceResponse>> getAllPlaces(DateTime updateDate) async {
    final response =
        await Api().dio.get<String>(sprintf(Constants.getPlaces, [updateDate]));

    return List<GetPlaceResponse>.from((response.data as List)
        .map<GetPlaceResponse>(
            (dynamic place) => GetPlaceResponse.fromJson(place as String)));
  }

  Future updatePlace(UpdatePlaceRequest request) async {
    final response = await Api().dio.put<String>(
        sprintf(Constants.updatePlace, [request.id]),
        data: request.toJson());

    return response;
  }
}
