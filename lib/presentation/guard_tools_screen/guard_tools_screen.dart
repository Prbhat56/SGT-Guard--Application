import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/utils/const.dart';
import '../map_screen/active_map_screen.dart';
import '../qr_screen/scanning_screen.dart';
import '../time_sheet_screen/time_sheet_screen.dart';
import '../time_sheet_screen/missed_shift_screen.dart';
import '../work_report_screen/emergency_report_screen/emergency_report_screen.dart';
import '../work_report_screen/general_report_screen.dart';
import '../work_report_screen/maintenance_report_screen.dart';
import '../work_report_screen/parking_report_screen.dart';
import 'widgets/leave_status_screen.dart';

class GuardToolScreen extends StatelessWidget {
  const GuardToolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 40,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/guard_logo.svg'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Guard Tools",
                    style: TextStyle(color: black, fontSize: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: Divider(
                color: seconderyColor,
                thickness: 2,
                height: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ScanningScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/qr.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Scan Checkpoint',
                            style: TextStyle(fontSize: 17, color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LeaveStatusScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/close.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Leave Status',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const TimeSheetScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/event_upcoming.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Upcoming Shifts',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ActiveMapScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/add_location.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Active Property Map View',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const MissedShiftScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/call_missed.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Missed Shifts',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const GeneralReportScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/report.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'General Report',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const MaintenanceReportScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/report.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Maintenance Report',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ParkingReportScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/report.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Parking Report',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const EmergencyReportScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/report.svg',
                            width: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Emergency Report',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return const NotificationScreen();
                  //     }));
                  //   },
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       SvgPicture.asset(
                  //         'assets/message_notification.svg',
                  //         width: 17,
                  //       ),
                  //       SizedBox(
                  //         width: 15,
                  //       ),
                  //       Text(
                  //         'Message Notification',
                  //         style: TextStyle(
                  //           fontSize: 17,
                  //           color: primaryColor,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
