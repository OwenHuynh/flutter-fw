import 'package:equatable/equatable.dart';

abstract class EmployeeEditorScreenEvent extends Equatable {
  const EmployeeEditorScreenEvent();

  @override
  List<Object?> get props => [];
}

class OnInitialEmployeeEditorScreenEvent extends EmployeeEditorScreenEvent {
  const OnInitialEmployeeEditorScreenEvent(
      {required this.age, required this.name, required this.email});

  final String age;
  final String name;
  final String email;

  @override
  List<Object> get props => [age, name, email];

  @override
  String toString() => 'OnChangeName { Name: $name, email: $email, Age: $age }';
}

class OnChangeName extends EmployeeEditorScreenEvent {
  const OnChangeName({required this.name});

  final String name;

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'OnChangeName { name: $name }';
}

class OnChangeAge extends EmployeeEditorScreenEvent {
  const OnChangeAge({required this.age});

  final String age;

  @override
  List<Object> get props => [age];

  @override
  String toString() => 'OnChangeAge { age: $age }';
}

class OnChangeEmail extends EmployeeEditorScreenEvent {
  const OnChangeEmail({required this.email});

  final String email;

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'OnChangeEmail { email: $email }';
}

class OnAddEmployee extends EmployeeEditorScreenEvent {
  const OnAddEmployee();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'OnAddEmployee';
}

class OnUpdateEmployee extends EmployeeEditorScreenEvent {
  const OnUpdateEmployee({required this.position});

  final int position;

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'OnUpdateEmployee';
}

class OnRemoveEmployee extends EmployeeEditorScreenEvent {
  const OnRemoveEmployee({required this.position});

  final int position;

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'OnRemoveEmployee';
}

class ClearEmployeeEditorScreenPageCommand extends EmployeeEditorScreenEvent {
  const ClearEmployeeEditorScreenPageCommand();

  @override
  String toString() => 'ClearEmployeeEditorScreenPageCommand';
}
