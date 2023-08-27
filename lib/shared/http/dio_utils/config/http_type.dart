enum MethodType { GET, POST, PUT, PATCH, DELETE }

extension MethodTypeExtension on MethodType {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
