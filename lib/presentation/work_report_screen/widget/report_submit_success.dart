import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sgt/theme/custom_theme.dart';

class ReportSubmitSuccess extends StatefulWidget {
  const ReportSubmitSuccess({super.key});

  @override
  State<ReportSubmitSuccess> createState() => _ReportSubmitSuccessState();
}

class _ReportSubmitSuccessState extends State<ReportSubmitSuccess> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: 279.w,
          height: 274.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: SvgPicture.asset(
                'assets/green_tick.svg',
                height: 66.h,
              )),
              SizedBox(
                height: 15.h,
              ),
              Text('done'.tr,
                  textAlign: TextAlign.center,
                  style: CustomTheme.blackTextStyle(25.sp)),
              SizedBox(
                height: 20.h,
              ),
              Text('Report has been sent\n successfully!',
                  textAlign: TextAlign.center,
                  style: CustomTheme.blackTextStyle(17.sp))
            ],
          )),
    );
  }
}
