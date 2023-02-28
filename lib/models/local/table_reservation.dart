// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/models/db/user_model.dart';

class TableReservationModel {
  final UserModel user;
  final ReservationModel reservation;
  TableReservationModel({
    required this.user,
    required this.reservation,
  });
}
