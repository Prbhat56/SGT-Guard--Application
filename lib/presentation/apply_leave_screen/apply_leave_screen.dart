import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/utils/const.dart';
import 'widgets/custom_calender.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  bool leaveFromclicked = false;
  bool leaveToclicked = false;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Apply Leave'),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
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
                InkWell(
                  onTap: () {
                    setState(() {
                      leaveFromclicked = !leaveFromclicked;
                    });
                  },
                  child: Container(
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
                ),
                SizedBox(
                  height: 6,
                ),
                leaveFromclicked ? CustomCalenderWidget() : Container(),
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
                InkWell(
                  onTap: () {
                    setState(() {
                      leaveToclicked = !leaveToclicked;
                    });
                  },
                  child: Container(
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
                ),
                leaveToclicked ? CustomCalenderWidget() : Container(),
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
