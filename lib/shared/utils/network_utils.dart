import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<int> isNetWorkAvailable() async {
    final connectivityResult = await new Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return 1;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 2;
    } else if (connectivityResult == ConnectivityResult.none) {
      return 0;
    }
    return 0;
  }
}
