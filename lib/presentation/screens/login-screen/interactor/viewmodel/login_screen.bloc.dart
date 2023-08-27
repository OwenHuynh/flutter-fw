import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/presentation/screens/login-screen/interactor/viewmodel/login_screen.event.dart';
import 'package:flutter_fm/presentation/screens/login-screen/interactor/viewmodel/login_screen.state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenState.initial()) {
    on<OnChangeEmail>(_onChangeEmail);
    on<OnChangePassword>(_onChangePassword);
    on<OnResetState>(_onResetState);
  }

  FutureOr<void> _onChangeEmail(
      OnChangeEmail event, Emitter<LoginScreenState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onChangePassword(
      OnChangePassword event, Emitter<LoginScreenState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onResetState(
      OnResetState event, Emitter<LoginScreenState> emit) {
    emit(state.copyWith(email: "", password: ""));
  }
}
