import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/cubit/email_checker/email_checker_cubit.dart';
import 'package:sgt/presentation/authentication_screen/verify_otp.dart';
import 'package:sgt/presentation/authentication_screen/widget/error_widgets.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import '../../utils/const.dart';
import 'package:sgt/helper/validator.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import 'change_password_after_forgot.dart';
import 'package:http/http.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var commonService = CommonService();
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
        appBar: CustomAppBarWidget(appbarTitle: 'forget_password'.tr),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'forgot_password_details'.tr,
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 40,
            ),
            /*CustomUnderlineTextFieldWidget(
                bottomPadding: 7,
                textfieldTitle: 'email'.tr,
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
                    //width: 143,
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
                          'email_validation'.tr,
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ],
                    ),
                  ),*/
            CustomUnderlineTextFieldWidget(
              bottomPadding: 7,
              textfieldTitle: 'email'.tr,
              hintText: 'enter_email'.tr,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                // print(value);
                context.read<EmailCheckerCubit>().checkEmail(value);
              },
            ),
            context.watch<EmailCheckerCubit>().state.isemailValid
                ? Container()
                : CustomErrorWidget.emailError(),
            Spacer(),
            CustomButtonWidget(
                buttonTitle: 'send'.tr,
                btnColor: isValid ? primaryColor : seconderyColor,
                onBtnPress: () async {
                  // var map = new Map<String, dynamic>();
                  // map['email'] = emailController.text.toString();

                  // var apiService = ApiCallMethodsService();
                  // apiService
                  //     .post(apiRoutes['forgetPassword']!, map)
                  //     .then((value) {
                  //   // print("Value ======> ${value}");
                  //   var response = jsonDecode(value);
                  //   if (response['status'] == 400) {
                  //     commonService.openSnackBar(
                  //         response['error'].toString(), context);
                  //   } else {
                  //     commonService.openSnackBar(
                  //         'Otp is ' + response['otp'].toString(), context);
                  //     screenNavigator(context,
                  //         VerifyOTPScreen(email: emailController.text));
                  //   }
                  // }).onError((error, stackTrace) {
                  //   print(error);
                  // });
                  // }
                  // screenNavigator(context, VerifyOTPScreen());
                  // isValid
                  //     ? Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //         return const ChangePasswordScreen();
                  //       }))
                  //     : null;

                  showDialog(
                      context: context,
                      builder: ((context) {
                        return Center(child: CircularProgressIndicator());
                      }));
                  try {
                    String apiUrl = baseUrl + apiRoutes['forgetPassword']!;
                    Map<String, dynamic> myJsonBody = {
                      'email': emailController.text.toString()
                    };
                    final response =
                        await post(Uri.parse(apiUrl), body: myJsonBody);
                    var data = jsonDecode(response.body.toString());
                    print(data);

                    var apiService = ApiCallMethodsService();
                    apiService.updateUserDetails(data);

                    if (response.statusCode == 200) {
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 10),
                        content: Text('Otp is ' + data['otp'].toString()),
                      ));

                      screenNavigator(context,
                          VerifyOTPScreen(email: emailController.text));
                    } else if (response.statusCode == 400) {
                      Navigator.of(context).pop();
                      commonService.openSnackBar(
                          data['message'] ?? data['error'], context);
                    } else {
                      Navigator.of(context).pop();
                      commonService.openSnackBar(
                          data['message'] ?? data['error'], context);
                    }
                  } catch (e) {
                    Navigator.of(context).pop();
                    commonService.openSnackBar(e.toString(), context);
                  }
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
