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
        await Api().dio.get(sprintf(Constants.getPlaces, [updateDate]));

    return List<GetPlaceResponse>.from((response.data as List)
        .map((place) => GetPlaceResponse.fromJson(place)));
  }

  Future updatePlace(UpdatePlaceRequest request) async {
    final response = await Api().dio.put(
        sprintf(Constants.updatePlace, [request.id]),
        data: request.toJson());

    return response;
  }
}
