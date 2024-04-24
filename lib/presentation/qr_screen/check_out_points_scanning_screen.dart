import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/clocked_in_out_screen/clock_out_error_screen.dart';
import 'package:sgt/presentation/clocked_in_out_screen/clock_out_screen.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/property_details_screen/model/shift_details_modal.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/work_report_screen/checkpoint_report_screen.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../clocked_in_out_screen/clock_in_screen.dart';
import '../widgets/custom_appbar_widget.dart';

class CheckPointOutScanningScreen extends StatefulWidget {
  String? checkPointsStatus;
  CheckPointOutScanningScreen({super.key, this.checkPointsStatus});

  @override
  State<CheckPointOutScanningScreen> createState() =>
      _CheckPointScanningScreenState();
}

class _CheckPointScanningScreenState
    extends State<CheckPointOutScanningScreen> {
  String? clockInStatus;
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

  retriveAndCheckShiftId(result) async {
    print("widget.qrData =====> ${result?.code}");
    final ShiftDetailsModal shiftDetails =
        shiftDetailsModalFromJson(result?.code);
    log("===shift scanner clockin status====>   ${shiftDetails.shiftDetails!.clockIn}");
    clockInStatus = shiftDetails.shiftDetails!.clockIn;
  }

  @override
  Widget build(BuildContext context) {
    print("------${widget.checkPointsStatus}");
    return result != null
        ? clockInStatus == null
            ? (widget.checkPointsStatus == "0"
                ? (
                    ClockOutScreen(clockOutQrData: result?.code)
                    )
                : (
                // shiftDetails.shiftDetails?.shiftId != null ?
                ClockOutErrorScreen(clockOutQrData: result?.code)
                // :
                //           Center(
                //               child: Container(
                //             height: 200,
                //             width: 200,
                //             child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //             Text(
                //               'Scan Wrong Qr',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(fontSize: 15, color: primaryColor),
                //             ),
                //             SizedBox(height: 20), // Add spacing if needed
                //             CustomButtonWidget(
                //               buttonTitle: 'Rescan',
                //               onBtnPress: () {
                //                 screenNavigator(context, CheckPointOutScanningScreen(checkPointsStatus: widget.checkPointsStatus,));
                //               },
                //             ),
                //             ]
                //           )))
                ))
            : Center(
                child: Container(
                    height: 220,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 30,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Scan Wrong Qr',
                            textAlign: TextAlign.center,
                            style: AppFontStyle.boldTextStyle(
                                AppColors.redColor, 40),
                          ),
                          SizedBox(height: 20), // Add spacing if needed
                          InkWell(
                            onTap: () {
                              screenReplaceNavigator(
                                  context,
                                  CheckPointOutScanningScreen(
                                    checkPointsStatus: widget.checkPointsStatus,
                                  ));
                              // Navigator.pop(context);
                            },
                            child: Text(
                              'Re-scan',
                              style: AppFontStyle.boldTextStyle(
                                  AppColors.primaryColor, 17),
                            ),
                          ),
                          // CustomButtonWidget(
                          //   buttonTitle: 'Rescan',
                          //   onBtnPress: () {
                          //     screenNavigator(
                          //         context,
                          //         CheckPointOutScanningScreen(
                          //           checkPointsStatus: widget.checkPointsStatus,
                          //         ));
                          //   },
                          // ),
                        ])))
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
                      'Scan QR code\n to clock Out!',
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
        retriveAndCheckShiftId(result);
      });
    });
    this.controller!.pauseCamera();
    this.controller!.resumeCamera();
  }
}
