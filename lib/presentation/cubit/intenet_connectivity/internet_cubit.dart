import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/font_style.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen(_updateConnectionState);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
      return _updateConnectionState(result);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  _updateConnectionState(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: Padding(
          padding: EdgeInsets.only(left:8.0),
          child: Text(
            "No Internet Connection.",
            style: AppFontStyle.mediumTextStyle(AppColors.textColor, 15.sp),
          ),
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: AppColors.backgroundColor,
        // icon: const Icon(
        //   Icons.wifi_off,
        //   color: Colors.white,
        //   size: 35,
        // ),
        margin: EdgeInsets.only(bottom: 8),
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}

class NetworkCheck {
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((internet) {
      if (internet) {
        func(true);
      } else {
        func(false);
      }
    });
  }

  /*NetworkCheck networkCheck = NetworkCheck();
                  networkCheck.checkInternet((isNetworkPresent) async {
                    if (!isNetworkPresent) {
                      debugPrint("Now, Connection is Off!");
                      return;
                    } else {
                      debugPrint("Connection is On!");
                    }
                  }); */
}
