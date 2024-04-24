import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlexibleText {
   // static FlexibleText(
  //     String text,TextStyle textStyle) {
  //   return Flexible(
  //     flex: 1,
  //     child: Text(
  //       text.toString(),
  //       overflow: TextOverflow.ellipsis,
  //       style: textStyle,
  //     ),
  //   );
  // }
  static TextStyle _textStyle(
      Color color, double size, FontWeight fontWeight, TextOverflow overflow) {
    return GoogleFonts.montserrat(
        color: color, fontSize: size, fontWeight: fontWeight);
  }

  static lightTextStyle(Color color, double size) {
    return _textStyle(color, size, FontWeight.w300, TextOverflow.ellipsis);
  }

  static regularTextStyle(Color color, double size) {
    return _textStyle(color, size, FontWeight.w400, TextOverflow.ellipsis);
  }

  static mediumTextStyle(Color color, double size) {
    return _textStyle(color, size, FontWeight.w500, TextOverflow.ellipsis);
  }

  static semiboldTextStyle(Color color, double size) {
    return _textStyle(color, size, FontWeight.w600, TextOverflow.ellipsis);
  }

  static boldTextStyle(Color color, double size) {
    return _textStyle(color, size, FontWeight.w700, TextOverflow.ellipsis);
  }
}
