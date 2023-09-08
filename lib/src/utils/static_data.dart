import '../domain/models/responses/login_response.dart';

class StaticData {
  static String? tempToken = "Token Not Available";
  static LoginData? loginData = LoginData();
  static String token = 'Bearer ${tempToken}';
  static String deviceInfo = "Not Available";
  static String deviceToken = "Token Not Available";
  static int deviceType = 0;
  static double lat = 0.0;
  static double long =  0.0;
}
