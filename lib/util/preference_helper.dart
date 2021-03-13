import 'package:outmatic/config/application.dart';

class PreferenceHelper {

  static void setString(String key, String value) {
    Application.preferences.setString(key, value ?? "");
  }

  static String getString(String key, String defVal) {
    return Application.preferences.getString(key) ?? defVal;
  }

  static void setInt(String key, int value) {
    Application.preferences.setInt(key, value);
  }

  static int getInt(String key, int defVal) {
    return Application.preferences.getInt(key) ?? defVal;
  }

  static void setDouble(String key, double value) {
    Application.preferences.setDouble(key, value);
  }

  static double getDouble(String key, double defVal) {
    return Application.preferences.getDouble(key) ?? defVal;
  }

  static bool setBool(String key, bool value) {
    Application.preferences.setBool(key, value);
  }

  static bool getBool(String key, bool defVal) {
    return Application.preferences.getBool(key) ?? defVal;
  }

  static Future<bool> clear() {
    return Application.preferences.clear();
  }

  static dynamic get(String key) {
    return Application.preferences.get(key);
  }

  static Future<bool> remove(String key) {
    return Application.preferences.remove(key);
  }

  static final PreferenceHelper _instance = PreferenceHelper._internal();

  factory PreferenceHelper() {
    return _instance;
  }

  PreferenceHelper._internal();
}