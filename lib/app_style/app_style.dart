import 'package:flutter/material.dart';

abstract class AppStyle {
  static const Color yellowButton = Color(0xffFFCC28); //#D9D9D94D
  static const Color blueTextButton = Color(0xff013D68); //#D9D9D94D
  static const Color blueTextButtonMoreOpacity = Color(0xff013e6a); //#D9D9D94D
  static const Color blueTextButtonOpacity = Color(0x5B013868); //#D9D9D94D
  static const Color topLightGrey = Color(0xffFAFAFA); //#D9D9D94D
  static const Color lightGrey = Color(0xffe1e4e7); //#D9D9D94D
  static const Color topDarkGrey = Color(0xff484848); //#D9D9D94D
  static const Color introGrey = Color(0xffA2ADB5); //#A2ADB5

  ///////////// below are old
  static const Color appBarColor = Color(0xff013D68);
  static const Color mainLightGreenBackGround = Color(0xffe5ecd2);
  static const Color lightGreen = Color(0xffA7C068);
  static const Color lightRed = Color(0xffFF4C38);
  static const Color sideTitle = Color(0xff666462);
  // static const Color lightGray = Color(0xffDADADA);
  static const Color medGray = Color(0xffE6E8DC);
  static const Color greyWhite = Color(0xffF6F6F6);
  static const Color pinkWhite = Color(0xffF9F6F4);

  static const Color txtField = Color(0xffD9D94D); //#D9D9D94D

  ////////////////////////////////////////////////
  ///To turn any color to material.
////////////////////////////////////////////////
  static Map<int, Color> color = {
    50: Color.fromRGBO(9, 78, 143, 0.1),
    100: Color.fromRGBO(9, 78, 143, 0.2),
    200: Color.fromRGBO(9, 78, 143, 0.3),
    300: Color.fromRGBO(9, 78, 143, 0.4),
    400: Color.fromRGBO(9, 78, 143, 0.5),
    500: Color.fromRGBO(9, 78, 143, 0.6),
    600: Color.fromRGBO(9, 78, 143, 0.7),
    700: Color.fromRGBO(9, 78, 143, 0.8),
    800: Color.fromRGBO(9, 78, 143, 0.9),
    900: Color.fromRGBO(9, 78, 143, 1),
    // 600: Color.fromRGBO(9, 78, 143, 0.6),
    // 700: Color.fromRGBO(9, 78, 143, 0.6),
    // 800: Color.fromRGBO(9, 78, 143, 0.6),
    // 900: Color.fromRGBO(9, 78, 143, 0.6),
  };

  static MaterialColor appColor = MaterialColor(0xff013D68, color);
  static const String FONT_AR = 'AR';
  static const String FONT_EN = 'EN';
}
