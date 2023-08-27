import 'package:equatable/equatable.dart';
import 'package:flutter_fm/shared/command/page_command.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class EmployeeEditorScreenState extends Equatable {
  const EmployeeEditorScreenState({
    this.position,
    this.pageCommand,
    required this.pageState,
    this.ageErrorMessage,
    required this.age,
    this.nameErrorMessage,
    required this.name,
    this.emailErrorMessage,
    required this.email,
  });

  factory EmployeeEditorScreenState.initial() {
    return const EmployeeEditorScreenState(
        pageState: PageState.initial,
        age: "",
        nameErrorMessage: null,
        name: "",
        emailErrorMessage: null,
        email: "");
  }

  final int? position;
  final PageCommand? pageCommand;
  final PageState pageState;

  final String? nameErrorMessage;
  final String name;

  final String? emailErrorMessage;
  final String email;

  final String? ageErrorMessage;
  final String age;

  @override
  List<Object?> get props => [
        position,
        pageCommand,
        pageState,
        ageErrorMessage,
        age,
        nameErrorMessage,
        name,
        emailErrorMessage,
        email
      ];

  EmployeeEditorScreenState copyWith({
    int? position,
    PageCommand? pageCommand,
    PageState? pageState,
    String? age,
    String? ageErrorMessage,
    String? nameErrorMessage,
    String? name,
    String? emailErrorMessage,
    String? email,
  }) {
    return EmployeeEditorScreenState(
      position: position ?? this.position,
      pageCommand: pageCommand,
      pageState: pageState ?? this.pageState,
      ageErrorMessage: ageErrorMessage ?? this.ageErrorMessage,
      age: age ?? this.age,
      nameErrorMessage: nameErrorMessage,
      name: name ?? this.name,
      emailErrorMessage: emailErrorMessage,
      email: email ?? this.email,
    );
  }
}
