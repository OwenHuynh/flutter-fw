import 'package:flutter/cupertino.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/presentation/navigation/app_router.gr.dart';
import 'package:flutter_fm/presentation/navigation/navigation_handler.dart';

class AppNavigation {
  static Future<void> pop(BuildContext context) async {
    await NavigationHandler.pop();
  }

  static Future<void> onNavigateToLogin() async {
    await NavigationHandler.replace(route: LoginScreenRoute());
  }

  static Future<void> onNavigateToEmployeeListScreen(
      BuildContext context) async {
    await NavigationHandler.push(
        context: context, route: EmployeeListScreenRoute());
  }

  static Future<void> onNavigateToEmployeeEditorScreen(BuildContext context,
      {EmployeeModel? employeeModel,
      required Function loadCallback,
      int? position}) async {
    await NavigationHandler.push(
        context: context,
        route: EmployeeEditorScreenRoute(
            employeeModel: employeeModel,
            loadCallback: loadCallback,
            position: position));
  }
}
