import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/table_vm.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/services/services.dart';
import 'package:equatable/equatable.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final int placeId;

  late List<TableViewModel> tables;

  TablesBloc({
    required this.placeId,
    required List<TableViewModel> initialTables,
  }) : super(TablesLoading()) {
    // tables = List<TableViewModel>.from(initialTables);

    on<TablesEvent>((event, emit) async {
      if (event is TablesLoad) {
        emit(TablesLoading());

        tables = List<TableViewModel>.from((await DbProvider.db
                .getTables(placeId))
            .map<TableViewModel>((e) => TableViewModel(e, const [], const [])));

        final tableImages = await DbProvider.db
            .getTableImages(tables.map((e) => e.table.id).toList());

        //TODO: better performance when sorted tableImages, availableTables?
        // tableImages.sort((a, b) => a.tableId.compareTo(b.tableId));

        //TODO: optimize here

        if (tableImages.isNotEmpty) {
          for (var i = 0; i < tables.length; i++) {
            final imageModelIndex = tableImages.indexWhere(
                (tableImage) => tables[i].table.id == tableImage.tableId);

            if (imageModelIndex != -1) {
              final allTableImages =
                  tableImages[imageModelIndex].base64Images.split(',');

              for (final imageString in allTableImages) {
                tables[i] = tables[i].copyWith(
                  images: List.from(tables[i].images)
                    ..add(ImageService.imageFromBase64String(imageString)),
                );
              }
            }
          }
        }

        emit(TablesLoaded(tables));
      }
    });
  }
}
