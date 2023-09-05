import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/kitchen_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'kitchen_event.dart';
part 'kitchen_state.dart';

class KitchenBloc extends Bloc<KitchenEvent, KitchenState> {
  KitchenBloc() : super(KitchenLoading()) {
    on<KitchenEvent>((event, emit) async {
      if (event is KitchenLoad) {
        emit(KitchenLoading());

        final kitchenData = await _getKitchenData();

        emit(KitchenLoaded(kitchenData: kitchenData));
      } else if (event is CreateKitchenItem) {
        await HiveProvider.createKitchenItem(Kitchen(
            id: 0,
            name: event.kitchen.name,
            amount: event.kitchen.amount,
            date: event.kitchen.date,
            user: event.kitchen.user));

        final kitchenData = await _getKitchenData();

        emit(KitchenLoaded(kitchenData: kitchenData));
      } else {
        emit(const KitchenError(error: 'ОШИБКА КУХНИ'));
      }
    });
  }

  Future<List<KitchenModel>> _getKitchenData() async {
    final kitchen = await HiveProvider.getKitchenData();
    final kitchenData = kitchen
        .map((e) => KitchenModel(
            id: e.id,
            name: e.name,
            amount: e.amount,
            date: e.date,
            user: e.user))
        .toList();

    return kitchenData;
  }
}
