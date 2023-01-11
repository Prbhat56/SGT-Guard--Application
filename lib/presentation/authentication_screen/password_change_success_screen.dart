import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import '../../utils/const.dart';

class PasswordChangeSuccessScreen extends StatefulWidget {
  const PasswordChangeSuccessScreen({super.key});

  @override
  State<PasswordChangeSuccessScreen> createState() =>
      _PasswordChangeSuccessScreenState();
}

class _PasswordChangeSuccessScreenState
    extends State<PasswordChangeSuccessScreen> {
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
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Spacer(),
                const Center(
                  child: Text(
                    'You can now log-in to your SGT account',
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomButtonWidget(
                  buttonTitle: 'Back To Log In',
                  onBtnPress: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const SignInScreen();
                    }));
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
