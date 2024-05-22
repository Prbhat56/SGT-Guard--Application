// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/clocked_in_out_screen/widget/check_point_count_widget.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  const SignOutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              child: SvgPicture.asset('assets/exclaimation_round.svg',width: 34.w,),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            textAlign: TextAlign.center,
            'Your shift is not completed.\n Tasks are pending.',
            style: AppFontStyle.mediumTextStyle(AppColors.primaryColor,15.sp),
            // TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500,color: AppColors.primaryColor),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Are you sure, You want log out ?',
            textAlign: TextAlign.center,
            textScaleFactor: 1.0,
            style: AppFontStyle.regularTextStyle(AppColors.primaryColor,15.sp),
            // TextStyle(fontSize: 15, color: AppColors.primaryColor),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: CheckPointCountWidget(
            completedCheckPoint:
                '4',
            remainningCheckPoint:
                '3',
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Divider(
              color: CustomTheme.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: 101.w,
                  // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: CustomTheme.primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.0,
                        style: AppFontStyle.mediumTextStyle(AppColors.primaryColor,13.sp),
                        // TextStyle(color: CustomTheme.primaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
                Container(
                  height: 40.h,
                  width: 1.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
                Container(
                  width: 101.w,
                  // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: CustomTheme.primaryColor,
                    border: Border.all(color: CustomTheme.primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        context.read<TimerOnCubit>().state.istimerOn
                            ? context.read<TimerOnCubit>().turnOffTimer()
                            : null;
                        _handlesignOut(context);
                      },
                      child: Text(
                        'Log Out',
                        softWrap: false,
                        textScaleFactor: 1.0,
                        style: AppFontStyle.mediumTextStyle(AppColors.white,13.sp),
                        // TextStyle(color: white,fontSize: 13.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handlesignOut(context) {
    // Map<String, dynamic> routes = {'/login': (context) => SignInScreen()};
    var apiService = ApiCallMethodsService();
    apiService.post(apiRoutes['logout']!, '').then((value) async {
      apiService.updateUserDetails('');
      var commonService = CommonService();
      //Map<String, dynamic> jsonMap = json.decode(value);
      //commonService.openSnackBar(jsonMap['message'],context);
      // commonService.clearLocalStorage();
      FirebaseHelper.signOut();
      FirebaseHelper.auth = FirebaseAuth.instance;
      commonService.logDataClear();
      commonService.clearLocalStorage();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('welcome', '1');
      // screenNavigator(context, SignInScreen());

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (route) => false,
      );
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
