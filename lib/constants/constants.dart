import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static const String baseUrl = 'localhost';
  static const String getPlaces = 'places?update_date=%s';
  static const String getReservations = 'place/%i/tables';
  static const String reserveTable = 'place/%i/table/%i';
  static const String getUserReservations = 'profile/tables';
  static const String signIn = 'signin';
  static const String setUserName = 'profile';

  static const String updatePlace = 'profile/places/%i';
  static const String createTable = 'profile/places/%i/tables';
  static const String updateTable = 'profile/places/%i/tables/%i';
  static const String deleteTable = 'profile/places/%i/tables/%i';

  static const String getBookedTables = 'profile/places/%i/manage';

  static const Color mainPurple = Color.fromARGB(255, 104, 0, 185);
}

enum ProductMeasure { Killos }
