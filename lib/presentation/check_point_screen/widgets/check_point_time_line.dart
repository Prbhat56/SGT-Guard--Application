import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/utils/const.dart';

class CheckPointTimeLineWidget extends StatefulWidget {
  List<Checkpoint>? checkPointLength;
  CheckPointTimeLineWidget({super.key, this.checkPointLength});

  @override
  State<CheckPointTimeLineWidget> createState() =>
      _CheckPointTimeLineWidgetState();
}

class _CheckPointTimeLineWidgetState extends State<CheckPointTimeLineWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: Column(
        children: [
          Text(
            'start'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp),
          ),
          Container(
            height: 70.h * widget.checkPointLength!.length.toDouble(),
            width: 30.w * widget.checkPointLength!.length.toDouble(),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.checkPointLength!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            index == 0
                                ? Container(
                                    margin:
                                        EdgeInsets.only(top: 10.h, bottom: 3.h),
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: seconderyColor,
                                            offset: Offset(0, 0),
                                            blurRadius: 10.r,
                                            spreadRadius: 4.r,
                                          ),
                                        ],
                                        border: Border.all(
                                            color: primaryColor, width: 2.w),
                                        borderRadius:
                                            BorderRadius.circular(50.r)),
                                    child: Container(
                                      height: 8.h,
                                      width: 8.w,
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50.r)),
                                    ),
                                  )
                                : Container(
                                    height: 8.h,
                                    width: 8.w,
                                    margin: EdgeInsets.all(7.w),
                                    decoration: BoxDecoration(
                                        color: seconderyColor,
                                        borderRadius:
                                            BorderRadius.circular(50.r)),
                                  ),
                            index == widget.checkPointLength!.length - 1
                                ? Container()
                                : Container(
                                    height: 45.h,
                                    child: VerticalDivider(
                                      color: primaryColor,
                                      thickness: 2.w,
                                    ))
                          ],
                        ),
                      ),
                      Positioned(
                        right: 20.w,
                        top: 5.h,
                        child: Text(
                          'CP ${index+1}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
