import 'package:dio/dio.dart';
import 'package:flutter_fm/shared/http/dio_utils/config/http_config.dart';
import 'package:flutter_fm/shared/http/dio_utils/dio_request.dart';
import 'package:flutter_fm/shared/http/dio_utils/interceptor/interceptor.dart';

class DioUtil {
  DioUtil() {
    final options = BaseOptions(
      connectTimeout: HttpConfig.connectionTimeout,
      receiveTimeout: HttpConfig.receiveTimeout,
      sendTimeout: HttpConfig.sendTimeout,
      baseUrl: HttpConfig.baseUrl,
      validateStatus: (_) {
        return true;
      },
      responseType: ResponseType.json,
    );

    final dio = new Dio(options);
    dio.interceptors.add(DioInterceptorLogger(
        request: HttpConfig.LogNetworkRequest,
        requestBody: HttpConfig.LogNetworkRequestBody,
        requestHeader: HttpConfig.LogNetworkRequestHeader,
        responseBody: HttpConfig.LogNetworkResponseBody,
        responseHeader: HttpConfig.LogNetworkResponseHeader,
        maxWidth: 768));

    httpConfig = DioRequest(dio: dio);
  }

  static DioUtil? instance;
  static DioRequest? httpConfig;

  static DioRequest? getInstance() {
    if (instance == null) {
      instance = DioUtil();
    }
    return _getDioRequest();
  }

  static DioRequest? _getDioRequest() {
    return httpConfig;
  }
}
