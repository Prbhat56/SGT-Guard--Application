import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/clocked_in_out_screen/modal/clock_in_modal.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../shift_details_screen/widgets/time_details_widget.dart';
import '../shift_details_screen/widgets/time_stamp_widget.dart';
import 'package:http/http.dart' as http;

class ClockInScreen extends StatefulWidget {
  List<ClockInModal> checkpointList = [];
  int? propId;
  ClockInScreen({super.key, this.propId});

  @override
  State<ClockInScreen> createState() => _ClockInScreenState();
}
// final imageUrl ='https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

Future<ClockInModal> getCheckpointsTaskList(propertyId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? shift_id = prefs.getString('shiftId');
  String? prop_id = prefs.getString('propertyId');
  print("###### =====>  ${shift_id}");
  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  Map<String, dynamic> myJsonBody = {
    'shift_id': shift_id.toString(),
    'property_id': propertyId == null ? prop_id : propertyId.toString()
  };
  String apiUrl = baseUrl + apiRoutes['clockIn']!;
  final response =
      await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
  print("=============> ${myJsonBody}");
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    await prefs.setString('propertyId', data["property"]["id"].toString());
    final ClockInModal responseModel = clockInModalFromJson(response.body);
    return responseModel;
  } else {
    // if (response.statusCode == 400) {
    //   final ClockInModal responseModel = clockInModalFromJson(response.body);
    //   return responseModel;
    // } else {
    final ClockInModal responseModel = clockInModalFromJson(response.body);
    return responseModel;
    // }
  }
}

backtoHome(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('shiftId');
  prefs.remove('propertyId');
  screenNavigator(context, Home());
}

class _ClockInScreenState extends State<ClockInScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: CustomAppBarWidget(appbarTitle: 'Clocked In'),
          body: FutureBuilder(
              future: getCheckpointsTaskList(widget.propId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator()));
                } else {
                  if (snapshot.data!.status == 400) {
                    return Center(
                        child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            // height: 200,
                            // width: 200,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.message!.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                                  SizedBox(height: 20), // Add spacing if needed
                                  CustomButtonWidget(
                                    buttonTitle: 'Home',
                                    onBtnPress: () {
                                      backtoHome(context);
                                      // screenNavigator(context, Home());
                                    },
                                  ),
                                ])));
                  } else {
                    return Center(
                      child: Column(children: [
                        const SizedBox(height: 25),
                        SvgPicture.asset('assets/green_tick.svg'),
                        const SizedBox(height: 10),
                        Container(
                          width: 210,
                          child: Text(
                            // 'You are currently clocked in\n and ready to go!',
                            snapshot.data!.message.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primaryColor, seconderyColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              width: 300.w,
                              decoration: CustomTheme.clockInCardStyle,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 16),
                                    CustomCircularImage.getCircularImage(
                                        snapshot.data!.imageBaseUrl.toString(),
                                        snapshot.data!.jobDetails!.avatar
                                            .toString(),
                                        false,
                                        30,
                                        0,
                                        0),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        // 'Matheus Paolo',
                                        snapshot.data!.jobDetails!.firstName
                                                .toString() +
                                            ' ' +
                                            snapshot.data!.jobDetails!.lastName
                                                .toString(),
                                        style: CustomTheme.blackTextStyle(17)),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      snapshot.data!.jobDetails!.guardPosition.toString(),
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 28),
                                    Text(
                                      'Property',
                                      style: CustomTheme.blueTextStyle(
                                          15, FontWeight.w400),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                        // 'Rivi Properties',
                                        snapshot.data!.property!.propertyName
                                            .toString(),
                                        style: CustomTheme.blackTextStyle(15)),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Guard Post Duties',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 15),
                                    Center(
                                        child: TimeDetailsWidget(
                                            isClockOutScreen: false,
                                            currentShiftData:
                                                snapshot.data!.currentShift)),
                                    const SizedBox(height: 6),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Divider(color: primaryColor),
                                    ),
                                    const SizedBox(height: 20),
                                    TimeStampWidget(),
                                    const SizedBox(height: 30),
                                    CupertinoButton(
                                        color: blueColor,
                                        borderRadius: BorderRadius.circular(13),
                                        child: Text(
                                          'Checkpoints',
                                          style: TextStyle(
                                              color: white, fontSize: 17),
                                        ),
                                        onPressed: () {
                                          screenNavigator(
                                              context, CheckPointScreen());
                                          // propertyId: snapshot.data!.property!.id,
                                          // shiftId: widget.shiftId));
                                        }),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 57,
                        ),
                        // CustomButtonWidget(
                        //     buttonTitle: 'Clock Out',
                        //     onBtnPress: () {
                        //       screenNavigator(context, ClockOutErrorScreen());
                        //     }),
                      ]),
                    );
                  }
                }
              })),
    );
  }
}
