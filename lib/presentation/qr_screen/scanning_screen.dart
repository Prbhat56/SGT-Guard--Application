import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/widgets/timeline_details_widget.dart';
import 'package:sgt/presentation/property_details_screen/model/shift_details_modal.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../clocked_in_out_screen/clock_in_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanningScreen extends StatefulWidget {
  int? propertyId;
  ScanningScreen({super.key, this.propertyId});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  ShiftDetailsModal? shiftDetails;
  String? shiftId;
  final qrKey = GlobalKey(debugLabel: "Qr");
  QRViewController? controller;
  Barcode? result;
  Map<String, dynamic>? jsonResponse;
  bool? clockInStatus;
  @override
  void initState() {
    // setDefaultStorage();
    super.initState();
  }

  // setDefaultStorage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print(prefs.setBool('shiftClockIn', false));
  //   prefs.setBool('shiftClockIn', false);
  // }

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

  shiftIdRetrive(result) async {
    jsonResponse = json.decode(result!.code.toString());
    print(
        "shift_details------------>${jsonResponse!.containsKey("shift_details")}  ${jsonResponse!.containsKey("checkpoints_details")}");

    shiftDetails = shiftDetailsModalFromJson(result?.code);
    shiftId = shiftDetails!.shiftDetails!.shiftId.toString();
    print('Shift ID: $shiftId');
    clockInStatus = (shiftDetails!.shiftDetails!.clockOut == null) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return result != null
        ? jsonResponse!.containsKey("shift_details") &&
                !jsonResponse!.containsKey("checkpoint_details")
            ? clockInStatus == true
                ? ClockInScreen(propId: widget.propertyId, shiftId: shiftId)
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/wrong_qr.svg",
                          width: 242,
                          height: 242,
                          color: AppColors.primaryColor,
                        ),
                        Text(
                          "You have scanned wrong QR,Please Scan Clock-In QR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            screenReplaceNavigator(context,
                                ScanningScreen(propertyId: widget.propertyId));
                          },
                          child: Text(
                            're_scan'.tr,
                            style: AppFontStyle.boldTextStyle(
                                AppColors.primaryColor, 17),
                          ),
                        ),
                      ],
                    ),
                  )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/wrong_qr.svg",
                      width: 242,
                      height: 242,
                      color: AppColors.primaryColor,
                    ),
                    Text(
                      "You have scanned wrong QR,Please Check QR Response",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        screenReplaceNavigator(context,
                            ScanningScreen(propertyId: widget.propertyId));
                      },
                      child: Text(
                        're_scan'.tr,
                        style: AppFontStyle.boldTextStyle(
                            AppColors.primaryColor, 17),
                      ),
                    ),
                  ],
                ),
              )
        : MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              appBar: CustomAppBarWidget(appbarTitle: 'qr_scan'.tr),
              backgroundColor: white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Column(children: [
                  SizedBox(
                    height: 69,
                  ),
                  Text(
                    'clock_in'.tr,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'clock_in_description'.tr+'!',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
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
        shiftIdRetrive(result);
      });
    });
    this.controller!.pauseCamera();
    this.controller!.resumeCamera();
  }
}
