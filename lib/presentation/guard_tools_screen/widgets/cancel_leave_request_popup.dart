import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/guard_tools_screen/guard_tools_screen.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CancelLeaveRequest extends StatelessWidget {
  String leaveId;
  CancelLeaveRequest({super.key, required this.leaveId});

  void deleteLeaveRequest(leaveId,context) async {
    var commonService = CommonService();
     String apiUrl = baseUrl + apiRoutes['leaveRequestCancel']!;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    try {
      EasyLoading.show();
      Map<String, dynamic> myJsonBody = {"leave_id": leaveId};
      print(myJsonBody.toString());
      Response response = await post(Uri.parse(apiUrl),body: myJsonBody,headers: myHeader);
      print(response.body.toString());
      var data = jsonDecode(response.body.toString());
      print(data);
      if(response.statusCode == 200) {
        print("-----------> ${response}");
        commonService.openSnackBar(data['message'] ?? data['error'],context);
        screenReplaceNavigator(context, GuardToolScreen());
                      // Navigator.of(context).pop();
      }
      else{
        EasyLoading.dismiss();
        EasyLoading.showInfo(data['message'] ?? data['error']);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("leave_id ========> ${leaveId}");
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        height: 138.h,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 218.w,
                child: Text(
                  'Are you sure you want to cancel leave request ?',
                  style: CustomTheme.blackTextStyle(14.sp),
                  // AppFontStyle.mediumTextStyle(AppColors.black, 14.sp)
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      deleteLeaveRequest(leaveId,context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          border: Border.all(
                              width: 0.2, color: AppColors.grayColor),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(5.r, 5.r))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      child: Text("Yes",
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp)),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      child: Text(
                        "No",
                        style: CustomTheme.blackTextStyle(13.sp),
                        // TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    //  AlertDialog(
    //   title:
    //       const Text('Are you sure you want to cancel leave request ?', textScaleFactor: 1.0),
    //   actionsAlignment: MainAxisAlignment.spaceEvenly,
    //   actions: [
    //     GestureDetector(
    //       onTap: () {
    //         Navigator.pop(context, false);
    //       },
    //       child: Container(
    //         height: 30.h,
    //         width: 40.w,
    //         alignment: AlignmentDirectional.center,
    //         decoration: BoxDecoration(
    //             color: AppColors.primaryColor, borderRadius: BorderRadius.circular(4)),
    //         child: const Text(
    //           "No",
    //           textScaleFactor: 1.0,
    //           style: TextStyle(
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     ),
    //     GestureDetector(
    //       onTap: () {

    //       },
    //       child: Container(
    //         height: 30,
    //         width: 40,
    //         alignment: AlignmentDirectional.center,
    //         // padding: const EdgeInsets.only(
    //         //   top: 12,
    //         //   left: 20,
    //         // ),
    //         decoration: BoxDecoration(
    //             color: Colors.blue, borderRadius: BorderRadius.circular(4)),
    //         child: const Text(
    //           "Yes",
    //           textScaleFactor: 1.0,
    //           style: TextStyle(
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
