import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../utils/const.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({super.key});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  final qrKey = GlobalKey(debugLabel: "Qr");
  QRViewController? qrController;
  Barcode? barcode;

  @override
  void initState() {
    // qrController!.resumeCamera();
    super.initState();
  }

  @override
  void dispose() {
    // qrController?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrController!.pauseCamera();
    }
    qrController!.resumeCamera();
  }

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
      body: Stack(children: [
        SizedBox(
          height: 30,
        ),
        const Text(
          'Check in',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
        buildQrView(context)
      ]),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            overlayColor: white,
            cutOutSize: MediaQuery.of(context).size.width * 0.8,
            borderWidth: 5,
            borderRadius: 7),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.qrController = controller;
    });
    qrController!.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });

      print(barcode);
    });
  }
}
