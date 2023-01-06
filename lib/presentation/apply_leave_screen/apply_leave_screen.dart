import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/utils/const.dart';
import 'widgets/custom_calender.dart';

class ApplyLeaveScreen extends StatelessWidget {
  const ApplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            'Apply Leave',
            textScaleFactor: 1.0,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600)),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leave From',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: seconderyColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Date',
                        style: TextStyle(color: primaryColor, fontSize: 12),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: primaryColor,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                CustomCalenderWidget(),
                Text(
                  'To',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: seconderyColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Date',
                        style: TextStyle(color: primaryColor, fontSize: 12),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: primaryColor,
                      )
                    ],
                  ),
                ),
                CustomCalenderWidget(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Term & Conditions',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8, right: 6),
                        height: 3,
                        width: 3,
                        color: black,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur  elit. Etiam eu turpis',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8, right: 6),
                        height: 3,
                        width: 3,
                        color: black,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur  elit. Etiam eu turpis',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8, right: 6),
                        height: 3,
                        width: 3,
                        color: black,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur  elit. Etiam eu turpis',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8, right: 6),
                        height: 3,
                        width: 3,
                        color: black,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur  elit. Etiam eu turpis',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8, right: 6),
                        height: 3,
                        width: 3,
                        color: black,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur  elit. Etiam eu turpis',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CupertinoButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 126.w, vertical: 15),
                    color: primaryColor,
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const VerificationScreen();
                      // }));
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
