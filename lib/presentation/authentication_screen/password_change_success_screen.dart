import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import '../../theme/custom_theme.dart';

class PasswordChangeSuccessScreen extends StatefulWidget {
  const PasswordChangeSuccessScreen({super.key});

  @override
  State<PasswordChangeSuccessScreen> createState() =>
      _PasswordChangeSuccessScreenState();
}

class _PasswordChangeSuccessScreenState
    extends State<PasswordChangeSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      // Navigator.pop(context);
      // screenReplaceNavigator(context, SignInScreen());
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (route) => false,
      );
      // Navigator.of(context)..pop()..pop()..pop(); // ScreenUntill also can be used here 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 254,
                ),
                Center(child: SvgPicture.asset('assets/green_tick.svg')),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Password Changed\nSuccessfully!",
                    textAlign: TextAlign.center,
                    style: CustomTheme.blueTextStyle(25, FontWeight.w500),
                  ),
                ),
                Spacer(),
                // const Center(
                //   child: Text(
                //     'account_accessible'.tr,
                //     textScaleFactor: 1.0,
                //     style: TextStyle(fontSize: 13),
                //   ),
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                // CustomButtonWidget(
                //   buttonTitle: 'back_to_login'.tr,
                //   onBtnPress: () {
                //     screenReplaceNavigator(context, SignInScreen());
                //   },
                // ),
                // SizedBox(
                //   height: 30.h,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
