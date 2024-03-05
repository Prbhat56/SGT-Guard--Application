import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/change_password_screen.dart';
import 'package:sgt/presentation/share_location_screen/share_location_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';
import 'package:sgt/helper/validator.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import 'change_password_after_forgot.dart';

  bool isemailvalid = true;
  bool isValid = false;
class VerifyOTPScreen extends StatefulWidget{
  final String email;
  VerifyOTPScreen({super.key, required this.email});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
// class VerifyOTPScreen extends StatefulWidget {
  TextEditingController _verificationOtpController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _verificationOtpController = TextEditingController();  }

  @override
  void dispose() {
    _verificationOtpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("email ===> $email");
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Verification OTP'),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Enter OTP You received on email',
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
      padding: EdgeInsets.only(bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verification OTP',
            style: CustomTheme.textField_Headertext_Style,
            textScaleFactor: 1.0,
          ),
          TextField(
            // onChanged: onChanged,
            // focusNode: focusNode,
            // readOnly: readonly!,
            controller: _verificationOtpController,
            onEditingComplete:(() {
             FocusScope.of(context).unfocus(); 
            }),
            // autocorrect: true,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              hintText: 'Enter OTP',
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: seconderyColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              hintStyle: const TextStyle(color: Colors.grey),
              focusColor: primaryColor,
            ),
          ),
        ],
      ),
    ),
            // CustomUnderlineTextFieldWidget(
            //   bottomPadding: 7,
            //   textfieldTitle: 'Verification OTP',
            //   hintText: 'Enter OTP',
            //   controller: _verificationOtpController,
            //   onChanged: (value) {
            //   },
            // ),


            const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          resendOtp(widget.email,_verificationOtpController.text.toString(),context);
                        },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
            // isemailvalid
            //     ? Container()
            //     : SizedBox(
            //         width: 143,
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(
            //               Icons.error_outline,
            //               color: Colors.red,
            //               size: 17,
            //             ),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             Text(
            //               'Email ID is Incorrect',
            //               style: TextStyle(color: Colors.red, fontSize: 13),
            //             ),
            //           ],
            //         ),
            //       ),
            Spacer(),
            CustomButtonWidget(
                buttonTitle: 'Verify OTP',
                btnColor: isValid ? primaryColor : seconderyColor,
                onBtnPress: () {
                  verify_otp(widget.email,_verificationOtpController.text.toString(),context);
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           // ChangePasswordAfterForgotScreen(email: email)),
                  //           ChangePasswordAfterForgotScreen()),
                  // );
                  // screenNavigator(context, ChangePasswordAfterForgotScreen());
                }),
            SizedBox(
              height: 60.h,
            )
          ]),
        ),
      ),
    );
  }

  void verify_otp(String email,String otp,context)
   async{  
      var map = new Map<String,dynamic>();
      map['email']= email;
      map['otp']=otp;
      var apiService = ApiCallMethodsService();
      apiService.post(apiRoutes['verifyOtp']!, map).then((value) {
        var commonService = CommonService();
        var response = jsonDecode(value);
          if(response['status']== 400)
          {
            commonService.openSnackBar(response['message'].toString(), context);
          }
          else{
            commonService.openSnackBar(response['message'].toString(), context);
            screenNavigator(context,ChangePasswordAfterForgotScreen(email: email));
          }
      }).onError((error, stackTrace) {
        print(error);
      });
   }

    void resendOtp(String email,String otp,context)
      async{
      var map = new Map<String,dynamic>();
      map['email']= email;
      map['otp']=otp;
      var apiService = ApiCallMethodsService();
      apiService.post(apiRoutes['forgetPassword']!, map).then((value) {
        // print("Value ======> $value");
        var commonService = CommonService();
        var response = jsonDecode(value);
           if(response['status']== 400)
              {
                commonService.openSnackBar(response['error'].toString(), context);
              }
            else{
                commonService.openSnackBar('Otp is '+response['otp'].toString(), context);
            }
      }).onError((error, stackTrace) {
        print(error);
      });
        }
}
