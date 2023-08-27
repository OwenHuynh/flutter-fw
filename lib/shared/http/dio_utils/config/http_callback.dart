import 'package:dio/dio.dart';

typedef onStartCallBack = dynamic Function();
typedef onCompletedCallBack = dynamic Function(Response response);
typedef onErrorCallBack = dynamic Function(String? code, String? message);
