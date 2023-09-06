import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:booking_app/screens/tables_scheme/widgets/table_position_wrapper.dart';
import 'package:equatable/equatable.dart';

part 'edit_scheme_event.dart';
part 'edit_scheme_state.dart';

class EditSchemeBloc extends Bloc<EditSchemeEvent, EditSchemeState> {
  List<TableModel> availableTables = [];
  List<TablePosition> droppedTables = [];

  EditSchemeBloc() : super(EditSchemeLoading()) {
    on<EditSchemeEvent>((event, emit) async {
      if (event is EditSchemeLoad) {
        emit(EditSchemeLoading());

        droppedTables = await HiveProvider.getTablePositions();

        availableTables = (await HiveProvider.getTables())
          ..removeWhere(
              (x) => (droppedTables.map((e) => e.number)).contains(x.number));

        emit(EditSchemeLoaded(
          droppedTables: TablePositionWrapper.wrap(droppedTables),
          availableTables: availableTables,
        ));
      } else if (event is AddTable) {
        droppedTables.add(TablePosition(
          id: 0,
          number: event.position.number,
          x: event.x,
          y: event.y - 55,
          guests: event.position.guests,
          vip: event.position.vip,
        ));
        availableTables.removeWhere((x) => x.number == event.position.number);

        emit(EditSchemeLoaded(
          droppedTables: TablePositionWrapper.wrap(droppedTables),
          availableTables: availableTables,
        ));
      } else if (event is DragTable) {
        final tableIndex =
            droppedTables.indexWhere((x) => x.number == event.position.number);

        droppedTables[tableIndex] = TablePosition(
          id: 0,
          x: event.x,
          y: event.y - 55, //magic number? ПАШОЛ НАХУЙ!!!!
          number: event.position.number,
          vip: 0,
          guests: event.position.guests,
        );

        emit(EditSchemeLoaded(
          droppedTables: TablePositionWrapper.wrap(droppedTables),
          availableTables: availableTables,
        ));
      } else if (event is SaveScheme) {
        await HiveProvider.removeTablesScheme();
        await HiveProvider.addTablesScheme(droppedTables);

        emit(SchemeSaved());

        emit(EditSchemeLoaded(
          droppedTables: TablePositionWrapper.wrap(droppedTables),
          availableTables: availableTables,
        ));
      }
    });
  }
}
