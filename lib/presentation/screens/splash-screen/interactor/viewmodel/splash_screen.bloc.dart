import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/presentation/screens/splash-screen/interactor/viewmodel/page_commands.dart';
import 'package:flutter_fm/presentation/screens/splash-screen/interactor/viewmodel/splash_screen.event.dart';
import 'package:flutter_fm/presentation/screens/splash-screen/interactor/viewmodel/splash_screen.state.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenState.initial()) {
    on<OnInitialEvent>(_onInitialEvent);
    on<ClearSplashScreenPageCommand>((_, emit) => emit(state.copyWith()));
  }

  FutureOr<void> _onInitialEvent(
      OnInitialEvent event, Emitter<SplashScreenState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));

    await Future.delayed(const Duration(seconds: 3));

    emit(state.copyWith(
        pageState: PageState.success, pageCommand: ShowLoginScreen()));
  }
}
