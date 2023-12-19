import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/navigator_function.dart';
import '../widgets/custom_button_widget.dart';
import 'apply_leave_success_screen.dart';
import 'package:http/http.dart' as http;

class ApplyLeaveScreen2 extends StatelessWidget {
  String? fromDate;
  String? toDate;
  ApplyLeaveScreen2({super.key, this.fromDate, this.toDate});

  TextEditingController _missingDayText = TextEditingController();
  TextEditingController _subjectText = TextEditingController();
  FocusNode subject_FocusNode = FocusNode();
  TextEditingController _reasonText = TextEditingController();
  FocusNode reeason_FocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Apply Leave'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Missing Shifts On Leave',
                        style: CustomTheme.textField_Headertext_Style,
                        textScaleFactor: 1.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: seconderyMediumColor),
                        child: TextFormField(
                          controller: _missingDayText,
                          decoration: InputDecoration(
                            fillColor: primaryColor,
                            hintText: '7',
                            hintStyle: TextStyle(color: Colors.black26),
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subject \*',
                        style: CustomTheme.textField_Headertext_Style,
                        textScaleFactor: 1.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: seconderyMediumColor)),
                        child: TextFormField(
                          //controller: controller,
                          maxLines: 5,
                          controller: _subjectText,
                          focusNode: subject_FocusNode,
                          decoration: InputDecoration(
                            hintText: 'Subject',
                            hintStyle: TextStyle(color: Colors.black38),
                            contentPadding:
                                EdgeInsets.only(left: 10, top: 8, right: 5),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onEditingComplete: () {
                            CommonService.fieldFocusChnage(
                                context, subject_FocusNode, reeason_FocusNode);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reason Of Leave \*',
                        style: CustomTheme.textField_Headertext_Style,
                        textScaleFactor: 1.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: seconderyMediumColor)),
                        child: TextFormField(
                          //controller: controller,
                          maxLines: 10,
                          controller: _reasonText,
                          focusNode: reeason_FocusNode,
                          decoration: InputDecoration(
                            hintText: 'Reason of leave',
                            hintStyle: TextStyle(color: Colors.black38),
                            contentPadding:
                                EdgeInsets.only(left: 10, top: 8, right: 5),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                CustomButtonWidget(
                    buttonTitle: 'Apply',
                    onBtnPress: () async {
                      if (_subjectText.text.isEmpty) {
                        CommonService()
                            .openSnackBar('Please enter subject', context);
                      } else if (_reasonText.text.isEmpty) {
                        CommonService()
                            .openSnackBar('Please enter leave reason', context);
                      } else {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return Center(child: CircularProgressIndicator());
                            }));

                        try {
                          String apiUrl = baseUrl + apiRoutes['leaveApply']!;
                          print(apiUrl);
                          Map<String, dynamic> myJsonBody = {
                            'leave_from': fromDate.toString(),
                            'leave_to': toDate.toString(),
                            'subject': _subjectText.text.trim().toString(),
                            'reason': _reasonText.text.trim().toString()
                          };
                          print(myJsonBody);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          Map<String, String> headerData = {
                            'Authorization':
                                'Bearer ${prefs.getString('token')}'
                          };

                          var response = await http.post(Uri.parse(apiUrl),
                              body: myJsonBody, headers: headerData);

                          var data = jsonDecode(response.body.toString());
                          print(data);

                          if (response.statusCode == 200) {
                            Navigator.of(context).pop();
                            screenNavigator(context, ApplyLeaveSuccess());
                          } else {
                            Navigator.of(context).pop();
                            CommonService().openSnackBar(
                                data['message'] ?? data['error'], context);
                          }
                        } catch (e) {
                          Navigator.of(context).pop();
                          print(e.toString());
                          CommonService().openSnackBar(e.toString(), context);
                        }
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
