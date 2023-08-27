import 'package:dartz/dartz.dart';
import 'package:flutter_fm/data/locals/hive_cache.dart';
import 'package:flutter_fm/data/locals/hive_constants_keys.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/domain/repositories/employee-repository/employee_repository.dart';
import 'package:flutter_fm/shared/errors/errors.dart';
import 'package:hive/hive.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  @override
  Future<Either<Failure, List<EmployeeModel>>> getEmployeeList() async {
    final box =
        await Hive.openBox<EmployeeModel>(HiveConstantsKeys.employeeBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(box.values.toList().cast<EmployeeModel>());
  }

  @override
  Future<Either<Failure, void>> addEmployee(EmployeeModel employee) async {
    final box =
        await Hive.openBox<EmployeeModel>(HiveConstantsKeys.employeeBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(await box.add(employee));
  }

  @override
  Future<Either<Failure, void>> deleteAllEmployee() async {
    final box =
        await Hive.openBox<EmployeeModel>(HiveConstantsKeys.employeeBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(await box.clear());
  }

  @override
  Future<Either<Failure, void>> deleteEmployee(int position) async {
    final box =
        await Hive.openBox<EmployeeModel>(HiveConstantsKeys.employeeBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(await box.deleteAt(position));
  }

  @override
  Future<Either<Failure, void>> updateEmployee(
      int position, EmployeeModel employee) async {
    final box =
        await Hive.openBox<EmployeeModel>(HiveConstantsKeys.employeeBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(await box.putAt(position, employee));
  }
}
