import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';

class HttpErrorHandling {
  HttpErrorHandling({this.code, this.message});

  HttpErrorHandling.dioError(
      {required BuildContext context, required DioError error}) {
    message = error.message;
    switch (error.type) {
      case DioErrorType.connectTimeout:
        code = CONNECT_TIMEOUT;
        message = Localy.of(context)?.connectTimeoutError;
        break;
      case DioErrorType.receiveTimeout:
        code = RECEIVE_TIMEOUT;
        message = Localy.of(context)?.receiveTimeoutError;
        break;
      case DioErrorType.sendTimeout:
        code = SEND_TIMEOUT;
        message = Localy.of(context)?.sendTimeoutError;
        break;
      case DioErrorType.response:
        code = HTTP_ERROR;
        message = Localy.of(context)?.networkError;
        break;
      case DioErrorType.cancel:
        code = CANCEL;
        message = Localy.of(context)?.cancelError;
        break;
      case DioErrorType.other:
        code = UNKNOWN;
        message = Localy.of(context)?.networkError;
        break;
    }
  }

  String? code;

  String? message;

  static const String UNKNOWN = "UNKNOWN";

  static const String PARSE_ERROR = "PARSE_ERROR";

  static const String NETWORK_ERROR = "NETWORK_ERROR";

  static const String HTTP_ERROR = "HTTP_ERROR";

  static const String SSL_ERROR = "SSL_ERROR";

  static const String CONNECT_TIMEOUT = "CONNECT_TIMEOUT";

  static const String RECEIVE_TIMEOUT = "RECEIVE_TIMEOUT";

  static const String SEND_TIMEOUT = "SEND_TIMEOUT";

  static const String CANCEL = "CANCEL";
}
