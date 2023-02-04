import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:booking_app/models/db/table_model.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final List<TableModel> tables;

  TablesBloc({required this.tables}) : super(TablesLoading()) {
    on<TablesEvent>((event, emit) {
      if (event is TablesLoad) {
        emit(TablesLoading());

        emit(TablesLoaded(tables));
      }
    });
  }
}
