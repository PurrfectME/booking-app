import 'package:booking_app/models/db/user_model.dart';
import 'package:booking_app/providers/db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'extra_info_event.dart';
part 'extra_info_state.dart';

class ExtraInfoBloc extends Bloc<ExtraInfoEvent, ExtraInfoState> {
  ExtraInfoBloc() : super(ExtraInfoLoading()) {
    on<ExtraInfoEvent>((event, emit) async {
      if (event is ExtraInfoLoad) {
        emit(ExtraInfoLoading());

        emit(ExtraInfoLoaded(event.user));
      } else if (event is UpdateProfileName) {
        // call post: /profile
        // final result = await DbProvider.db.updateUser(event.user);

        emit(ExtraInfoUpdated());
      }
    });
  }
}
