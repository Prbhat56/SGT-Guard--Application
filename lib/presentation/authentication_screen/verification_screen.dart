import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sgt/presentation/share_location_screen/share_location_screen.dart';
import 'package:sgt/utils/const.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  TextEditingController _otpController = TextEditingController();
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 135, 136, 138)),
      borderRadius: BorderRadius.circular(5),
    ),
  );
  PinTheme? focusedPinTheme;
  PinTheme? submittedPinTheme;
  @override
  Widget build(BuildContext context) {
    /// Optionally you can use form to validate the Pinput
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Verifying your\nnumber',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const Text(
                'We’ve sent your verification code to +1 310 830 45321',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Code ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 20),
              Pinput(
                controller: _otpController,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                validator: (s) {},
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Didn’t Receive OTP yet?',
                  style: TextStyle(
                    color: black,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CupertinoButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                  color: seconderyColor,
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ShareLocationScreen();
                    }));
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Resend Code',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
