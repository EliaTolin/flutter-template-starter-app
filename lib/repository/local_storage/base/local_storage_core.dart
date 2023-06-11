import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageCore {
  LocalStorageCore();

  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key);
    return json.decode(data.toString());
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  Future<bool> exist(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool exist = prefs.containsKey(key);
    return exist;
  }
}
