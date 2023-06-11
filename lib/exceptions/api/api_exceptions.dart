// No connection
class NoInternetConnectionException implements Exception {
  const NoInternetConnectionException() : super();
}

// Internal Server Error Exception
class InternalServerErrorException implements Exception {
  String description;
  InternalServerErrorException({this.description = ""}) : super();
}

// End Point not found Exception
class NotFoundEndPointException implements Exception {
  const NotFoundEndPointException() : super();
}

// Bad Request Exception
class BadRequestException implements Exception {
  String description;
  BadRequestException(this.description) : super();
}
