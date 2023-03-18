import 'package:bloc/bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';

part 'archive_event.dart';
part 'archive_state.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  ArchiveBloc() : super(ArchiveLoading()) {
    on<ArchiveEvent>((event, emit) async {
      if (event is ArchiveLoad) {
        final archived =
            await DbProvider.db.getArchivedReservations(event.placeId);

        // emit(ArchiveLoaded(archived));
      }
    });
  }
}
