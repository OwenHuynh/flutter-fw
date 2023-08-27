import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fm/domain/repositories/employee-repository/employee_repository.dart';
import 'package:flutter_fm/domain/usecases/usecase.dart';
import 'package:flutter_fm/shared/errors/errors.dart';

class DeleteEmployeeUseCase extends UseCase<void, DeleteEmployeeParams> {
  DeleteEmployeeUseCase({required this.employeeRepository});

  final EmployeeRepository employeeRepository;

  @override
  Future<Either<Failure, void>> call(DeleteEmployeeParams params) {
    return employeeRepository.deleteEmployee(params.position);
  }
}

class DeleteEmployeeParams extends Equatable {
  DeleteEmployeeParams({required this.position});

  final int position;

  @override
  List<Object?> get props => [position];
}
