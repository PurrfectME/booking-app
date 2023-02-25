// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booking_app/models/models.dart';

class UserReservationsModel {
  final UserModel user;
  final List<ReservationModel> reservations;
  UserReservationsModel({
    required this.user,
    required this.reservations,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'reservation': reservations.map((x) => x.toMap()).toList(),
    };
  }

//TODO: remove this?
  factory UserReservationsModel.fromMap(Map<String, dynamic> map) =>
      UserReservationsModel(
        user: UserModel(
            id: map['userId'] as int,
            login: map['login'] as String,
            firstSignIn: map['firstSignIn'] as bool,
            accessToken: map['accessToken'] as String,
            refreshToken: map['refreshToken'] as String,
            name: map['name'] as String?),
        reservations: List<ReservationModel>.from(
          (map['reservation'] as List<int>).map<ReservationModel>(
            (x) => ReservationModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );

  String toJson() => json.encode(toMap());

  factory UserReservationsModel.fromJson(String source) =>
      UserReservationsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
