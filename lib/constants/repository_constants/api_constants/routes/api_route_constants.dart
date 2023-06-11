import 'package:flutter/foundation.dart';

class ApiRouteConstants {
  static String getBaseUrl() {
    if (kDebugMode) {
      return "https://route.it";
    } else {
      throw Exception("Production mode is not supported yet");
    }
  }

  // Add here the route constants
  static String basePath = "/api/v1";

  static String tokenPath = "/token/";

  static String refreshTokenPath = "${tokenPath}refresh/";
}
