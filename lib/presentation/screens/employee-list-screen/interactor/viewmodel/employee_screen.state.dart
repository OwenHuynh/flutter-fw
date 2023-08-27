import 'package:equatable/equatable.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/shared/command/page_command.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class EmployeeScreenState extends Equatable {
  const EmployeeScreenState(
      {this.pageCommand,
      required this.pageState,
      required this.employeeList,
      this.errorMessage});

  factory EmployeeScreenState.initial() {
    return const EmployeeScreenState(
      pageState: PageState.initial,
      employeeList: [],
      errorMessage: null,
    );
  }

  final PageCommand? pageCommand;
  final PageState pageState;
  final List<EmployeeModel?> employeeList;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [pageCommand, pageState, employeeList, errorMessage];

  EmployeeScreenState copyWith(
      {PageCommand? pageCommand,
      PageState? pageState,
      List<EmployeeModel>? employeeList,
      String? errorMessage}) {
    return EmployeeScreenState(
      pageCommand: pageCommand,
      pageState: pageState ?? this.pageState,
      employeeList: employeeList ?? this.employeeList,
      errorMessage: errorMessage,
    );
  }
}
