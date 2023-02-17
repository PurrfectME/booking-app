import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/table_vm.dart';
import 'package:booking_app/providers/db.dart';
import 'package:booking_app/services/image/image_service.dart';
import 'package:equatable/equatable.dart';

part 'update_table_event.dart';
part 'update_table_state.dart';

class UpdateTableBloc extends Bloc<UpdateTableEvent, UpdateTableState> {
  UpdateTableBloc() : super(UpdateTableLoading()) {
    on<UpdateTableEvent>(
      (event, emit) async {
        if (event is UpdateTableLoad) {
          emit(UpdateTableLoading());

          // final place = await DbProvider.db.getPlaceById(event.id);

          // final tableImages =
          //     await DbProvider.db.getTableImages([event.data.table.id!]);

          //TODO: better performance when sorted tableImages, availableTables?
          // tableImages.sort((a, b) => a.tableId.compareTo(b.tableId));

          //TODO: optimize here
          // if (tableImages.isNotEmpty) {
          //   for (var imageModel in tableImages) {
          //     event.data.images.add(
          //         ImageService.imageFromBase64String(imageModel.base64Images));
          //   }
          // tableImages[0].base64Images.split(',').map((e) =>
          //     event.data.images.add(ImageService.imageFromBase64String(e)));

          // final imageToAdd = ImageService.imageFromBase64String(tableImages
          //     .firstWhere(
          //         (tableImage) => event.data.table.id == tableImage.tableId)
          //     .base64Images);

          // event.data.images.add(imageToAdd);
          // }

          // if (tableImages.isNotEmpty) {
          //   for (var i = 0; i < tables.length; i++) {
          //     final imageModelIndex = tableImages.indexWhere(
          //         (tableImage) => tables[i].table.id == tableImage.tableId);

          //     if (imageModelIndex != -1) {
          //       final allTableImages =
          //           tableImages[imageModelIndex].base64Images.split(',');

          //       for (var imageString in allTableImages) {
          //         tables[i]
          //             .images
          //             .add(ImageService.imageFromBase64String(imageString));
          //       }
          //     }
          //   }
          // }

          emit(UpdateTableLoaded(event.data));
        } else if (event is UpdateTable) {
          final imagesAsString =
              event.data.imagesBytes!.map(ImageService.base64String).join(',');

          await DbProvider.db.updateTable(event.data.table, imagesAsString);

          emit(UpdateTableSuccess(event.data.table.placeId));
        }
      },
    );
  }
}
