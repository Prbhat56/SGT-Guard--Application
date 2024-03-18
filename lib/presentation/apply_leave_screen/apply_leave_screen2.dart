import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/presentation/apply_leave_screen/model/leave_missing_shift_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/navigator_function.dart';
import '../widgets/custom_button_widget.dart';
import 'apply_leave_success_screen.dart';
import 'package:http/http.dart' as http;

class ApplyLeaveScreen2 extends StatefulWidget {
  String? fromDate;
  String? toDate;
  ApplyLeaveScreen2({super.key, this.fromDate, this.toDate,});

  @override
  State<ApplyLeaveScreen2> createState() => _ApplyLeaveScreen2State();
}

class _ApplyLeaveScreen2State extends State<ApplyLeaveScreen2> {
  TextEditingController _missingDayText = TextEditingController();

  TextEditingController _subjectText = TextEditingController();

  FocusNode subject_FocusNode = FocusNode();

  TextEditingController _reasonText = TextEditingController();

  FocusNode reeason_FocusNode = FocusNode();

  Future<LeaveApplyMissingShiftsModel> missingShiftOnLeave(
      fromDate, toDate) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String apiUrl = baseUrl + apiRoutes['leaveMissingShift']!;
      Map<String, String> myJsonBody = {
        'leave_from': fromDate.toString(),
        'leave_to': toDate.toString()
      };
      Map<String, String> headerData = {
        'Authorization': 'Bearer ${prefs.getString('token')}'
      };
      var response = await http.post(Uri.parse(apiUrl),
          headers: headerData, body: myJsonBody);
      // var responseModel = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final LeaveApplyMissingShiftsModel responseModel =
            leaveApplyMissingShiftsModelFromJson(response.body);

        // checkpointList = responseModel.checkpoints ?? [];
        return responseModel;
      } else {
        return LeaveApplyMissingShiftsModel(
          status: response.statusCode,
        );
      }
    } catch (e) {
      print("========error======> ${e.toString()}");
    }
    return LeaveApplyMissingShiftsModel(
      status: 400,
    );
  }

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
                FutureBuilder(
                    future: missingShiftOnLeave(widget.fromDate, widget.toDate),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Container(
                                height: 60,
                                width: 60,
                                child: CircularProgressIndicator()));
                      } else {
                        return Padding(
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
                                  // controller: _missingDayText,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    fillColor: primaryColor,
                                    hintText: '${snapshot.data!.response!.length}',
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
                        );
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Subject',
                              style: CustomTheme.blueTextStyle(
                                  17, FontWeight.w500),
                              children: [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                ))
                          ])),
                      // Text(
                      //   'Subject \*',
                      //   style: CustomTheme.textField_Headertext_Style,
                      //   textScaleFactor: 1.0,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: seconderyMediumColor)),
                        child: TextFormField(
                          //controller: controller,
                          maxLines: 2,
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
                      RichText(
                          text: TextSpan(
                              text: 'Reason Of Leave',
                              style: CustomTheme.blueTextStyle(
                                  17, FontWeight.w500),
                              children: [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                ))
                          ])),
                      // Text(
                      //   'Reason Of Leave \*',
                      //   style: CustomTheme.textField_Headertext_Style,
                      //   textScaleFactor: 1.0,
                      // ),
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
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Shifts Between Dates',
                            style:
                                CustomTheme.blueTextStyle(17, FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: missingShiftOnLeave(
                              widget.fromDate, widget.toDate),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: Container(
                                      height: 60,
                                      width: 60,
                                      child: CircularProgressIndicator()));
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.response!.length,
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            snapshot
                                                    .data!
                                                    .response![index]
                                                    .property!
                                                    .propertyAvatars!
                                                    .isEmpty
                                                ? CustomCircularImage
                                                    .getCircularImage(
                                                        '',
                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuuileEwI49MdSHqO_FR_F9YhKSfG0Sde_8Q&usqp=CAU',
                                                        false,
                                                        30,
                                                        4,
                                                        43)
                                                :
                                                // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuuileEwI49MdSHqO_FR_F9YhKSfG0Sde_8Q&usqp=CAU',
                                                CustomCircularImage
                                                    .getCircularImage(
                                                        snapshot
                                                            .data!.imageBaseUrl
                                                            .toString(),
                                                        snapshot
                                                            .data!
                                                            .response![index]
                                                            .property!
                                                            .propertyAvatars!
                                                            .first
                                                            .propertyAvatar
                                                            .toString(),
                                                        false,
                                                        30,
                                                        4,
                                                        43),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .response![index]
                                                      .property!
                                                      .propertyName
                                                      .toString(),
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 17,
                                                        color:
                                                            CustomTheme.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Text(
                                                  'Check-in by ${snapshot.data!.response![index].clockIn}',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 13,
                                                        color: CustomTheme
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Divider(
                                          color: CustomTheme.seconderyColor,
                                          thickness: 1,
                                        ),
                                      ],
                                    );
                                  }));
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                            'leave_from': widget.fromDate.toString(),
                            'leave_to': widget.toDate.toString(),
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
                            // Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return Center(child: ApplyLeaveSuccess());
                                }));
                            // screenNavigator(context, ApplyLeaveSuccess());
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
