import 'package:starterapp/constants/repository_constants/api_constants/routes/api_route_constants.dart';

class ApiRouteHelper {
  static String getBaseUrl() =>
      "${ApiRouteConstants.getBaseUrl()}${ApiRouteConstants.basePath}/";
}
