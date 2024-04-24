import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';

//custom class to provide different size of circular images
class CustomCircularImage {
  //widge† for showing circularImage
  static Widget getCircularImage(
    String baseUrl,
    String imageUrl,
    bool isOnline,
    double radius,
    double bottom,
    double left,
  ) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: grey,
          backgroundImage: NetworkImage(baseUrl + '' + imageUrl),
        ),
        Positioned(
          bottom: bottom,
          left: left,
          child: isOnline
              ? Container(
                  height: 15.h,
                  width: 15.w,
                  decoration: CustomTheme.onlineIndecatorStyle(),
                )
              : Container(),
        )
      ],
    );
  }

//widge† for large size circularImage
  static getlgCircularImage(String baseUrl, String imageUrl, bool isActive) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 35.r,
          backgroundColor: grey,
          backgroundImage: NetworkImage(baseUrl + imageUrl),
        ),
        isActive
            ? Positioned(
                top: 47.h,
                left: 54.w,
                child: Container(
                  height: 17.h,
                  width: 17.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: white, width: 3.w),
                    color: greenColor,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
