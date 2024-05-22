import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/constant/constant.dart';
import '../../utils/const.dart';

var terms_condition;
class TermsandConditionScreen extends StatefulWidget {
  const TermsandConditionScreen({super.key});
  
  @override
  State<TermsandConditionScreen> createState() =>_TermsandConditionScreenState();
}

class _TermsandConditionScreenState extends State<TermsandConditionScreen> {

@override
 void initState() {
    super.initState();
    termsAndCondition();
 }

 termsAndCondition(){
   var apiCallService=ApiCallMethodsService();
     apiCallService.get(apiRoutes['termsCondition']!).then((value) async{
       Map<String, dynamic> jsonData = jsonDecode(value);
       setState(() {
        terms_condition =jsonData['data']['description'];
       });
       return terms_condition;
      }).onError((error, stackTrace) {
        print(error);
      });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: 'terms_and_conditions'.tr),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          Text(
            (terms_condition==null ? '': terms_condition.toString()),
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

  
}
