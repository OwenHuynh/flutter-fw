import 'package:flutter_fm/shared/command/page_command.dart';

class AddEmployeeList extends PageCommand {
  @override
  String toString() => 'AddEmployeeToList';
}

class UpdateEmployeeList extends PageCommand {
  @override
  String toString() => 'UpdateEmployeeList';
}

class RemoveEmployeeList extends PageCommand {
  @override
  String toString() => 'RemoveEmployeeList';
}
