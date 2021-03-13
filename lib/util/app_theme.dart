import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppTheme {
  AppTheme._();

  static Color primaryColor = HexColor('#00aca9');
  static Color primaryDarkColor = HexColor('#00897B');

  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    headline1: headline1,
    headline2: headline2,
    headline3: headline3,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,
    subtitle1: subtitle1,
    subtitle2: subtitle2,
    bodyText1: bodyText1,
    bodyText2: bodyText2,
    caption: caption,
    button: button,
    overline: overline
  );

  static const TextStyle headline1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 48,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.white,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 40,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.white,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.white,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 32,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.white,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 28,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.white,
  );

  static const TextStyle headline6 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.white,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    letterSpacing: -0.04,
    color: Colors.white,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    letterSpacing: -0.04,
    color: Colors.black,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.05,
    color: Colors.white,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: Colors.black,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    letterSpacing: 0.2,
    color: Colors.white, // was lightText
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    letterSpacing: 0.2,
    color: Colors.black, // was lightText
  );

  static const TextStyle overline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: Colors.white, // was lightText
  );

}
