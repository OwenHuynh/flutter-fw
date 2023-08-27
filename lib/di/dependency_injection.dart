import 'package:flutter_fm/data/locals/repositories-impl/employee/employee_repository_impl.dart';
import 'package:flutter_fm/domain/repositories/employee-repository/employee_repository.dart';
import 'package:flutter_fm/domain/usecases/employee-usecase/employee_usecase.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/viewmodel/employee_editor_screen.bloc.dart';
import 'package:flutter_fm/presentation/screens/employee-list-screen/interactor/viewmodel/employee_screen.bloc.dart';
import 'package:flutter_fm/presentation/screens/login-screen/interactor/interactor.dart';
import 'package:flutter_fm/presentation/screens/splash-screen/interactor/interactor.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureInjection() async {
  getIt

    /// [BLOC / CUBIT]
    ..registerFactory(() => SplashScreenBloc())
    ..registerFactory(() => LoginScreenBloc())
    ..registerFactory(
        () => EmployeesScreenBloc(getEmployeeListUseCase: getIt()))
    ..registerFactory(() => EmployeeEditorScreenBloc(
        addEmployeeUseCase: getIt(),
        updateEmployeeUseCase: getIt(),
        deleteEmployeeUseCase: getIt()))

    /// [REPOSITORIES]
    ..registerLazySingleton<EmployeeRepository>(() => EmployeeRepositoryImpl())

    /// [USE CASES]
    ..registerLazySingleton(
        () => AddEmployeeUseCase(employeeRepository: getIt()))
    ..registerLazySingleton(
        () => DeleteEmployeeUseCase(employeeRepository: getIt()))
    ..registerLazySingleton(
        () => UpdateEmployeeUseCase(employeeRepository: getIt()))
    ..registerLazySingleton(
        () => GetEmployeeListUseCase(employeeRepository: getIt()));
}
