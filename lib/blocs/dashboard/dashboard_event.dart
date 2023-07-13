// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardLoad extends DashboardEvent {
  final int userId;
  const DashboardLoad({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class CreatePlace extends DashboardEvent {
  final int ownerId;
  final String name;
  final String city;
  final String address;

  const CreatePlace({
    required this.ownerId,
    required this.name,
    required this.city,
    required this.address,
  });

  @override
  List<Object> get props => [ownerId, name, city, address];
}

class ChangeBookingType extends DashboardEvent {
  final int placeId;
  final int ownerId;
  const ChangeBookingType({required this.placeId, required this.ownerId});

  @override
  List<Object> get props => [placeId, ownerId];
}
