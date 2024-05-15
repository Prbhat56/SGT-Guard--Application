import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/presentation/qr_screen/model/checkpoint_qr_details_model.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/work_report_screen/checkpoint_report_screen.dart';
import 'package:sgt/theme/font_style.dart';
import '../../theme/colors.dart';
import '../../utils/const.dart';
import '../clocked_in_out_screen/clock_in_screen.dart';
import '../widgets/custom_appbar_widget.dart';

class CheckPointScanningScreen extends StatefulWidget {
  String? propId;
  String? shiftId;
  String? checkpointId;
  String? checkpointHistoryId;
  int? checkpointlistIndex;
  CheckPointScanningScreen(
      {super.key,
      this.propId,
      this.shiftId,
      this.checkpointId,
      this.checkpointHistoryId,
      this.checkpointlistIndex});

  @override
  State<CheckPointScanningScreen> createState() =>
      _CheckPointScanningScreenState();
}

class _CheckPointScanningScreenState extends State<CheckPointScanningScreen> {
  Map<String, dynamic>? jsonResponse;
  CheckpointQrDetails? checkPointDetails;
  final qrKey = GlobalKey(debugLabel: "Qr");
  QRViewController? controller;
  Barcode? result;

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

  retriveAndChecksCheckpointId(result) async {
    log("${result!.code.toString()}");
    jsonResponse = json.decode(result!.code.toString());
    log("jsonResponse =>  ${jsonResponse}");
  }

  @override
  Widget build(BuildContext context) {
    return result != null
        ? jsonResponse!.containsKey("checkpoint_details") == true
            ? 
            CheckpointReportScreen(
                checkPointqrData: result?.code,
                propId: widget.propId,
                shiftId: widget.shiftId,
                checkPointId: widget.checkpointId,
                checkpointHistoryId: widget.checkpointHistoryId,
                checkpointListIndex: widget.checkpointlistIndex,
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You have scanned wrong checkpoint",
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
                        screenReplaceNavigator(
                            context,
                            CheckPointScanningScreen(
                                propId: widget.propId,
                                shiftId: widget.shiftId,
                                checkpointlistIndex: widget.checkpointlistIndex,
                                checkpointId: widget.checkpointId,
                                checkpointHistoryId:
                                    widget.checkpointHistoryId));
                        // Navigator.pop(context);
                      },
                      child: Text(
                        'Re-scan',
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
              appBar: CustomAppBarWidget(appbarTitle: 'QR Scan'),
              backgroundColor: white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Column(children: [
                  SizedBox(
                    height: 69,
                  ),
                  const Text(
                    'Check in',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Scan QR code to view\n checkpoint details',
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
        retriveAndChecksCheckpointId(result);
      });
    });
    this.controller!.pauseCamera();
    this.controller!.resumeCamera();
  }
}
