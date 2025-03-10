// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Are You Sure!',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'You want to sign out?',
            textAlign: TextAlign.center,
            textScaleFactor: 1.0,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: CustomTheme.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: 85,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: CustomTheme.primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(context);
                      },
                      child: Text(
                        'no'.tr,
                        textScaleFactor: 1.0,
                        style: TextStyle(color: CustomTheme.primaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  width: 85,
                  padding: EdgeInsets.all(5),
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
                            : null ;
                        _handlesignOut(context);
                      },
                      child: Text(
                        'yes'.tr,
                        textScaleFactor: 1.0,
                        style: TextStyle(color: white),
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
    apiService.post(apiRoutes['logout']!, '').then((value) async{
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
      prefs.setString('welcome','1');
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
