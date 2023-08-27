import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';

@immutable
abstract class EmployeesScreenEvent extends Equatable {
  const EmployeesScreenEvent();

  @override
  List<Object?> get props => [];
}

class OnLoadEmployeesList extends EmployeesScreenEvent {
  const OnLoadEmployeesList();

  @override
  List<Object> get props => [];
}

class OnEmployeeClicked extends EmployeesScreenEvent {
  const OnEmployeeClicked(this.employee, this.position);

  final EmployeeModel employee;
  final int position;

  @override
  String toString() =>
      'OnEmployeeClicked { employee: $employee, position: $position }';

  @override
  List<Object> get props => [employee];
}

class ClearEmployeesScreenPageCommand extends EmployeesScreenEvent {
  const ClearEmployeesScreenPageCommand();

  @override
  String toString() => 'ClearEmployeesScreenPageCommand';
}
