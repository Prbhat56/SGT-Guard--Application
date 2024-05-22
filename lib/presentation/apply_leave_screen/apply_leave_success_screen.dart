import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/guard_tools_screen/widgets/leave_status_screen.dart';
import 'package:sgt/presentation/settings_screen/settings_screen.dart';
import 'package:sgt/theme/custom_theme.dart';

class ApplyLeaveSuccess extends StatefulWidget {
  const ApplyLeaveSuccess({super.key});

  @override
  State<ApplyLeaveSuccess> createState() => _ApplyLeaveSuccessState();
}

class _ApplyLeaveSuccessState extends State<ApplyLeaveSuccess> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      // Navigator.pop(context);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => SettingsScreen()),(route) => false,).then((value) => setState(() {}));
      // screenReplaceNavigator(context, LeaveStatusScreen());
        Navigator.of(context)..pop()..pop()..pop()..pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 318.w,
        height: 318.h,
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
            Text('Sent\nSuccessfully',
                textAlign: TextAlign.center,
                style: CustomTheme.blackTextStyle(25.sp)),
            SizedBox(
              height: 20.h,
            ),
            Text('Wait for approval!', style: CustomTheme.blackTextStyle(17.sp))
          ],
        ),
      ),
    );
  }
}
