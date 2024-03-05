import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/home.dart';
import '../../utils/const.dart';

class ReportSuccessScreen extends StatefulWidget {
  const ReportSuccessScreen({super.key, required this.isSubmitReportScreen});
  final bool isSubmitReportScreen;
  @override
  State<ReportSuccessScreen> createState() => _ReportSuccessScreenState();
}

class _ReportSuccessScreenState extends State<ReportSuccessScreen> {
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
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.check_circle,
                    color: const Color.fromRGBO(76, 217, 100, 1),
                    size: 60,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    widget.isSubmitReportScreen ? "Confirmed" : "Done",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    widget.isSubmitReportScreen
                        ? "Checkpoint Completed\n Successfull!"
                        : "Report has been sent\n successfully!",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 220.h,
                ),
                widget.isSubmitReportScreen
                    ? Center(
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 120.w, vertical: 15),
                          color: primaryColor,
                          child: const Text(
                            'Next',
                            textScaleFactor: 1.0,
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const Home();
                            }));
                          },
                        ),
                      )
                    : Container(),
              ]),
        ),
      ),
    );
  }
}
