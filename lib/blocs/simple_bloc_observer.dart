import 'package:bloc/bloc.dart';
import 'package:palestine_console/palestine_console.dart';

class SimpleBlocObserver extends BlocObserver {
  static const fullPrint = true;

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // ignore: avoid_print
    Print.yellow(
      fullPrint ? event.toString() : event.runtimeType.toString(),
      name: bloc.runtimeType.toString(),
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // ignore: avoid_print
    Print.magenta(
      fullPrint
          ? transition.toString()
          : 'from: ${transition.currentState.runtimeType} to ${transition.nextState.runtimeType}',
      name: '${bloc.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // ignore: avoid_print
    Print.red(error.toString(), name: bloc.runtimeType.toString());
  }
}
