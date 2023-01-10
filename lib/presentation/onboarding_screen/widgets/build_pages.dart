import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/utils/const.dart';

class BuildPages extends StatelessWidget {
  const BuildPages(
      {super.key,
      required this.imageUrl,
      required this.iconImage,
      required this.smallText,
      required this.bigText,
      required this.descriptionText});
  final String imageUrl;
  final String iconImage;
  final String smallText;
  final String bigText;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 45.h,
            ),
            Image.asset(
              imageUrl,
              // fit: BoxFit.cover,
              height: 270.h,
              width: double.infinity,
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(child: Image.asset(iconImage)),
            ),
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Text(
                smallText,
                style: TextStyle(fontSize: 15, color: primaryColor),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Center(
              child: Text(
                bigText,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  descriptionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                  textScaleFactor: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
