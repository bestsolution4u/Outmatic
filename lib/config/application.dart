import 'package:outmatic/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static SharedPreferences preferences;
  static UserModel user;

  /// test
  static String rfidTest = "77139251112800104224";
  static String rfidTestError = "77139251112800104225";
  static String rfidTest2 = "3548225112800104224";

  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}