import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/helper/validator.dart';
import 'package:sgt/presentation/account_screen/model/guard_details_model.dart';
import 'package:sgt/presentation/authentication_screen/cubit/isValidPassword/is_valid_password_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/ispasswordmatched/ispasswordmarched_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/password_change_success_screen.dart';
import 'package:sgt/presentation/authentication_screen/verify_otp.dart';
import 'package:sgt/presentation/authentication_screen/widget/error_widgets.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../widgets/custom_underline_textfield_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldpasswordController;
  late TextEditingController _newpasswordController;
  late TextEditingController _reenteredpasswordController;
  //bool ispasswordvalid = true;
  //var userD = jsonDecode(userDetail);
  @override
  void initState() {
    _reenteredpasswordController = TextEditingController();
    _newpasswordController = TextEditingController();
    _oldpasswordController = TextEditingController();
    // userDetails();
    super.initState();
  }

  @override
  void dispose() {
    _reenteredpasswordController.dispose();
    _newpasswordController.dispose();
    _oldpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'change_password'.tr),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 30.h,
            ),
            CustomUnderlineTextFieldWidget(
              textfieldTitle: 'old_password'.tr,
              hintText: 'enter_password'.tr,
              controller: _oldpasswordController,
              obscureText:
                  context.watch<ObscureCubit>().state.oldpasswordObscure,
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<ObscureCubit>().changeoldpasswordVisibility();
                },
                icon: context.watch<ObscureCubit>().state.oldpasswordObscure
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black,
                        size: 20,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
              ),
              onChanged: (value) {},
            ),
            CustomUnderlineTextFieldWidget(
              textfieldTitle: 'new_password'.tr,
              hintText: 'enter_password'.tr,
              controller: _newpasswordController,
              obscureText:
                  context.watch<ObscureCubit>().state.newpasswordObscure,
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<ObscureCubit>().changenewpasswordVisibility();
                },
                icon: context.watch<ObscureCubit>().state.newpasswordObscure
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black,
                        size: 20,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
              ),
              onChanged: (value) {
                context
                    .read<IsValidPasswordCubit>()
                    .ispasswordValid(_newpasswordController.text);
                _newpasswordController.text.toString() ==
                        _reenteredpasswordController.text.toString()
                    ? BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordMatched()
                    : BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordnotMatched();
              },
            ),
            CustomUnderlineTextFieldWidget(
              bottomPadding: 7,
              textfieldTitle: 're_enter_new_password'.tr,
              hintText: 'enter_password'.tr,
              controller: _reenteredpasswordController,
              obscureText: context.watch<ObscureCubit>().state.isObscure,
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<ObscureCubit>().changeVisibility();
                },
                icon: context.watch<ObscureCubit>().state.isObscure
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black,
                        size: 20,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
              ),
              onChanged: (value) {
                _newpasswordController.text.toString() ==
                        _reenteredpasswordController.text.toString()
                    ? BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordMatched()
                    : BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordnotMatched();
              },
            ),
            CustomErrorWidget.changePasswordError(context),
            SizedBox(
              height: 40.h,
            ),
            Center(
              child: Container(
                width: 343.w,
                child: CupertinoButton(
                  color: BlocProvider.of<IspasswordmarchedCubit>(context,
                              listen: true)
                          .state
                          .isValid
                      ? primaryColor
                      : seconderyColor,
                  child: Text(
                    'Update',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 17.sp)),
                  ),
                  onPressed: () {
                    BlocProvider.of<IspasswordmarchedCubit>(context,
                                listen: false)
                            .state
                            .isValid
                        ? passwordChange(
                            _oldpasswordController.text.toString(),
                            _newpasswordController.text.toString(),
                            _reenteredpasswordController.text.toString())
                        //  Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) {
                        //         return const PasswordChangeSuccessScreen();
                        //       },
                        //     ),
                        //   )
                        : null;
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void passwordChange(oldPassword, newPassword, newPasswordConfirmation) async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);

    Map<String, dynamic> myJsonBody = {
      'email': userDetails.userDetails?.emailAddress.toString(),
      'old_password': oldPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };
    print(myJsonBody.toString());

    // var map = new Map<String, dynamic>();
    // map['email'] = userD['user_details']['email_address'];
    // map['old_password'] = oldPassword;
    // map['new_password'] = newPassword;
    // map['new_password_confirmation'] = newPasswordConfirmation;
    var apiService = ApiCallMethodsService();
    apiService.post(apiRoutes['updatePassword']!, myJsonBody).then((value) {
      EasyLoading.dismiss();
      var commonService = CommonService();
      var response = jsonDecode(value);
      if (response['status'] == 400) {
        print("error => ${response['error']}");
      } else {
        FirebaseHelper.changePassword(newPassword).then((value) {
          FirebaseHelper.auth = FirebaseAuth.instance;
          commonService.logDataClear();
          commonService.clearLocalStorage();
          pref.setString('welcome', '1');
          screenNavigator(context, PasswordChangeSuccessScreen());
        });
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      print(error);
    });
  }
}
