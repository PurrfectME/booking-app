class Constants {
  Constants._();

  static const String baseUrl = 'localhost';
  static const String getPlaces = 'places?update_date=%s';
  static const String getReservations = 'place/%i/tables';
  static const String reserveTable = 'place/%i/table/%i';
  static const String getUserReservations = 'profile/tables';
  static const String signIn = 'signin';
  static const String setUserName = 'profile';
}
