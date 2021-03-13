import 'dart:convert';

import 'package:outmatic/api/api.dart';
import 'package:outmatic/config/preference_param.dart';
import 'package:outmatic/model/user_model.dart';
import 'package:outmatic/util/preference_helper.dart';

class UserRepository {
  UserModel getUser() {
    try {
      return UserModel.fromJson(jsonDecode(PreferenceHelper.getString(PreferenceParam.user, "")));
    } catch (error) {
      return null;
    }
  }

  void saveUser(UserModel user) {
    PreferenceHelper.setString(PreferenceParam.user, user.toJson());
  }

  void clearUser() {
    PreferenceHelper.remove(PreferenceParam.user);
  }

  Future<dynamic> login({String email, String password}) async {
    return await Api.login({"email": email, "password": password});
  }
}