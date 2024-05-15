import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/verify_otp.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sgt/service/globals.dart';

var user = userDetail;

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({super.key});

  @override
  _ShareLocationScreenState createState() => new _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  var commonService = CommonService();
  @override
  void initState() {
    super.initState();
  }

  Future<Position> _determinePosition(context) async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        // print("position ====> $position");
        var map = new Map<String, dynamic>();
        map['latitude'] = position.latitude.toString();
        map['longitude'] = position.longitude.toString();
        map['notification_status'] = '0';
        var apiService = ApiCallMethodsService();
        apiService.post(apiRoutes['profileUpdate']!, map).then((value) {
          Navigator.of(context).pop();
          apiService.updateUserDetails(value);
          screenNavigator(context, Home());
        }).onError((error, stackTrace) {
          Navigator.of(context).pop();
          print(error);
          commonService.openSnackBar(error.toString(), context);
        });
      }
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        commonService.openSnackBar('Location Not Available', context);
        screenNavigator(context, Home());
        // return Future.error('Location Not Available');
      }
    } else {
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print("position ====> $position");
        var map = new Map<String, dynamic>();
        map['latitude'] = position.latitude.toString();
        map['longitude'] = position.longitude.toString();
        var apiService = ApiCallMethodsService();
        apiService.post(apiRoutes['profileUpdate']!, map).then((value) {
          Navigator.of(context).pop();
          apiService.updateUserDetails(value);
          screenNavigator(context, Home());
        }).onError((error, stackTrace) {
          print(error);
          commonService.openSnackBar(error.toString(), context);
          Navigator.of(context).pop();
        });
      } else {
        throw Exception('Error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 46.h,
                  ),
                  SvgPicture.asset('assets/share_location.svg'),
                  // Image.asset('assets/share_location.svg'),
                  SizedBox(height: 50.h),
                  Text(
                    'Hello!',
                    style:
                        TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Share your location to get started with your services',
                    style: TextStyle(
                        color: AppColors.primaryColor, fontSize: 17.sp),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    textAlign: TextAlign.center,
                    'We only access your location while you are using this incredible app',
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 37.w, vertical: 25.h),
            child: Container(
              width: 300.w,
              child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  color: CustomTheme.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.near_me,
                        color: AppColors.white,
                      ),
                      SizedBox(width:10.w,),
                      Text(
                        'Share Location',
                        style:
                            TextStyle(fontSize: 12.sp, color: AppColors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // screenNavigator(context,Home());
                    _determinePosition(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const Home();
                    // }));
                  }),
            )),
      ),
      //  child: Scaffold(
      //   body: SafeArea(
      //     child: SingleChildScrollView(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 30),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const SizedBox(
      //               height: 30,
      //             ),
      //             Image.asset('assets/icon_marker.png'),
      //             const SizedBox(height: 20),
      //             const Text(
      //               'Hello,and\nWelcome',
      //               style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      //             ),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //             const Text(
      //               'Share your location to get started with your services',
      //               style: TextStyle(color: Colors.grey, fontSize: 20),
      //             ),
      //             const SizedBox(height: 20),
      //             const Text(
      //               'We only access your location while you are using this incredible app',
      //               style: TextStyle(fontSize: 17, color: Colors.grey),
      //             ),
      //             const SizedBox(
      //               height: 50,
      //             ),
      //             Center(
      //               child: CupertinoButton(
      //                   disabledColor: seconderyColor,
      //                   padding: const EdgeInsets.symmetric(
      //                       horizontal: 50, vertical: 5),
      //                   color: primaryColor,
      //                   child: ListTile(
      //                     leading: Icon(
      //                       Icons.near_me,
      //                       color: white,
      //                     ),
      //                     title: Text(
      //                       'Share location',
      //                       style: TextStyle(fontSize: 17, color: white),
      //                     ),
      //                   ),
      //                   onPressed: () {
      //                     // screenNavigator(context,Home());
      //                     _determinePosition(context);
      //                     // Navigator.push(context,
      //                     //     MaterialPageRoute(builder: (context) {
      //                     //   return const Home();
      //                     // }));
      //                   }),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
