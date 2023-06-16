import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:starterapp/constants/repository_constants/api_constants/routes/api_route_constants.dart';
import 'package:starterapp/exceptions/api/api_exceptions.dart';
import 'package:starterapp/exceptions/auth/auth_exception.dart';
import 'package:starterapp/helper/api/api_route_helper.dart';
import 'package:starterapp/helper/auth/jwt_token_helper.dart';

class ApiBaseCore {
  late Dio baseAPI;

  final BaseOptions opts = BaseOptions(
    baseUrl: ApiRouteHelper.getBaseUrl(),
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  Dio createDio() {
    return Dio(opts);
  }

  ApiBaseCore() {
    Dio dio = createDio();
    baseAPI = addInterceptors(dio);
  }

  Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            requestInterceptor(options, handler);
          },
          onError: (DioException e, ErrorInterceptorHandler handler) async {
            log("ERROR: $e");
            handler.next(e);
          },
          onResponse: (Response response, ResponseInterceptorHandler handler) {
            handler.next(response);
          },
        ),
      );
  }

  Future<void> requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = "";
    final jwtTokenHelper = JwtTokenHelper();

    // If not exist, the user is not logged in the app, i not need add the token
    if (await jwtTokenHelper.existJwtToken()) {
      if (!await jwtTokenHelper.isValidAccessToken()) {
        if (!await jwtTokenHelper.isValidRefreshToken()) {
          throw const RefreshTokenExpiredException();
        }
        Dio dio = Dio(opts);
        Response<dynamic> response = await dio.post(
          ApiRouteConstants.refreshTokenPath,
          data: {
            "refresh": await jwtTokenHelper.getRefreshToken(),
          },
        ).onError(
          (DioException error, stackTrace) => handleError(error),
        );
        await jwtTokenHelper.saveNewJwtTokens(
          response.data["access"],
          response.data["refresh"],
        );
        log("New access token: ${response.data["access"]}");
        log("New refresh token: ${response.data["refresh"]}");
        token = response.data["access"];
      }
      token = await jwtTokenHelper.getAccessToken();
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    log("____________________");
    log("URL: ${options.baseUrl}${options.path}");
    log("METHOD: ${options.method}");
    log("Headers: ${options.headers}");
    log("Data: ${options.data}");
    log("QueryParams: ${options.queryParameters}");
    log("____________________");
    handler.next(options);
  }

  Future<Response?> getHTTP(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await baseAPI.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<Response?> postHTTP(String path, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await baseAPI.post(path,
          data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<Response?> putHTTP(String path, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await baseAPI.put(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<Response?> deleteHTTP(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await baseAPI.delete(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      handleError(e);
    }
    return null;
  }

  handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw const NoInternetConnectionException();
      case DioExceptionType.sendTimeout:
        throw const NoInternetConnectionException();
      case DioExceptionType.receiveTimeout:
        throw const NoInternetConnectionException();
      case DioExceptionType.badResponse:
        if (error.response == null) {
          throw BadRequestException("");
        }
        switch (error.response?.statusCode) {
          case 401:
            throw const UnauthorizedException();
          case 400:
            throw BadRequestException("");
          case 404:
            throw const NotFoundEndPointException();
          case 500:
            throw InternalServerErrorException();
        }
        break;
      case DioExceptionType.cancel:
        break;
      default:
        throw BadRequestException("Unknown error");
    }
  }
}
