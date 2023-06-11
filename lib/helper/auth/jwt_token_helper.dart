import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:starterapp/constants/repository_constants/api_constants/auth/api_token_constants.dart';
import 'package:starterapp/repository/local_storage/auth/jwt_local_storage.dart';

class JwtTokenHelper {
  JwtLocalStorage jwtLocalStorage = JwtLocalStorage();

  Future<bool> existJwtToken() => jwtLocalStorage.existJwtToken();

  Future<bool> existRefreshToken() => jwtLocalStorage.existRefreshToken();

  Future<void> saveNewJwtTokens(String accessToken, String refreshToken) async {
    await jwtLocalStorage.saveAccessToken(accessToken);
    await jwtLocalStorage.saveRefreshToken(refreshToken);
  }

  Future<dynamic> getAccessToken() => jwtLocalStorage.getAccessToken();

  Future<dynamic> getRefreshToken() => jwtLocalStorage.getRefreshToken();

  Future<bool> isValidAccessToken() async {
    if (!await existJwtToken()) {
      return false;
    }
    try {
      String token = await getAccessToken();
      _verifyToken(token);
    } on JWTExpiredException {
      return false;
    } on JWTException {
      return false;
    }
    return true;
  }

  Future<bool> isValidRefreshToken() async {
    if (!await existRefreshToken()) {
      return false;
    }
    try {
      String token = await getRefreshToken();
      _verifyToken(token);
    } on JWTExpiredException {
      return false;
    } on JWTException {
      return false;
    }
    return true;
  }

  _verifyToken(String token) =>
      JWT.verify(token, SecretKey(JwtTokenConstants.jwtSecretPhrase));

  Future<void> clearJwtTokens() => jwtLocalStorage.clearJwtTokens();
}
