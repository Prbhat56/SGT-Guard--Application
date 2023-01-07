import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../utils/const.dart';

class VerifyMobileNoScreen extends StatefulWidget {
  const VerifyMobileNoScreen({super.key});

  @override
  State<VerifyMobileNoScreen> createState() => _VerifyMobileNoScreenState();
}

class _VerifyMobileNoScreenState extends State<VerifyMobileNoScreen> {
  TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final defaultPinTheme = PinTheme(
    width: 36,
    height: 36,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 135, 136, 138)),
      borderRadius: BorderRadius.circular(5),
    ),
  );

  final submittedPinTheme = PinTheme(
    width: 36,
    height: 36,
    textStyle: TextStyle(
        fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(5),
    ),
  );
  PinTheme? focusedPinTheme;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Verify Mobile Number',
          style: TextStyle(color: black, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            const Text(
              'Phone',
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey),
                ),
                hintText: '(808) 628 8343',
                focusColor: primaryColor,
              ),
              keyboardType: TextInputType.number,
              validator: (input) =>
                  input!.isNotEmpty ? null : "please enter your phone number",
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                'Verifying your number',
                style: TextStyle(color: black, fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                'Enter code',
                style: TextStyle(color: Colors.grey, fontSize: 15.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Pinput(
                controller: _otpController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                validator: (s) {},
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Didn't Receive OTP yet?,",
                    style: TextStyle(color: black, fontSize: 12.sp),
                  ),
                  Text(
                    "00:05",
                    style: TextStyle(color: primaryColor, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                "Resend code",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                width: 311.w,
                margin: EdgeInsets.only(bottom: 30),
                child: CupertinoButton(
                  disabledColor: seconderyColor,
                  // padding:
                  //     const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                  color: primaryColor,
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
