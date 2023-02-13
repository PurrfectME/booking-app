import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/table_vm.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/services/services.dart';
import 'package:equatable/equatable.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  TablesBloc() : super(TablesLoading()) {
    on<TablesEvent>((event, emit) async {
      if (event is TablesLoad) {
        emit(TablesLoading());

        event.tables ??= (await DbProvider.db.getTables(event.placeId!))
            .map((e) => TableViewModel(e, [], []))
            .toList();

        final tableImages = await DbProvider.db
            .getTableImages(event.tables!.map((e) => e.table.id!).toList());

        //TODO: better performance when sorted tableImages, availableTables?
        // tableImages.sort((a, b) => a.tableId.compareTo(b.tableId));

        //TODO: optimize here

        if (tableImages.isNotEmpty) {
          for (var i = 0; i < event.tables!.length; i++) {
            final imageModelIndex = tableImages.indexWhere((tableImage) =>
                event.tables![i].table.id == tableImage.tableId);

            if (imageModelIndex != -1) {
              final allTableImages =
                  tableImages[imageModelIndex].base64Images.split(',');

              for (var imageString in allTableImages) {
                event.tables![i].images
                    .add(ImageService.imageFromBase64String(imageString));
              }
            }
          }
        }

        emit(TablesLoaded(event.tables!));
      }
    });
  }
}
