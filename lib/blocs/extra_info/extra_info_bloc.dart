import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'extra_info_event.dart';
part 'extra_info_state.dart';

class ExtraInfoBloc extends Bloc<ExtraInfoEvent, ExtraInfoState> {
  ExtraInfoBloc() : super(ExtraInfoInitial()) {
    on<ExtraInfoEvent>((event, emit) {
      if (event is AddProfileName) {
        emit(ExtraInfoLoading());

        // call post: /profile

        emit(ExtraInfoSuccess());
      }
    });
  }
}
