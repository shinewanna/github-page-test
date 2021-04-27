import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  static const isRecivingNoti = "isRecivingNoti";


  static Future<bool> setString({String key, String value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
    return true;
  }

  static Future<String> getString({String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static Future<bool> setBool({String key, bool value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
    return true;
  }

  static Future<bool> getBool({String key, bool init = false}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? init;
  }

  static Future<bool> setList({String key, List<String> value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(key, value);
    return true;
  }

  static Future<List<String>> getList({String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList(key) ?? [];
  }

  static Future<void> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

