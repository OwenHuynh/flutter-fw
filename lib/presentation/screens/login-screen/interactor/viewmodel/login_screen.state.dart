import 'package:equatable/equatable.dart';
import 'package:flutter_fm/shared/command/page_command.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class LoginScreenState extends Equatable {
  const LoginScreenState(
      {this.pageCommand,
      required this.pageState,
      required this.email,
      required this.password});

  factory LoginScreenState.initial() {
    return const LoginScreenState(
        pageState: PageState.initial, email: "", password: "");
  }

  final PageCommand? pageCommand;

  final PageState pageState;

  final String email;

  final String password;

  @override
  List<Object?> get props => [pageCommand, pageState, email, password];

  LoginScreenState copyWith(
      {PageCommand? pageCommand,
      PageState? pageState,
      String? email,
      String? password}) {
    return LoginScreenState(
      pageCommand: pageCommand,
      pageState: pageState ?? this.pageState,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
