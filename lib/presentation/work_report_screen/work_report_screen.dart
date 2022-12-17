import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/general_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/maintenance_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/parking_report_screen.dart';

import '../../utils/const.dart';

class WorkReportScreen extends StatefulWidget {
  const WorkReportScreen({super.key});

  @override
  State<WorkReportScreen> createState() => _WorkReportScreenState();
}

class _WorkReportScreenState extends State<WorkReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Submit Report',
          textScaleFactor: 1.0,
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        ),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                'Select report type below',
                style: TextStyle(
                    color: black, fontSize: 17.sp, fontWeight: FontWeight.bold),
                textScaleFactor: 1.0,
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const GeneralReportScreen();
                  }));
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryColor)),
                  child: Center(
                    child: Text(
                      'General Report',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                      ),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MaintenanceReportScreen();
                  }));
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: const Center(
                    child: Text(
                      'Maintenance Report',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ParkingReportScreen();
                  }));
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: const Center(
                    child: Text(
                      'Parking Report',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const EmergencyReportScreen();
                  }));
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: const Center(
                    child: Text(
                      'Emergency Report',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 130,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Center(
                child: CupertinoButton(
                    disabledColor: seconderyColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 15),
                    color: primaryColor,
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const Home();
                      }));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
