import 'package:dartz/dartz.dart';
import 'package:flutter_fm/shared/errors/errors.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseRight<Type, Params> {
  Future<Type> call(Params params);
}
