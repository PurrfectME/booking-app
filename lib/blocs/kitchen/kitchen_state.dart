// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'kitchen_bloc.dart';

class KitchenState extends Equatable {
  const KitchenState();

  @override
  List<Object> get props => [];
}

class KitchenLoading extends KitchenState {}

class KitchenLoaded extends KitchenState {
  final List<KitchenModel> kitchenData;
  const KitchenLoaded({
    required this.kitchenData,
  });

  @override
  List<Object> get props => [kitchenData];
}

class KitchenError extends KitchenState {
  final String error;
  const KitchenError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
