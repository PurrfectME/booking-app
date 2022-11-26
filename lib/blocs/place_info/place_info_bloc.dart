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

        await Future.delayed(Duration(seconds: 2));

        final data = [
          TableModel(1, 2, 3, 4),
          TableModel(1, 2, 3, 4),
          TableModel(1, 2, 3, 4),
          TableModel(1, 2, 3, 4)
        ];

        tables = List.from(data);

        emit(PlaceInfoLoaded(tables));
      } else if (event is PlaceTableReserve) {
        // api call
        // final response = await api.reserveTable(id: event.id)

        // if ok
        // if (response.status == 200)
        if (true) {
          // final tableIndex = tables.indexWhere((table) => table.id == event.id);
          // if (tableIndex > -1) {
          //   tables[tableIndex] = tables[tableIndex].copyWith(isFree: false);
          // }
          emit(PlaceTableReserveSuccess(id: event.id));
        } else {
          // RESERVE ERROR IN MODal
        }
        emit(PlaceInfoLoaded(tables));
      }
    });
  }
}
