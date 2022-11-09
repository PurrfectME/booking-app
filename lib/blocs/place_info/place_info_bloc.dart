import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:equatable/equatable.dart';

part 'place_info_event.dart';
part 'place_info_state.dart';

class PlaceInfoBloc extends Bloc<PlaceInfoEvent, PlaceInfoState> {
  final PlaceModel place;

  late List<TableModel> tables;

  PlaceInfoBloc({required this.place}) : super(PlaceInfoLoading()) {
    on<PlaceInfoEvent>((event, emit) async {
      if (event is PlaceInfoLoad) {
        emit(PlaceInfoLoading());

        await Future.delayed(Duration(seconds: 5));

        final data = [
          TableModel(id: 1, isFree: true, guestsCount: 6, config: null),
          TableModel(id: 2, isFree: false, guestsCount: 2, config: null),
          TableModel(id: 3, isFree: false, guestsCount: 3, config: null),
          TableModel(id: 4, isFree: true, guestsCount: 6, config: null)
        ];

        tables = List.from(data);

        emit(PlaceInfoLoaded(tables));
      } else if (event is PlaceTableReserve) {
        // api call
        // final response = await api.reserveTable(id: event.id)

        // if ok
        // if (response.status == 200)
        if (true) {
          final tableIndex = tables.indexWhere((table) => table.id == event.id);
          if (tableIndex > -1) {
            tables[tableIndex] = tables[tableIndex].copyWith(isFree: false);
          }
          emit(PlaceTableReserveSuccess(id: event.id));
        } else {
          // emit(Place``)
        }
        emit(PlaceInfoLoaded(tables));
      }
    });
  }
}
