import 'dart:convert';

import 'package:booking_app/api/api.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/models.dart';
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
}
