import 'package:dartz/dartz.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/domain/repositories/employee-repository/employee_repository.dart';
import 'package:flutter_fm/domain/usecases/usecase.dart';
import 'package:flutter_fm/shared/errors/errors.dart';

class GetEmployeeListUseCase extends UseCase<List<EmployeeModel>, void> {
  GetEmployeeListUseCase({required this.employeeRepository});

  final EmployeeRepository employeeRepository;

  @override
  Future<Either<Failure, List<EmployeeModel>>> call([_]) async {
    return employeeRepository.getEmployeeList();
  }
}
