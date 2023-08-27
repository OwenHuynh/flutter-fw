import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fm/shared/http/dio_utils/config/http_callback.dart';
import 'package:flutter_fm/shared/http/dio_utils/config/http_error_handling/http_error_handling.dart';
import 'package:flutter_fm/shared/http/dio_utils/config/http_type.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';
import 'package:flutter_fm/shared/utils/utils.dart';

class DioRequest {
  DioRequest({required this.dio});

  Dio dio;

  Future get(
    BuildContext context,
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
    required onStartCallBack onStart,
    required onCompletedCallBack onCompleted,
    required onErrorCallBack onError,
  }) async {
    return request(
      context,
      url,
      MethodType.GET,
      data: data,
      params: params,
      cancelToken: cancelToken,
      options: options,
      onStart: onStart,
      onCompleted: onCompleted,
      onError: onError,
    );
  }

  Future request(
    BuildContext context,
    String url,
    MethodType method, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    required onStartCallBack onStart,
    required onCompletedCallBack onCompleted,
    required onErrorCallBack onError,
    CancelToken? cancelToken,
  }) async {
    onStart();

    try {
      if (NetworkUtils.isNetWorkAvailable() != 0) {
        Response response;
        switch (method) {
          case MethodType.GET:
            if (params != null) {
              response = await dio.get(url,
                  queryParameters: params, cancelToken: cancelToken);
            } else {
              response = await dio.get(url, cancelToken: cancelToken);
            }
            break;
          case MethodType.POST:
            if (params != null && params.isNotEmpty) {
              response = await dio.post(url,
                  queryParameters: params,
                  data: data,
                  cancelToken: cancelToken);
            } else {
              response =
                  await dio.post(url, data: data, cancelToken: cancelToken);
            }
            break;
          case MethodType.PUT:
            response = await dio.put(url, data: data, cancelToken: cancelToken);
            break;
          case MethodType.DELETE:
            response =
                await dio.delete(url, data: data, cancelToken: cancelToken);
            break;
          case MethodType.PATCH:
            response =
                await dio.patch(url, data: data, cancelToken: cancelToken);
            break;
        }

        if (response.statusCode == HttpStatus.ok ||
            response.statusCode == HttpStatus.created ||
            response.statusCode == HttpStatus.accepted) {
          onCompleted(response);
        }
      } else {
        onError(
            HttpErrorHandling.NETWORK_ERROR, Localy.of(context)?.networkError);
      }
    } on DioError catch (e, _) {
      final HttpErrorHandling httpError =
          HttpErrorHandling.dioError(context: context, error: e);
      onError(httpError.code, httpError.message);
    } on Exception catch (_) {
      onError(HttpErrorHandling.UNKNOWN, Localy.of(context)?.networkError);
    }
  }
}
