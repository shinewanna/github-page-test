import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  static const isRecivingNoti = "isRecivingNoti";

  static Future<bool> setString(
      {required String key, required String value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
    return true;
  }

  static Future<String> getString({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key)!;
  }

  static Future<bool> setBool(
      {required String key, required bool value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
    return true;
  }

  static Future<bool> getBool({required String key, bool init = false}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? init;
  }

  static Future<bool> setList(
      {required String key, required List<String> value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(key, value);
    return true;
  }

  static Future<List<String>> getList({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList(key) ?? [];
  }

  static Future<void> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
