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
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 45.h,
            ),
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: 270.h,
              width: double.infinity,
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 50.h,
              width: 55.w,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(child: Image.asset(iconImage)),
            ),
            SizedBox(
              height: 18.h,
            ),
            Text(
              smallText,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 20.sp, color: primaryColor),
              ),
              textScaleFactor: 1.0,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              bigText,
              style: GoogleFonts.montserrat(
                textStyle:
                    TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
              ),
              textScaleFactor: 1.0,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              descriptionText,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 17.sp, color: Colors.grey),
              ),
              textScaleFactor: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
