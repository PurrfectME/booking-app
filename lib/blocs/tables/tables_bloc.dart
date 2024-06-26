import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/table_vm.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/services/services.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final int placeId;

  late List<TableViewModel> tables;

  TablesBloc({
    required this.placeId,
  }) : super(TablesLoading()) {
    // tables = List<TableViewModel>.from(initialTables);

    on<TablesEvent>((event, emit) async {
      if (event is TablesLoad) {
        emit(TablesLoading());

        tables = List<TableViewModel>.from(
            (await DbProvider.db.getTables(placeId))
                .map<TableViewModel>((e) => TableViewModel(e, const [])));

        final tableImages = await DbProvider.db
            .getTableImages(tables.map((e) => e.table.id).toList());

        //TODO: better performance when sorted tableImages, availableTables?
        // tableImages.sort((a, b) => a.tableId.compareTo(b.tableId));

        //TODO: optimize here

        if (tableImages.isNotEmpty) {
          final tempTables = List<TableViewModel>.from(tables);
          tables.forEachIndexed((table, index) {
            final imagesModel =
                tableImages.where((x) => x.tableId == table.table.id).toList();

            tempTables[index] = table.copyWith(
                imagesBytes:
                    List.from(imagesModel.map<Uint8List>((e) => e.imageBytes)));
          });
          tables = tempTables;
        }

        emit(TablesLoaded(tables));
      }
    });
  }
}
