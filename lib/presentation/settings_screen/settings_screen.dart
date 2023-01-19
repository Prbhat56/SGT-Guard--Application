import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/change_password_screen.dart';
import 'package:sgt/presentation/settings_screen/languages_screen.dart';
import 'package:sgt/presentation/settings_screen/privacy_policy_screen.dart';
import 'package:sgt/presentation/settings_screen/terms_&_Condition_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';
import '../apply_leave_screen/apply_leave_screen.dart';
import 'cubit/toggle_switch/toggleswitch_cubit.dart';
import '../account_screen/edit_account_details_screen.dart';
import 'widgets/settings_option_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Settings'),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Account',
                  style: CustomTheme.blueTextStyle(15, FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SettingsOptions(),//settings option screens
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Notification Alert ',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Text Messages',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                      )),
                    ),
                    FlutterSwitch(
                      switchBorder: Border.all(
                        color: primaryColor,
                        width: 2.0.w,
                      ),
                      activeColor: primaryColor,
                      inactiveColor: white,
                      inactiveToggleColor: primaryColor,
                      width: 51.0.w,
                      height: 26.0.h,
                      toggleSize: 23.0.sp,
                      value: BlocProvider.of<ToggleSwitchCubit>(context,
                              listen: true)
                          .state
                          .isSwitched,
                      borderRadius: 30.0,
                      padding: 2.0,
                      onToggle: (val) {
                        BlocProvider.of<ToggleSwitchCubit>(context)
                            .changingToggleSwitch();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Divider(
                  height: 30.h,
                  color: Colors.grey,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
