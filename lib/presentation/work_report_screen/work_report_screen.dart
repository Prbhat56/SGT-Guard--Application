import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/work_report_screen/cubit/report_type/report_type_cubit.dart';
import 'package:sgt/presentation/work_report_screen/general_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/allWorkReport/static_emergency_report.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/allWorkReport/static_general_report.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/allWorkReport/static_maintenance_report.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/allWorkReport/static_parking_report.dart';
import '../../helper/navigator_function.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';

class WorkReportScreen extends StatefulWidget {
  String? propertyName;
  String? propertyId;
  WorkReportScreen({super.key, this.propertyName, this.propertyId});

  @override
  State<WorkReportScreen> createState() => _WorkReportScreenState();
}

class _WorkReportScreenState extends State<WorkReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: 'shift_report'.tr),
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
                'select_report_type_text'.tr,
                style: CustomTheme.blueTextStyle(17, FontWeight.bold),
                textScaleFactor: 1.0,
              ),
              SizedBox(
                height: 25.h,
              ),
              InkWell(
                onTap: () {
                  screenNavigator(
                      context,
                      StaticGeneralReportScreen(
                          propId: widget.propertyId,
                          propName: widget.propertyName));
                  context.read<ReportTypeCubit>().clickGreport();
                },
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      'general_report'.tr,
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
                  screenNavigator(
                      context,
                      StaticMaintenanceReportScreen(
                          propId: widget.propertyId,
                          propName: widget.propertyName));
                  context.read<ReportTypeCubit>().clickMreport();
                },
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      'maintanance_report'.tr,
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
                  screenNavigator(
                      context,
                      StaticParkingReportScreen(
                          propId: widget.propertyId,
                          propName: widget.propertyName));

                  context.read<ReportTypeCubit>().clickPreport();
                },
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      'parking_report'.tr,
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
                  screenNavigator(
                      context,
                      StaticEmergencyReportScreen(
                          propId: widget.propertyId,
                          propName: widget.propertyName));

                  context.read<ReportTypeCubit>().clickEreport();
                },
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      'emergency_report'.tr,
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
                    child: Text(
                      'next'.tr,
                      style: TextStyle(fontSize: 20),
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      screenNavigator(context, GeneralReportScreen());
                      context.read<ReportTypeCubit>().clickGreport();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
