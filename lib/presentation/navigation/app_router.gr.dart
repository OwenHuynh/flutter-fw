// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../data/locals/models/employee/employee_model.dart' as _i7;
import '../screens/employee-editor-screen/employee_editor_screen.dart' as _i4;
import '../screens/employee-list-screen/employee_list_screen.dart' as _i3;
import '../screens/login-screen/login_screen.dart' as _i2;
import '../screens/splash-screen/splash_screen.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.SplashScreen(),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeft,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    },
    LoginScreenRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.LoginScreen(),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeft,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    },
    EmployeeListScreenRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.EmployeeListScreen(),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeft,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    },
    EmployeeEditorScreenRoute.name: (routeData) {
      final args = routeData.argsAs<EmployeeEditorScreenRouteArgs>();
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.EmployeeEditorScreen(
              key: args.key,
              employeeModel: args.employeeModel,
              loadCallback: args.loadCallback,
              position: args.position),
          transitionsBuilder: _i5.TransitionsBuilders.slideLeft,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i5.RouteConfig(LoginScreenRoute.name, path: '/login-screen'),
        _i5.RouteConfig(EmployeeListScreenRoute.name,
            path: '/employee-list-screen'),
        _i5.RouteConfig(EmployeeEditorScreenRoute.name,
            path: '/employee-editor-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i5.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i5.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(LoginScreenRoute.name, path: '/login-screen');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.EmployeeListScreen]
class EmployeeListScreenRoute extends _i5.PageRouteInfo<void> {
  const EmployeeListScreenRoute()
      : super(EmployeeListScreenRoute.name, path: '/employee-list-screen');

  static const String name = 'EmployeeListScreenRoute';
}

/// generated route for
/// [_i4.EmployeeEditorScreen]
class EmployeeEditorScreenRoute
    extends _i5.PageRouteInfo<EmployeeEditorScreenRouteArgs> {
  EmployeeEditorScreenRoute(
      {_i6.Key? key,
      _i7.EmployeeModel? employeeModel,
      required Function loadCallback,
      int? position})
      : super(EmployeeEditorScreenRoute.name,
            path: '/employee-editor-screen',
            args: EmployeeEditorScreenRouteArgs(
                key: key,
                employeeModel: employeeModel,
                loadCallback: loadCallback,
                position: position));

  static const String name = 'EmployeeEditorScreenRoute';
}

class EmployeeEditorScreenRouteArgs {
  const EmployeeEditorScreenRouteArgs(
      {this.key,
      this.employeeModel,
      required this.loadCallback,
      this.position});

  final _i6.Key? key;

  final _i7.EmployeeModel? employeeModel;

  final Function loadCallback;

  final int? position;

  @override
  String toString() {
    return 'EmployeeEditorScreenRouteArgs{key: $key, employeeModel: $employeeModel, loadCallback: $loadCallback, position: $position}';
  }
}
