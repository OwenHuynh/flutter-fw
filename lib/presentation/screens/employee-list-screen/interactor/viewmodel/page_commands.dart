import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/shared/command/page_command.dart';

class ShowEmployeeDetailScreen extends PageCommand {
  ShowEmployeeDetailScreen(this.employee, this.position);

  final EmployeeModel employee;
  final int position;

  @override
  String toString() => 'ShowEmployeeDetailScreen: { employee: $employee }';
}
