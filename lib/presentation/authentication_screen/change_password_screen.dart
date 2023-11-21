import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/helper/validator.dart';
import 'package:sgt/presentation/authentication_screen/cubit/isValidPassword/is_valid_password_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/ispasswordmatched/ispasswordmarched_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/password_change_success_screen.dart';
import 'package:sgt/presentation/authentication_screen/verify_otp.dart';
import 'package:sgt/presentation/authentication_screen/widget/error_widgets.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
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
  bool ispasswordvalid = true;
  var userD = jsonDecode(userDetail);
  @override
  void initState() {
    _reenteredpasswordController = TextEditingController();
    _newpasswordController = TextEditingController();
    _oldpasswordController = TextEditingController();
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
        appBar: CustomAppBarWidget(appbarTitle: 'Change Password'),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 30.h,
            ),
            CustomUnderlineTextFieldWidget(
              textfieldTitle: 'Old Password',
              hintText: 'Enter Password',
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
              textfieldTitle: 'New Password',
              hintText: 'Enter Password',
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
              textfieldTitle: 'Re-Enter New Password',
              hintText: 'Enter Password',
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
                    textScaleFactor: 1.0,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 17.sp)),
                  ),
                  onPressed: () {
                    BlocProvider.of<IspasswordmarchedCubit>(context,
                                listen: false)
                            .state
                            .isValid
                        ?
                        passwordChange(_oldpasswordController.text.toString(),_newpasswordController.text.toString(),_reenteredpasswordController.text.toString())
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

 void passwordChange(oldPassword,newPassword,newPasswordConfirmation) async{
   var map = new Map<String,dynamic>();
      map['email']=userD['user_details']['email_address'];
      map['old_password']= oldPassword;
      map['new_password']= newPassword;
      map['new_password_confirmation']= newPasswordConfirmation;
      var apiService = ApiCallMethodsService();
      apiService.post(apiRoutes['updatePassword']!, map).then((value) {
        // print("Value ======> $value");
        var response = jsonDecode(value);
        if(response['status']== 400)
        {
            print("error => ${response['error']}");
        }
        else{
            screenNavigator(context, PasswordChangeSuccessScreen());
        }
      }).onError((error, stackTrace) {
        print(error);
      });
 }
}
