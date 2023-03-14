// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booking_app/models/models.dart';
import 'package:equatable/equatable.dart';

class UserReservationModel extends Equatable {
  final UserModel? user;
  final ReservationModel reservation;

  const UserReservationModel({
    required this.user,
    required this.reservation,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'user': user?.toMap(),
        'reservations': reservation.toMap(),
      };

  factory UserReservationModel.fromMap(Map<String, dynamic> map) =>
      UserReservationModel(
        user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
        reservation: ReservationModel.fromMap(
            map['reservations'] as Map<String, dynamic>),
      );

  String toJson() => json.encode(toMap());

  factory UserReservationModel.fromJson(String source) =>
      UserReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  // TODO: implement props
  List<Object?> get props => [user, reservation];
}
