import 'package:auto_route/auto_route.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/employee_editor_screen.dart';
import 'package:flutter_fm/presentation/screens/employee-list-screen/employee_list_screen.dart';
import 'package:flutter_fm/presentation/screens/login-screen/login_screen.dart';
import 'package:flutter_fm/presentation/screens/splash-screen/splash_screen.dart';

@CustomAutoRouter(
    replaceInRouteName: 'Page',
    routes: <AutoRoute>[
      AutoRoute(page: SplashScreen, initial: true),
      AutoRoute(page: LoginScreen),
      AutoRoute(page: EmployeeListScreen),
      AutoRoute(page: EmployeeEditorScreen),
    ],
    transitionsBuilder: TransitionsBuilders.slideLeft,
    durationInMilliseconds: 400)
class $AppRouter {}
