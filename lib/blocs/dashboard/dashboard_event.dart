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
