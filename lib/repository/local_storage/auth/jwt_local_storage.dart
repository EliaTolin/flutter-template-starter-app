import 'package:starterapp/constants/repository_constants/local_storage_constants/auth/jwt_token_keys.dart';
import 'package:starterapp/repository/local_storage/base/local_storage_core.dart';

class JwtLocalStorage {
  LocalStorageCore localStorageCore = LocalStorageCore();

  Future<bool> existJwtToken() async {
    return await localStorageCore.exist(JwtTokenKeys.accessTokenKey);
  }

  Future<bool> existRefreshToken() async {
    return await localStorageCore.exist(JwtTokenKeys.refreshTokenKey);
  }

  Future<void> saveAccessToken(String token) async {
    await localStorageCore.save(JwtTokenKeys.accessTokenKey, token);
  }

  Future<void> saveRefreshToken(String token) async {
    await localStorageCore.save(JwtTokenKeys.refreshTokenKey, token);
  }

  Future<String> getAccessToken() async {
    return await localStorageCore.read(JwtTokenKeys.accessTokenKey);
  }

  Future<String> getRefreshToken() async {
    return await localStorageCore.read(JwtTokenKeys.refreshTokenKey);
  }

  Future<void> clearJwtTokens() async {
    await localStorageCore.remove(JwtTokenKeys.accessTokenKey);
    await localStorageCore.remove(JwtTokenKeys.refreshTokenKey);
  }
}
