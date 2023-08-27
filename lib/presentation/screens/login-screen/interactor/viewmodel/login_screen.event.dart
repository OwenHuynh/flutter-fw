import 'package:equatable/equatable.dart';

abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object?> get props => [];
}

class OnChangeEmail extends LoginScreenEvent {
  const OnChangeEmail({required this.email});

  final String email;

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'OnChangeEmail { email: $email }';
}

class OnChangePassword extends LoginScreenEvent {
  const OnChangePassword({required this.password});

  final String password;

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'OnChangePassword { password: $password }';
}

class OnResetState extends LoginScreenEvent {
  const OnResetState();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'OnResetState';
}
