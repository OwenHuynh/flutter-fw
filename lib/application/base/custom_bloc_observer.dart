import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/shared/utils/utils.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    LoggerUtils.printInfoObject("BLOC-INFO", event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    LoggerUtils.printInfoObject("BLOC-INFO", change);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    LoggerUtils.printInfoObject("BLOC-INFO", bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    LoggerUtils.printErrorObject("BLOC-ERROR", error);
    super.onError(bloc, error, stackTrace);
  }
}
