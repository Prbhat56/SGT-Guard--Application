import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/property_details_screen/property_details_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timeSheet_model.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/timesheet_details.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpcomingThimeSheet extends StatefulWidget {
  const UpcomingThimeSheet({super.key});

  @override
  State<UpcomingThimeSheet> createState() => _UpcomingThimeSheetState();
}

List<Completed> upcomingData = [];
String imgBaseUrl = '';

class _UpcomingThimeSheetState extends State<UpcomingThimeSheet> {
  Future getTimeSheetList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['timeSheet']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      final TimeSheetModel responseModel =
          timeSheetModelFromJson(response.body);
      upcomingData = responseModel.upcomming ?? [];
      print('Upcoming: $upcomingData');

      imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
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
        return TimeSheetModel(
          upcomming: [], completed: [], status: 500, propertyImageBaseUrl: '');
      }
      
    }
  }

  getDifference(String date1, String date2) {
    var dt1 = DateFormat("HH:mm:ss").parse(date1);
    var dt2 = DateFormat("HH:mm:ss").parse(date2);
    Duration duration = dt2.difference(dt1).abs();
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours Hrs $minutes mins';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        appbarTitle: 'Upcoming TimeSheet',
      ),
      body: FutureBuilder(
        future: getTimeSheetList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return upcomingData.isEmpty
                ? SizedBox(
                    child: Center(
                      child: Text(
                        'No Upcoming Timesheet Found',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : 
                
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: upcomingData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                screenNavigator(
                                    context,
                                    PropertyDetailsScreen(
                                      propertyId: upcomingData[index].id,
                                      imageBaseUrl:
                                          snapshot.data!.propertyImageBaseUrl,
                                      propertyImageBaseUrl:
                                          snapshot.data!.propertyImageBaseUrl,
                                      // activeData: snapshot.data?.activeData![index],
                                    ));
                                // TimeSheetDetailsWidget(
                                //   shiftDate:upcomingData[index].shifts!.first.date.toString(),
                                //   shiftId: upcomingData[index].shifts!.first.id.toString(),
                                //   propId: upcomingData[index].id.toString(),
                                //   propName: upcomingData[index].propertyName.toString(),
                                // ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Row(children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: CustomCircularImage
                                          .getlgCircularImage(
                                              imgBaseUrl,
                                              upcomingData[index]
                                                  .propertyAvatars!
                                                  .first
                                                  .propertyAvatar
                                                  .toString(),
                                              false)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          upcomingData[index]
                                              .propertyName
                                              .toString(),
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          upcomingData[index]
                                                      .shifts!
                                                      .first
                                                      .date != ""
                                              ? upcomingData[index]
                                                  .shifts!
                                                  .first
                                                  .date
                                                  .toString()
                                              // DateFormat.MMMEd().format(
                                              //     DateTime.parse(
                                              //         upcomingData[index]
                                              //             .shifts!
                                              //             .first
                                              //             .date
                                              //             .toString()))
                                              : "No Date",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${upcomingData[index].shifts!.first.clockIn}-${upcomingData[index].shifts!.first.clockOut}',
                                          style: const TextStyle(
                                              fontSize: 11, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   getDifference(
                                  //           upcomingData[index]
                                  //               .shifts!
                                  //               .first
                                  //               .clockIn
                                  //               .toString(),
                                  //           upcomingData[index]
                                  //               .shifts!
                                  //               .first
                                  //               .clockOut
                                  //               .toString())
                                  //       .toString(),
                                  //   style: TextStyle(
                                  //       fontSize: 11, color: primaryColor),
                                  // ),
                                ]),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            )
                          ],
                        ),
                      );
                    });
          }
        },
      ),
    );
  }
}
