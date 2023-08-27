import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class EmployeeModel {
  EmployeeModel({required this.name, required this.age, required this.email});

  @HiveField(0)
  String? name;

  @HiveField(1)
  int? age;

  @HiveField(2)
  String email;
}
