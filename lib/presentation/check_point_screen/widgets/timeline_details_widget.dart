import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/presentation/property_details_screen/check_points_list.dart';
import 'package:sgt/presentation/work_report_screen/checkpoint_report_screen.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../qr_screen/checkpoints_in_scanning_screen.dart';

class TimeLineDetailsWidget extends StatefulWidget {
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onCheckpointVisitedStatusChanged;
  TimeLineDetailsWidget({
    super.key,
    required this.onStatusChanged,
    required this.onCheckpointVisitedStatusChanged,
  });

  @override
  State<TimeLineDetailsWidget> createState() => _TimeLineDetailsWidgetState();
}

List<Checkpoint> checkpointList = [];
String? propId;
String? shiftId;
var checkpointAllListFetched;
String? checkpointImageBaseUrl;

class _TimeLineDetailsWidgetState extends State<TimeLineDetailsWidget> {
  @override
  void initState() {
    super.initState();
    getCheckpointsList();
    checkpointAllListFetched = getCheckpointsList();
  }

  Future<CheckPointPropertyShiftWise> getCheckpointsList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? property_id = prefs.getString('propertyId');
      String? shift_id = prefs.getString('shiftId');
      shiftId = prefs.getString('shiftId');
      Map<String, String> myHeader = <String, String>{
        "Authorization": "Bearer ${prefs.getString('token')}",
      };
      Map<String, String> myJsonBody = {
        'property_id': property_id.toString(),
        'shift_id': shift_id.toString()
      };
      String apiUrl = baseUrl + apiRoutes['checkpointListShiftWise']!;
      final response = await http.post(Uri.parse(apiUrl),
          headers: myHeader, body: myJsonBody);
      if (response.statusCode == 201) {
        final CheckPointPropertyShiftWise responseModel =
            checkPointPropertyShiftWiseFromJson(response.body);
        checkpointImageBaseUrl = responseModel.imageBaseUrl;
        checkpointList = responseModel.checkpoints ?? [];
        final squares = checkpointList.map((e) => e.status);
        var jsonData = {
          "checkpointStatus": squares.toList()
        }; // assuming this is your full data
        // print(
        //     "------------------??????? >>>>>>>>>>>>>>>>${jsonData["checkpointStatus"].toString()}");
        // print(
        //     "----------------####### >>>>>> ${jsonData["checkpointStatus"]!.every((item) => item == "Visited")}");
        // print(
        //     "----------------@@@@@@@@@@ >>>>>> ${jsonData["checkpointStatus"]!.indexWhere((element) => element == "Upcoming" || element == "missed".tr)}");
        bool everyCheckpointIsSame =
            jsonData["checkpointStatus"]!.every((item) => item == "Visited");
        everyCheckpointIsSame == true
            ? widget.onStatusChanged("0")
            : widget.onStatusChanged("1");
        propId = responseModel.property!.id.toString();
        return responseModel;
      } else {
        if (response.statusCode == 401) {
          print("--------------------------------Unauthorized");
          var apiService = ApiCallMethodsService();
          apiService.updateUserDetails('');
          var commonService = CommonService();
          FirebaseHelper.signOut();
          FirebaseHelper.auth = FirebaseAuth.instance;
          commonService.logDataClear();
          commonService.clearLocalStorage();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('welcome', '1');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false,
          );
        } else {
          return CheckPointPropertyShiftWise(
            status: response.statusCode,
          );
        }
      }
    } catch (e) {
      print("========error======> ${e.toString()}");
    }
    return CheckPointPropertyShiftWise(
      status: 400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.0),
      child: FutureBuilder(
          future: checkpointAllListFetched,
          builder: (context, snapshot) {
            if (checkpointList.isEmpty) {
              return Center(
                  child: Container(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator()));
            } else {
              return Container(
                height: 81.h * checkpointList.length.toDouble(),
                // width: 100,
                // color: Colors.amber,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkpointList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // screenNavigator(
                          //     context,
                          //     CheckPointScanningScreen(
                          //         propId: propId,
                          //         shiftId: shiftId,
                          //         checkpointId:
                          //             checkpointList[index].id.toString(),
                          //         checkpointHistoryId: checkpointList[index]
                          //             .checkpointHistoryId
                          //             .toString()));
                        },
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 80,
                              // margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color:
                                    // index == 0 ? seconderyMediumColor :
                                    white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // checkpointList[index]
                                        //         .checkPointAvatar!
                                        //         .isEmpty
                                        checkpointList[index]
                                                    .checkPointAvatar!
                                                    .length ==
                                                0
                                            ? CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/sgt_logo.jpg'),
                                              )
                                            : CircleAvatar(
                                                backgroundImage:
                                                    // AssetImage('assets/sgt_logo.jpg'),
                                                    NetworkImage(
                                                  checkpointImageBaseUrl! +
                                                      '' +
                                                      checkpointList[index]
                                                          .checkPointAvatar!
                                                          .first
                                                          .checkpointAvatars
                                                          .toString(),
                                                ),
                                              ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // 'Building Hallway 1',
                                              checkpointList[index]
                                                  .checkpointName
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomTheme.blueTextStyle(
                                                  13, FontWeight.w400),
                                            ),
                                            SizedBox(height: 5),
                                            checkpointList[index].status ==
                                                        "Visited" ||
                                                    checkpointList[index]
                                                            .status ==
                                                        "missed".tr
                                                ? Text(
                                                    checkpointList[index]
                                                        .status
                                                        .toString(),
                                                    style: CustomTheme
                                                        .blackTextStyle(10),
                                                  )
                                                : Text(
                                                    // 'Check-in by ' +
                                                    checkpointList[index]
                                                        .checkInTime
                                                        .toString(),
                                                    style: CustomTheme
                                                        .blackTextStyle(10),
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.pushNamed(context, '/QrScreen',
                                      //     arguments: {
                                      //       propId: propId,
                                      //       shiftId: shiftId,
                                      //       checkpointlistIndex: index,
                                      //       checkpointId: checkpointList[index]
                                      //           .id
                                      //           .toString(),
                                      //       checkpointHistoryId:
                                      //           checkpointList[index]
                                      //               .checkpointHistoryId
                                      //               .toString()
                                      //     });
                                      screenNavigator(
                                          context,
                                          CheckPointScanningScreen(
                                              propId: propId,
                                              shiftId: shiftId,
                                              checkpointlistIndex: index,
                                              checkpointId:
                                                  checkpointList[index]
                                                      .id
                                                      .toString(),
                                              checkpointHistoryId:
                                                  checkpointList[index]
                                                      .checkpointHistoryId
                                                      .toString()));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: CustomTheme.primaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          width: 88,
                                          height: 35,
                                          child: Center(
                                              child: Text(
                                            'Check-In',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: CustomTheme.white),
                                          ))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Divider(
                                height: 0,
                                color: seconderyColor,
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }
          }),
    );
  }
}
