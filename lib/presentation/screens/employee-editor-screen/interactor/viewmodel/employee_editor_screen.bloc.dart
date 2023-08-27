import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/domain/usecases/employee-usecase/add_employee.usecase.dart';
import 'package:flutter_fm/domain/usecases/employee-usecase/delete_employee.usecase.dart';
import 'package:flutter_fm/domain/usecases/employee-usecase/update_employee.usecase.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/viewmodel/employee_editor_screen.event.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/viewmodel/employee_editor_screen.state.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/viewmodel/page_commands.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class EmployeeEditorScreenBloc
    extends Bloc<EmployeeEditorScreenEvent, EmployeeEditorScreenState> {
  EmployeeEditorScreenBloc(
      {required this.addEmployeeUseCase,
      required this.updateEmployeeUseCase,
      required this.deleteEmployeeUseCase})
      : super(EmployeeEditorScreenState.initial()) {
    on<OnInitialEmployeeEditorScreenEvent>(_onInitialEmployeeEditorScreenEvent);
    on<OnChangeName>(_onChangeName);
    on<OnChangeAge>(_onChangeAge);
    on<OnChangeEmail>(_onChangeEmail);
    on<OnAddEmployee>(_onAddEmployee);
    on<OnUpdateEmployee>(_onUpdateEmployee);
    on<OnRemoveEmployee>(_onRemoveEmployee);
    on<ClearEmployeeEditorScreenPageCommand>(
        (_, emit) => emit(state.copyWith()));
  }

  final AddEmployeeUseCase addEmployeeUseCase;
  final UpdateEmployeeUseCase updateEmployeeUseCase;
  final DeleteEmployeeUseCase deleteEmployeeUseCase;

  FutureOr<void> _onInitialEmployeeEditorScreenEvent(
      OnInitialEmployeeEditorScreenEvent event,
      Emitter<EmployeeEditorScreenState> emit) {
    emit(state.copyWith(age: event.age, name: event.name, email: event.email));
  }

  FutureOr<void> _onChangeName(
      OnChangeName event, Emitter<EmployeeEditorScreenState> emit) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onChangeAge(
      OnChangeAge event, Emitter<EmployeeEditorScreenState> emit) {
    emit(state.copyWith(age: event.age));
  }

  FutureOr<void> _onChangeEmail(
      OnChangeEmail event, Emitter<EmployeeEditorScreenState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onAddEmployee(
      OnAddEmployee event, Emitter<EmployeeEditorScreenState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));
    final result = await addEmployeeUseCase(AddEmployeeParams(
        employee: EmployeeModel(
            age: int.parse(state.age), name: state.name, email: state.email)));
    result.fold((l) {}, (r) {
      emit(state.copyWith(
          pageCommand: AddEmployeeList(), pageState: PageState.success));
    });
  }

  FutureOr<void> _onUpdateEmployee(
      OnUpdateEmployee event, Emitter<EmployeeEditorScreenState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));
    final result = await updateEmployeeUseCase(UpdateEmployeeParams(
        position: event.position,
        employee: EmployeeModel(
            age: int.parse(state.age), name: state.name, email: state.email)));
    result.fold((l) {}, (r) {
      emit(state.copyWith(
          pageCommand: UpdateEmployeeList(), pageState: PageState.success));
    });
  }

  FutureOr<void> _onRemoveEmployee(
      OnRemoveEmployee event, Emitter<EmployeeEditorScreenState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));
    final result = await deleteEmployeeUseCase(DeleteEmployeeParams(
      position: event.position,
    ));
    result.fold((l) {}, (r) {
      emit(state.copyWith(
          pageCommand: RemoveEmployeeList(), pageState: PageState.success));
    });
  }
}
