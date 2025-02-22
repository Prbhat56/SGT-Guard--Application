import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/account_screen/edit_account_details_screen.dart';
import 'package:sgt/presentation/settings_screen/widgets/sign_out_confirmation_dialog.dart';
import 'package:sgt/presentation/settings_screen/widgets/sign_out_dialog.dart';
import 'package:sgt/presentation/work_report_screen/work_report_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/navigator_function.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';
import '../../apply_leave_screen/apply_leave_screen.dart';
import '../../authentication_screen/change_password_screen.dart';
import '../../work_report_screen/your_report_screen/your_report_screen.dart';
import '../languages_screen.dart';
import '../privacy_policy_screen.dart';
import '../terms_&_Condition_screen.dart';

class SettingsOptionModel {
  final Widget imageWidget;

  final String optionTitle;
  final Widget? widget;
  SettingsOptionModel({
    required this.optionTitle,
    required this.imageWidget,
    this.widget,
  });
}

List<SettingsOptionModel> settingsOptionlist = [
  SettingsOptionModel(
    optionTitle: 'Edit Account Details',
    imageWidget: Icon(
      Icons.person,
      color: white,
      size: 20,
    ),
    widget: EditAccountScreen(),
  ),
  SettingsOptionModel(
      optionTitle: 'Apply Leave',
      imageWidget: Image.asset('assets/leave.png'),
      widget: ApplyLeaveScreen()),
  SettingsOptionModel(
      optionTitle: 'report'.tr,
      imageWidget: Image.asset('assets/leave.png'),
      widget: YourReportScreen()),
  SettingsOptionModel(
      optionTitle: 'change_password'.tr,
      imageWidget: SvgPicture.asset('assets/lock.svg'),
      widget: ChangePasswordScreen()),
  SettingsOptionModel(
      optionTitle: 'terms_and_conditions'.tr,
      imageWidget: Image.asset('assets/leave.png'),
      widget: TermsandConditionScreen()),
  SettingsOptionModel(
      optionTitle: 'privacy_policy'.tr,
      imageWidget: SvgPicture.asset('assets/hand.svg'),
      widget: PrivacyPolicyScreen()),
  SettingsOptionModel(
      optionTitle: 'language'.tr,
      imageWidget: SvgPicture.asset('assets/globe.svg'),
      widget: LanguagesScreen()),
  SettingsOptionModel(
    optionTitle: 'help_and_support'.tr,
    imageWidget: SvgPicture.asset('assets/hand.svg'),
  ),
  SettingsOptionModel(
    optionTitle: 'sign_out'.tr,
    imageWidget: SvgPicture.asset('assets/logout.svg'),
  )
];

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56 * settingsOptionlist.length.toDouble(),
      child: ListView.builder(
          itemCount: settingsOptionlist.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  // onTap: () async{
                  onTap: () {
                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                    print(index);
                    index == 8
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return 
                              // prefs.getString('isTimer') == '1' ? 
                              // SignOutConfirmationDialog(); : 
                              SignOutDialog();
                            })
                        : screenNavigator(
                            context, settingsOptionlist[index].widget!);
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  leading: Container(
                      height: 30.h,
                      width: 34.w,
                      decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child:
                          Center(child: settingsOptionlist[index].imageWidget)),
                  title: Text(
                    settingsOptionlist[index].optionTitle,
                    style: CustomTheme.blackTextStyle(17),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 72.0),
                  child: Divider(
                    height: 0,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
