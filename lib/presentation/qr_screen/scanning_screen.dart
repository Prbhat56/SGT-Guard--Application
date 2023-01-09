import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../utils/const.dart';
import '../shift_details_screen/clock_in_screen.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({super.key});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  final qrKey = GlobalKey(debugLabel: "Qr");
  QRViewController? controller;
  Barcode? result;

  void navigateUser() async {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ClockInScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return result != null
        ? ClockInScreen()
        // ? Scaffold(
        //     appBar: AppBar(
        //       elevation: 0,
        //       backgroundColor: Colors.white,
        //       leading: IconButton(
        //         icon: const Icon(
        //           Icons.arrow_back_ios,
        //           color: Colors.black,
        //         ),
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ),
        //     backgroundColor: white,
        //     body: Container(
        //       color: Colors.white,
        //       padding: const EdgeInsets.symmetric(horizontal: 30),
        //       child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(
        //               height: 80.h,
        //             ),
        //             Center(
        //                 child: Icon(Icons.check_circle,
        //                     color: greenColor, size: 80)),
        //             const SizedBox(
        //               height: 20,
        //             ),
        //             Center(
        //               child: Text(
        //                 "Confirmed",
        //                 textAlign: TextAlign.center,
        //                 textScaleFactor: 1.0,
        //                 style: TextStyle(
        //                     color: black,
        //                     fontSize: 40,
        //                     fontWeight: FontWeight.bold),
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             Center(
        //                 child: SizedBox(
        //               width: 220.w,
        //               child: Text(
        //                 'Checkpoint Completed Successfull!',
        //                 textAlign: TextAlign.center,
        //                 textScaleFactor: 1.0,
        //                 style: TextStyle(
        //                   color: Colors.grey,
        //                   fontSize: 20,
        //                 ),
        //               ),
        //             )),
        //             SizedBox(
        //               height: 200.h,
        //             ),
        //             Center(
        //               child: CupertinoButton(
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: 130.w, vertical: 15),
        //                 color: primaryColor,
        //                 child: const Text(
        //                   'Next',
        //                   textScaleFactor: 1.0,
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //                 onPressed: () {
        //                   Navigator.pushReplacement(context,
        //                       MaterialPageRoute(builder: (context) {
        //                     return const CheckPointScreen();
        //                   }));
        //                 },
        //               ),
        //             ),
        //           ]),
        //     ),
        //   )

        : MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                centerTitle: true,
                title: Text('QR Scan', style: TextStyle(color: primaryColor)),
              ),
              backgroundColor: white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // // mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 69,
                      ),
                      const Text(
                        'Check in',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Scan QR code\n to clock in!',
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 88,
                      ),
                      SizedBox(
                          height: 242, width: 242, child: buildQrView(context))
                    ]),
              ),
            ),
          );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderLength: 70,
          borderColor: greenColor,
          overlayColor: Colors.white,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 5,
          borderRadius: 7,
        ),
      );

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      log(scanData.code.toString());
      HapticFeedback.vibrate();
      setState(() {
        result = scanData;
      });
    });
    this.controller!.pauseCamera();
    this.controller!.resumeCamera();
  }
}
