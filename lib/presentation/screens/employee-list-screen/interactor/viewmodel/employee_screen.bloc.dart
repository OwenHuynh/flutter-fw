import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_fm/domain/usecases/employee-usecase/get_employee_list.usecase.dart';
import 'package:flutter_fm/presentation/screens/employee-list-screen/interactor/interactor.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class EmployeesScreenBloc
    extends Bloc<EmployeesScreenEvent, EmployeeScreenState> {
  EmployeesScreenBloc({required this.getEmployeeListUseCase})
      : super(EmployeeScreenState.initial()) {
    on<OnLoadEmployeesList>(_onLoadEmployeesList);
    on<OnEmployeeClicked>(_onEmployeeClicked);
    on<ClearEmployeesScreenPageCommand>((_, emit) => emit(state.copyWith()));
  }

  final GetEmployeeListUseCase getEmployeeListUseCase;

  Future<void> _onLoadEmployeesList(
      OnLoadEmployeesList event, Emitter<EmployeeScreenState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));
    await Future.delayed(const Duration(seconds: 1));
    final result = await getEmployeeListUseCase();
    result.fold((
      failure,
    ) {
      emit(state.copyWith(pageState: PageState.failure, employeeList: []));
    }, (data) {
      emit(state.copyWith(pageState: PageState.success, employeeList: data));
    });
  }

  Future<void> _onEmployeeClicked(
      OnEmployeeClicked event, Emitter<EmployeeScreenState> emit) async {
    emit(state.copyWith(
        pageCommand: ShowEmployeeDetailScreen(event.employee, event.position)));
  }
}
