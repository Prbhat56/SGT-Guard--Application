import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/utils/const.dart';

import '../map_screen/active_map_screen.dart';
import '../notification_screen/notification_screen.dart';
import '../qr_screen/qr_screen.dart';
import '../time_sheet_screen/time_sheet_screen.dart';
import '../time_sheet_screen/widgets/missed_shift_screen.dart';
import '../work_report_screen/emergency_report_screen.dart';
import '../work_report_screen/general_report_screen.dart';
import '../work_report_screen/maintenance_report_screen.dart';
import '../work_report_screen/parking_report_screen.dart';

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
              padding: const EdgeInsets.only(top: 50.0, right: 10),
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
                        size: 30,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Guard Tools",
                    style: TextStyle(color: black, fontSize: 30),
                  ),
                ],
              ),
            ),
            Divider(
              color: seconderyColor,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const QrScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/qr.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Scan Checkpoint',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const GeneralReportScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/report.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'General Report',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const MaintenanceReportScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/report.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Maintenance Report',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ParkingReportScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/report.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Parking Report',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const EmergencyReportScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/report.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Emergency Report',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const TimeSheetScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/event_upcoming.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Upcoming Shifts',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const NotificationScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/message_notification.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Message Notification',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ActiveMapScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/add_location.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Active Property Map View',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const MissedShiftScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/call_missed.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Missed Shifts',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const GeneralReportScreen();
                      }));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/close.svg',
                          width: 17,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text(
                          'Cancelled Shifts',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
