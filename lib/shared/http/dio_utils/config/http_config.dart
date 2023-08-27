class HttpConfig {
  // receiveTimeout
  static final String baseUrl = "";

  // receiveTimeout
  static final int receiveTimeout = 15000;

  // connectTimeout
  static final int connectionTimeout = 15000;

  // connectTimeout
  static final int sendTimeout = 10000;

  //authorization
  static final String authorization = "Authorization";

  // bearer
  static final String bearer = "Bearer";

  // session token timeout
  static final int sessionTokenTimeout = 10800000;

  // Log requests
  static const LogNetworkRequest = true;
  static const LogNetworkRequestHeader = true;
  static const LogNetworkRequestBody = true;
  static const LogNetworkResponseHeader = false;
  static const LogNetworkResponseBody = true;
  static const LogNetworkError = true;

  static const String code = "code";
  static const String data = "data";
  static const String messages = "messages";
}
