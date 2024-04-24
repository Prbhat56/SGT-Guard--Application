import 'package:flutter/material.dart';

class AppColors {

  
  static const primaryColor = Color(0xFF244B8A);
  static const white = Colors.white;
  static const black = Color(0xFF222222);
  static const textColor = Color(0xFF333333);
  static const disableColor = Color(0xFFD8D8DC);
  static const greenColor = Color(0xFF3FBC69);
  static const secondaryColor = Color(0xFF999999);
  static const grayColor = Color(0xFF7E8299);
  static const lightPrimaryColor = Color(0xFF1E293B);
  static const redColor = Color(0xFFEA5455);
  static const primaryBackColor = Color(0xFFD3DBE8);
  static const hintColor = Color(0xFFCCCCCC);
  static const backgroundColor = Color(0xFFF5F6F9);

  static const MaterialColor kThemeColor = MaterialColor(
    0xFF244B8A, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF244B8A), //10%
      100: Color(0xFF244B8A), //20%
      200: Color(0xFF244B8A), //30%
      300: Color(0xFF244B8A), //40%
      400: Color(0xFF244B8A), //50%
      500: Color(0xFF244B8A), //60%
      600: Color(0xFF244B8A), //70%
      700: Color(0xFF244B8A), //80%
      800: Color(0xFF244B8A), //90%
      900: Color(0xFF244B8A), //100%
    },
  );
}
