import 'package:flutter/material.dart';

class KeyboardUtil {
  static fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode next,
      ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  ///Singleton factory
  static final KeyboardUtil _instance = KeyboardUtil._internal();

  factory KeyboardUtil() {
    return _instance;
  }

  KeyboardUtil._internal();
}
