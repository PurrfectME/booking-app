// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/models/models.dart';

class ReservationViewModel {
  //TODO: edit here to model with images
  TableModel table;
  List<ReservationModel> reservations;
  UserModel? user;
  ReservationViewModel(
      {required this.table, required this.reservations, required this.user});

  ReservationViewModel copyWith(
          {TableModel? table,
          List<ReservationModel>? reservations,
          UserModel? user}) =>
      ReservationViewModel(
          table: table ?? this.table,
          reservations: reservations ?? this.reservations,
          user: user ?? this.user);
}
