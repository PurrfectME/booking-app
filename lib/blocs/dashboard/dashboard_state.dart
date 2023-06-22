// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final UserModel user;
  final List<PlaceModel> places;
  const DashboardLoaded({
    required this.user,
    required this.places,
  });

  @override
  List<Object> get props => [user, places];
}

class DashboardError extends DashboardState {
  final String error;
  const DashboardError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
