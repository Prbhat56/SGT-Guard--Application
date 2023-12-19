import 'package:flutter/material.dart';

Color greenColor = const Color(0xFF4CD464);
Color primaryColor = const Color(0xFF254993);
Color seconderyColor = const Color(0xFFBBD6FF);
Color seconderyLightColor = const Color(0xFFF5F9FF);
Color seconderyMediumColor = const Color(0xFFE1EBFF);
Color blueColor = Color(0xFF0072FF);
Color black = Colors.black;
Color white = Colors.white;
Color grey = const Color(0xFFE4E4E4);

extension Capitalized on String {
  String capitalized() =>
      this.substring(0, 1).toUpperCase() + this.substring(1).toLowerCase();
}
