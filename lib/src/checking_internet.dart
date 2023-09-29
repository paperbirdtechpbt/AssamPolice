
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecking {
  final Connectivity _connectivity;

  InternetChecking(this._connectivity);

  Future<ApiStatus> callApiWithConnectivityCheck<T>(
      Future<T> Function() apiCall,
      ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return ApiStatus.error;
    }

    try {
      await apiCall();
      return ApiStatus.success;
    } catch (e) {
      return ApiStatus.error;
    }
  }

    Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}

enum ApiStatus { success, error }
