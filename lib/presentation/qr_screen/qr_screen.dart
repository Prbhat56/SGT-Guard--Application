import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/qr_screen/scanning_screen.dart';
import '../../utils/const.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: const Text(
                'Check in',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Take a photo of the QR code to complete the check in process  ',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Icon(
                Icons.qr_code_scanner_outlined,
                size: 200,
              ),
            ),
            Text(
              'Scan',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(
              height: 180,
            ),
            Center(
              child: CupertinoButton(
                  disabledColor: seconderyColor,
                  padding: EdgeInsets.symmetric(horizontal: 90.w, vertical: 15),
                  color: primaryColor,
                  child: Text(
                    'Take a photo',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ScanningScreen();
                    }));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
