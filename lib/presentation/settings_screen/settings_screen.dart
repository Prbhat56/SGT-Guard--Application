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
              SettingsOptions()
              // ListTile(
              //   onTap: () {
              //     screenNavigator(context, EditAccountScreen());
              //   },
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              //   leading: Container(
              //       height: 30.h,
              //       width: 34.w,
              //       decoration: BoxDecoration(
              //           color: primaryColor,
              //           borderRadius: BorderRadius.circular(5)),
              //       child: Center(
              //         child: Icon(
              //           Icons.person,
              //           color: white,
              //           size: 20.sp,
              //         ),
              //       )),
              //   title: Text(
              //     'Edit Account Details',
              //     style: GoogleFonts.montserrat(
              //         textStyle: TextStyle(
              //       fontSize: 15.sp,
              //       color: Colors.black,
              //     )),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 72.0),
              //   child: Divider(
              //     height: 0,
              //     color: Colors.grey,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //     screenNavigator(context, ApplyLeaveScreen());
              //   },
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              //   leading: Container(
              //       height: 30.h,
              //       width: 34.w,
              //       decoration: BoxDecoration(
              //           color: primaryColor,
              //           borderRadius: BorderRadius.circular(5)),
              //       child: Center(
              //           child: SvgPicture.asset('assets/close_white.svg'))),
              //   title: Text(
              //     'Apply Leave',
              //     style: GoogleFonts.montserrat(
              //         textStyle: TextStyle(
              //       fontSize: 15.sp,
              //       color: Colors.black,
              //     )),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 72.0),
              //   child: Divider(
              //     height: 0,
              //     color: Colors.grey,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //     screenNavigator(context, ChangePasswordScreen());
              //   },
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              //   leading: Container(
              //       height: 30.h,
              //       width: 34.w,
              //       padding: EdgeInsets.all(3),
              //       decoration: BoxDecoration(
              //           color: primaryColor,
              //           borderRadius: BorderRadius.circular(5)),
              //       child: Icon(
              //         Icons.lock,
              //         color: white,
              //         size: 20.sp,
              //       )),
              //   title: Text(
              //     'Change Password',
              //     style: GoogleFonts.montserrat(
              //         textStyle: TextStyle(
              //       fontSize: 15.sp,
              //       color: Colors.black,
              //     )),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 72.0),
              //   child: Divider(
              //     height: 0,
              //     color: Colors.grey,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //     screenNavigator(context, TermsandConditionScreen());
              //   },
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              //   leading: Container(
              //       height: 30.h,
              //       width: 34.w,
              //       decoration: BoxDecoration(
              //           color: primaryColor,
              //           borderRadius: BorderRadius.circular(5)),
              //       child: Center(
              //         child: Icon(
              //           Icons.collections,
              //           color: white,
              //           size: 20.sp,
              //         ),
              //       )),
              //   title: Text(
              //     'Terms and Conditions',
              //     style: GoogleFonts.montserrat(
              //         textStyle: TextStyle(
              //       fontSize: 15.sp,
              //       color: Colors.black,
              //     )),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 72.0),
              //   child: Divider(
              //     height: 0,
              //     color: Colors.grey,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //     screenNavigator(context, PrivacyPolicyScreen());
              //   },
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              //   leading: Container(
              //     height: 30.h,
              //     width: 34.w,
              //     padding: EdgeInsets.all(3),
              //     decoration: BoxDecoration(
              //         color: primaryColor,
              //         borderRadius: BorderRadius.circular(5)),
              //     child: Center(
              //       child: FaIcon(
              //         FontAwesomeIcons.solidHand,
              //         color: white,
              //         size: 20.sp,
              //       ),
              //     ),
              //   ),
              //   title: Text(
              //     'Privacy Policy ',
              //     style: GoogleFonts.montserrat(
              //         textStyle: TextStyle(
              //       fontSize: 15.sp,
              //       color: Colors.black,
              //     )),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 72.0),
              //   child: Divider(
              //     height: 0,
              //     color: Colors.grey,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //     screenNavigator(context, LanguagesScreen());
              //   },
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              //   leading: Container(
              //     height: 30.h,
              //     width: 34.w,
              //     decoration: BoxDecoration(
              //         color: primaryColor,
              //         borderRadius: BorderRadius.circular(5)),
              //     child: Center(
              //       child: Icon(
              //         Fontisto.world_o,
              //         color: white,
              //         size: 20.sp,
              //       ),
              //     ),
              //   ),
              //   title: Text(
              //     'Languages',
              //     style: GoogleFonts.montserrat(
              //         textStyle: TextStyle(
              //       fontSize: 15.sp,
              //       color: Colors.black,
              //     )),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 72.0),
              //   child: Divider(
              //     height: 0,
              //     color: Colors.grey,
              //   ),
              // ),
              // ListTile(
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              //   leading: Container(
              //     height: 30.h,
              //     width: 34.w,
              //     // padding: EdgeInsets.all(3),
              //     decoration: BoxDecoration(
              //         color: primaryColor,
              //         borderRadius: BorderRadius.circular(5)),
              //     child: Center(
              //       child: FaIcon(
              //         FontAwesomeIcons.solidHand,
              //         color: white,
              //         size: 20.sp,
              //       ),
              //     ),
              //   ),
              //   title: Text(
              //     'Help & Support ',
              //     style: GoogleFonts.montserrat(
              //         textStyle: TextStyle(
              //       fontSize: 15.sp,
              //       color: Colors.black,
              //     )),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 72.0),
              //   child: Divider(
              //     height: 0,
              //     color: Colors.grey,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //     showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             contentPadding:
              //                 EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              //             content: Column(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 SizedBox(
              //                   height: 30,
              //                 ),
              //                 Text(
              //                   'Sign Out',
              //                   style: TextStyle(fontSize: 20),
              //                 ),
              //                 SizedBox(
              //                   height: 30,
              //                 ),
              //                 Text(
              //                   'orem Ipsum is simply dummy text of the printing and typesetting industry.',
              //                   textAlign: TextAlign.center,
              //                   textScaleFactor: 1.0,
              //                   style:
              //                       TextStyle(fontSize: 15, color: Colors.grey),
              //                 ),
              //                 SizedBox(
              //                   height: 30,
              //                 ),
              //                 Divider(
              //                   color: Colors.grey,
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.symmetric(
              //                       horizontal: 20, vertical: 20),
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         padding: EdgeInsets.all(5),
              //                         decoration: BoxDecoration(
              //                           color: white,
              //                           border: Border.all(color: primaryColor),
              //                           borderRadius: BorderRadius.circular(5),
              //                         ),
              //                         child: Center(
              //                           child: Text(
              //                             'Cencel',
              //                             textScaleFactor: 1.0,
              //                             style: TextStyle(color: primaryColor),
              //                           ),
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 70,
              //                       ),
              //                       Container(
              //                         height: 40,
              //                         width: 1,
              //                         decoration: BoxDecoration(
              //                           color: Colors.grey,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 65,
              //                       ),
              //                       Container(
              //                         padding: EdgeInsets.all(5),
              //                         decoration: BoxDecoration(
              //                           color: primaryColor,
              //                           border: Border.all(color: primaryColor),
              //                           borderRadius: BorderRadius.circular(5),
              //                         ),
              //                         child: Center(
              //                           child: Text(
              //                             'Sign Out',
              //                             textScaleFactor: 1.0,
              //                             style: TextStyle(color: white),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             ),
              //           );
              //         });
              //   },
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              //   leading: Container(
              //       height: 30.h,
              //       width: 34.w,
              //       decoration: BoxDecoration(
              //           color: primaryColor,
              //           borderRadius: BorderRadius.circular(5)),
              //       child: Center(
              //         child: Icon(
              //           Icons.logout,
              //           color: white,
              //           size: 20.sp,
              //         ),
              //       )),
              //   title: Text(
              //     'Sign Out',
              //     style: GoogleFonts.montserrat(
              //         textStyle: TextStyle(
              //       fontSize: 15.sp,
              //       color: Colors.black,
              //     )),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 72.0),
              //   child: Divider(
              //     height: 0,
              //     color: Colors.grey,
              //   ),
              // ),
           ,
           
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
