import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/domain/repositories/employee-repository/employee_repository.dart';
import 'package:flutter_fm/domain/usecases/usecase.dart';
import 'package:flutter_fm/shared/errors/errors.dart';

class UpdateEmployeeUseCase extends UseCase<void, UpdateEmployeeParams> {
  UpdateEmployeeUseCase({required this.employeeRepository});

  final EmployeeRepository employeeRepository;

  @override
  Future<Either<Failure, void>> call(UpdateEmployeeParams params) {
    return employeeRepository.updateEmployee(params.position, params.employee);
  }
}

class UpdateEmployeeParams extends Equatable {
  UpdateEmployeeParams({required this.position, required this.employee});

  final int position;
  final EmployeeModel employee;

  @override
  List<Object?> get props => [position, employee];
}
