import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/clocked_in_out_screen/clock_out_screen.dart';
import 'package:sgt/presentation/work_report_screen/checkpoint_report_screen.dart';
import '../../utils/const.dart';
import '../clocked_in_out_screen/clock_in_screen.dart';
import '../widgets/custom_appbar_widget.dart';

class CheckPointOutScanningScreen extends StatefulWidget {
  const CheckPointOutScanningScreen({super.key});

  @override
  State<CheckPointOutScanningScreen> createState() =>
      _CheckPointScanningScreenState();
}

class _CheckPointScanningScreenState extends State<CheckPointOutScanningScreen> {
  final qrKey = GlobalKey(debugLabel: "Qr");
  QRViewController? controller;
  Barcode? result;

  void navigateUser() async {
    screenReplaceNavigator(context, ClockInScreen());
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
        ? ClockOutScreen(
          clockOutQrData:result?.code
        )
        : MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              appBar: CustomAppBarWidget(appbarTitle: 'QR Scan'),
              backgroundColor: white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Column(children: [
                  SizedBox(
                    height: 69,
                  ),
                  const Text(
                    'Check Out',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                  SizedBox(height: 88),
                  SizedBox(height: 242, width: 242, child: buildQrView(context))
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
          overlayColor: white,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 5,
          borderRadius: 7,
        ),
      );

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.resumeCamera();
    log("Hello");
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
