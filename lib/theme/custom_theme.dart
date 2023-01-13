import 'package:flutter/material.dart';

class CustomTheme {
  //app all colors
  static const Color primaryColor = Color(0xFF254993);
  static const Color seconderyColor = Color(0xFFBBD6FF);
  static const Color seconderyLightColor = Color(0xFFF5F9FF);
  static const Color seconderyMediumColor = Color(0xFFE1EBFF);
  static const Color greenColor = Color(0xFF4CD464);
  static const Color blueColor = Color(0xFF0072FF);
  static const Color grey = Color(0xFFE4E4E4);
  static const Color black = Colors.black;
  static const Color white = Colors.white;

//fontsize of the text for the app
  static const Map<String, double> fontsize = {
    "sm": 12,
    "md1": 15,
    "md2": 17,
    "lg1": 25,
    "lg2": 35,
  };

//styling of the small green online indecator dot
  static onlineIndecatorStyle() {
    return BoxDecoration(
      color: greenColor,
      border: Border.all(color: white, width: 2),
      borderRadius: BorderRadius.circular(50),
    );
  }

//home screen see all button style
  static var seeAllBtnStyle = TextStyle(
    color: Colors.blue,
    fontSize: fontsize['sm'],
    fontWeight: FontWeight.bold,
  );

//home screen location details card styling
  static locationCardStyle(String imageUrl) {
    return BoxDecoration(
      image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageUrl)),
      borderRadius: BorderRadius.circular(20),
      color: grey,
    );
  }

//textfield heading text style
  static var textField_Headertext_Style = TextStyle(
    fontSize: 17,
    color: primaryColor,
    fontWeight: FontWeight.w500,
  );

//black text style
  static blackTextStyle(double fontsize) {
    return TextStyle(
        fontSize: fontsize, fontWeight: FontWeight.w400, color: black);
  }

//grey text style
  static greyTextStyle(double fontsize) {
    return TextStyle(
        fontSize: fontsize, fontWeight: FontWeight.w400, color: Colors.grey);
  }

//blue text style
  static blueTextStyle(double fontsize, FontWeight fontweight) {
    return TextStyle(
        fontSize: fontsize, color: primaryColor, fontWeight: fontweight);
  }

//box shadow for map card
  static const mapCardShadow = [
    BoxShadow(
      color: Color.fromARGB(255, 195, 195, 195),
      offset: Offset(1.5, 1.5),
      blurRadius: 2.5,
      spreadRadius: 2,
    ),
    BoxShadow(
      color: Colors.grey,
      offset: Offset(1.5, 1.5),
      blurRadius: 1.5,
      spreadRadius: 0.5,
    ),
  ];

//custom tabbar theme
  static var tabBarTheme = ThemeData(
    tabBarTheme: TabBarTheme(
      labelColor: black,
      unselectedLabelColor: Colors.grey,
    ),
    indicatorColor: primaryColor,
  );

  static final clockInCardStyle = BoxDecoration(
    color: seconderyLightColor,
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(
        color: Color.fromARGB(255, 216, 216, 216),
        offset: Offset(0, 20),
        blurRadius: 20,
        spreadRadius: 0.1,
      ),
    ],
  );
}
