import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShouldPopAlertDialog extends StatelessWidget {
  const ShouldPopAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text('Are you sure,You want to exit the app ?', textScaleFactor: 1.0,textAlign: TextAlign.center,style: TextStyle(fontSize: 17.sp),),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context, false);
          },
          child: Container(
            height: 30.h,
            width: 40.w,
            alignment: AlignmentDirectional.center,
            // padding: const EdgeInsets.only(
            //   top: 6,
            //   left: 15,
            // ),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(4.r)),
            child:Text(
              'no'.tr,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (Platform.isAndroid) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            } else {
              // MinimizeApp.minimizeApp();
            }
          },
          child: Container(
            height: 30.h,
            width: 40.w,
            alignment: AlignmentDirectional.center,
            // padding: const EdgeInsets.only(
            //   top: 12,
            //   left: 20,
            // ),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(4.r)),
            child: Text(
              'yes'.tr,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
