import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/presentation/check_point_screen/widgets/check_point_card_widget.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/constant/constant.dart';
import '../../utils/const.dart';

var privacyPolicyData;
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  @override
 void initState() {
    super.initState();
    privacyPolicy();
 }

  privacyPolicy(){
     var apiCallService=ApiCallMethodsService();
        apiCallService.get(apiRoutes['privacyPolicy']!).then((value) {
            Map<String, dynamic> jsonData = jsonDecode(value);
            setState(() {
              privacyPolicyData =jsonData['data']['description'];
            });
            return privacyPolicyData;
          }).onError((error, stackTrace) {
            print(error);
          });
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
              appBar: CustomAppBarWidget(appbarTitle: 'privacy_policy'.tr),
              backgroundColor: white,
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(children: [
                  Text(
                    (privacyPolicyData==null ? '': privacyPolicyData.toString()),
                    textScaleFactor: 1.0,
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                        color: Colors.black,
                    )),
                  ),
                ]),
              ),
            );    
  }

    // Future<void>  fetchPrivacyPolicy() async{
    //     var apiCallService=ApiCallMethodsService();
    //     apiCallService.get(apiRoutes['privacy-policy']!).then((value) {
    //       Map<String, dynamic> jsonData = jsonDecode(value);
    //         privacyData = jsonData['data']['description'];
    //         print("description ===>>>>> $privacyData");
    //       }).onError((error, stackTrace) {
    //         print(error);
    //       });
    //   }
}
