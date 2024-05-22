import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/time_sheet_screen/upcoming_screen.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/font_style.dart';
import 'package:sgt/utils/const.dart';
import '../map_screen/active_map_screen.dart';
import '../qr_screen/scanning_screen.dart';
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
              padding: const EdgeInsets.only(top: 5.0, right: 10),
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
                        size: 20.sp,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/guard_logo.svg',
                    width: 24.w,
                    height: 35.h,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    "Guard Tools",
                    style: TextStyle(color: black, fontSize: 30.sp),
                    // AppFontStyle.mediumTextStyle(AppColors.black, 25.sp),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: Divider(
                color: seconderyColor,
                thickness: 2.w,
                height: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Column(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return const ScanningScreen();
                  //     }));
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: seconderyMediumColor,
                  //         borderRadius: BorderRadius.circular(10)),
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         SvgPicture.asset(
                  //           'assets/qr.svg',
                  //           width: 17,
                  //         ),
                  //         SizedBox(
                  //           width: 15,
                  //         ),
                  //         Text(
                  //           'Scan Checkpoint',
                  //           style: TextStyle(fontSize: 17, color: primaryColor),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
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
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/add_location.svg',
                            width: 17.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'active_property_map_view'.tr,
                            style:
                                // AppFontStyle.mediumTextStyle(
                                //     AppColors.primaryColor, 17.sp),
                                TextStyle(
                              fontSize: 17.sp,
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
                        return GeneralReportScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/report.svg',
                            width: 17.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'general_report'.tr,
                            style:
                                // AppFontStyle.mediumTextStyle(
                                //     AppColors.primaryColor, 17.sp),
                                TextStyle(
                              fontSize: 17.sp,
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
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/maintanance_report.svg',
                            width: 17.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'maintanance_report'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: primaryColor,
                            ),
                            //  AppFontStyle.mediumTextStyle(
                            //     AppColors.primaryColor, 17.sp),
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
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/parking_report.svg',
                            width: 17.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'parking_report'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: primaryColor,
                            ),
                            // AppFontStyle.mediumTextStyle(
                            //     AppColors.primaryColor, 17.sp),
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
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/emergency_report.svg',
                            width: 17.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'emergency_report'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: primaryColor,
                            ),
                            // AppFontStyle.mediumTextStyle(
                            //     AppColors.primaryColor, 17.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return UpcomingThimeSheet(); //TimeSheetScreen();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // color: seconderyMediumColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/event_upcoming.svg',
                            width: 17.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'upcoming_shift'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: primaryColor,
                            ),
                            // AppFontStyle.mediumTextStyle(
                            //     AppColors.primaryColor, 17.sp),
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
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/call_missed.svg',
                            width: 17.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'missed_shifts'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: primaryColor,
                            ),
                            // AppFontStyle.mediumTextStyle(
                            //     AppColors.primaryColor, 17.sp),
                          ),
                        ],
                      ),
                    ),
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
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/close.svg',
                            width: 17.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'leave_status'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: primaryColor,
                            ),
                            // AppFontStyle.mediumTextStyle(
                            //     AppColors.primaryColor, 17.sp),
                          ),
                        ],
                      ),
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
