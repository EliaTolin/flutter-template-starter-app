import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:starterapp/constants/apis/api_token_constants.dart';
import 'package:starterapp/constants/shared_pref_keys/api/api_token_keys.dart';
import 'package:starterapp/helper/shared_pref_helper.dart';

class JwtTokenHelper {
  Future<bool> existJwtToken() =>
      SharedPrefHelper().exist(ApiTokenKeys.accessTokenKey);

  Future<bool> existRefreshToken() =>
      SharedPrefHelper().exist(ApiTokenKeys.refreshTokenKey);

  Future<void> saveNewJwtTokens(String accessToken, String refreshToken) async {
    await SharedPrefHelper().save(ApiTokenKeys.accessTokenKey, accessToken);
    await SharedPrefHelper().save(ApiTokenKeys.refreshTokenKey, refreshToken);
  }

  Future<dynamic> getAccessToken() =>
      SharedPrefHelper().read(ApiTokenKeys.accessTokenKey);

  Future<dynamic> getRefreshToken() =>
      SharedPrefHelper().read(ApiTokenKeys.refreshTokenKey);

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
      JWT.verify(token, SecretKey(ApiTokenConstants.jwySecretPhrase));

  Future<void> clearJwtTokens() async {
    await SharedPrefHelper().remove(ApiTokenKeys.accessTokenKey);
    await SharedPrefHelper().remove(ApiTokenKeys.refreshTokenKey);
  }
}
