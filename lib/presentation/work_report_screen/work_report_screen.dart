import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/work_report_screen/cubit/report_type/report_type_cubit.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen/emergency_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/general_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/maintenance_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/parking_report_screen.dart';
import '../../helper/navigator_function.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';
import 'widget/report_submit_success.dart';

class WorkReportScreen extends StatefulWidget {
  const WorkReportScreen({super.key});

  @override
  State<WorkReportScreen> createState() => _WorkReportScreenState();
}

class _WorkReportScreenState extends State<WorkReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: 'Shift Report'),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Select report type below',
                style: CustomTheme.blueTextStyle(17, FontWeight.bold),
                textScaleFactor: 1.0,
              ),
              SizedBox(
                height: 25.h,
              ),
              InkWell(
                onTap: () {
                  screenNavigator(context, GeneralReportScreen());

                  context.read<ReportTypeCubit>().clickGreport();
                },
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      color: seconderyMediumColor,
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
                  screenNavigator(context, MaintenanceReportScreen());

                  context.read<ReportTypeCubit>().clickMreport();
                },
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      'Maintenance Report',
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
                  screenNavigator(context, ParkingReportScreen());

                  context.read<ReportTypeCubit>().clickPreport();
                },
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      'Parking Report',
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
                  screenNavigator(context, EmergencyReportScreen());

                  context.read<ReportTypeCubit>().clickEreport();
                },
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      'Emergency Report',
                      style: TextStyle(
                        color: primaryColor,
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
        height: 100.h,
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
                    onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
