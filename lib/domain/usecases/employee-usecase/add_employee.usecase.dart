import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/domain/repositories/employee-repository/employee_repository.dart';
import 'package:flutter_fm/domain/usecases/usecase.dart';
import 'package:flutter_fm/shared/errors/errors.dart';

class AddEmployeeUseCase extends UseCase<void, AddEmployeeParams> {
  AddEmployeeUseCase({required this.employeeRepository});

  final EmployeeRepository employeeRepository;

  @override
  Future<Either<Failure, void>> call(AddEmployeeParams params) {
    return employeeRepository.addEmployee(params.employee);
  }
}

class AddEmployeeParams extends Equatable {
  AddEmployeeParams({required this.employee});

  final EmployeeModel employee;

  @override
  List<Object?> get props => [employee];
}
