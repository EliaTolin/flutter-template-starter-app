
import 'package:starterapp/constants/apis/api_route_constants.dart';

class ApiRouteHelper {
  static String getBaseUrl() =>
      "${ApiPathConstants.getBaseUrl()}${ApiPathConstants.basePath}/";
}
