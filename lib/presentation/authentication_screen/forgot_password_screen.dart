import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/verify_otp.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import '../../utils/const.dart';
import 'package:sgt/helper/validator.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import 'change_password_after_forgot.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isemailvalid = false;
  bool isValid = false;
  late TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Forgot Password'),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Enter your registered email and will send you instructions on how to reset it',
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomUnderlineTextFieldWidget(
                bottomPadding: 7,
                textfieldTitle: 'Email',
                hintText: "Enter Email",
                controller: emailController,
                onChanged: (value) {
                  setState(() {
                    isemailvalid = value.isValidEmail;
                    isValid = isemailvalid ? false : true;
                  });
                }),

            const SizedBox(
              height: 7,
            ),
            isemailvalid
                ? Container()
                : SizedBox(
                    width: 143,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Email ID is Incorrect',
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
            Spacer(),
            CustomButtonWidget(
                buttonTitle: 'Send',
                btnColor: isValid ? primaryColor : seconderyColor,
                onBtnPress: () {
                        var map = new Map<String, dynamic>();
                        map['email'] = emailController.text.toString();
                        var commonService = CommonService();
                        var apiService = ApiCallMethodsService();
                        apiService.post(apiRoutes['forgetPassword']!, map).then((value) {
                          // print("Value ======> ${value}");
                          var response = jsonDecode(value);
                          if(response['status']== 400)
                          {
                            commonService.openSnackBar(response['error'].toString(), context);
                          }
                          else{
                            commonService.openSnackBar('Otp is '+response['otp'].toString(), context);
                            screenNavigator(context,VerifyOTPScreen(email: emailController.text));
                          }  
                        }).onError((error, stackTrace) {
                          print(error);
                        });
                      // }
                  // screenNavigator(context, VerifyOTPScreen());
                  // isValid
                  //     ? Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //         return const ChangePasswordScreen();
                  //       }))
                  //     : null;
                }),
            SizedBox(
              height: 60.h,
            )
            //   Center(
            //     child: CupertinoButton(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
            //       color: isValid ? primaryColor : seconderyColor,
            //       child: Text(
            //         'Send',
            //         textScaleFactor: 1.0,
            //         style: GoogleFonts.montserrat(
            //             textStyle: TextStyle(fontSize: 17.sp)),
            //       ),
            //       onPressed: () {
            //         isValid
            //             ? Navigator.push(context,
            //                 MaterialPageRoute(builder: (context) {
            //                 return const ChangePasswordScreen();
            //               }))
            //             : null;
            //       },
            //     ),
            //   ),
          ]),
        ),
      ),
    );
  }
}
