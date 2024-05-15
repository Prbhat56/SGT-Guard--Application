import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/clocked_in_out_screen/modal/clock_out_modal.dart';
import 'package:sgt/presentation/clocked_in_out_screen/widget/clock_out_total_time_widget.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/presentation/property_details_screen/model/shift_details_modal.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../home.dart';
import 'widget/check_point_count_widget.dart';
import 'package:http/http.dart' as http;

// import 'package:geolocator/geolocator.dart';

class ClockOutScreen extends StatefulWidget {
  String? clockOutQrData;
  ClockOutScreen({super.key, this.clockOutQrData});

  @override
  State<ClockOutScreen> createState() => _ClockOutScreenState();
}

final imageUrl =
    'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

// var clockOutFetchedData;

class _ClockOutScreenState extends State<ClockOutScreen> {
  @override
  void initState() {
    print("${widget.clockOutQrData}");
    super.initState();
    final ShiftDetailsModal shiftDetails =
        shiftDetailsModalFromJson(widget.clockOutQrData.toString());
    String? shiftId = shiftDetails.shiftDetails!.shiftId.toString();
    getClockOutData(
        shiftDetails.shiftDetails!.clockOut != null ? shiftId : '');
  }

  Future getClockOutData(shift_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    Map<String, dynamic> myJsonBody = {'shift_id': shift_id.toString()};
    String apiUrl = baseUrl + apiRoutes['clockOut']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    if (response.statusCode == 200) {
      prefs.remove('isTimer');
      prefs.remove('shiftId');
      prefs.remove('propertyId');
      prefs.remove('Cp');
      prefs.remove('routeId');
      context.read<TimerOnCubit>().turnOffTimer();
      final ClockOutModal responseModel = clockOutModalFromJson(response.body);
      return responseModel;
    } else {
      if (response.statusCode == 400) {
        final ClockOutModal responseModel =
            clockOutModalFromJson(response.body);
        return responseModel;
      } else {
        if (response.statusCode == 401) {
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
          final ClockOutModal responseModel =
              clockOutModalFromJson(response.body);
          return responseModel;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<TimerOnCubit>().state.istimerOn
        ? context.read<TimerOnCubit>().turnOffTimer()
        : null;
    final ShiftDetailsModal shiftDetails =
        shiftDetailsModalFromJson(widget.clockOutQrData.toString());
    String? shiftId = shiftDetails.shiftDetails!.shiftId.toString();
    return
        // PopScope(
        //   canPop:false,
        //   child:
        MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          // appBar: CustomAppBarWidget(appbarTitle: 'Clocked Out'),
          body: FutureBuilder(
              future: getClockOutData(
                  shiftDetails.shiftDetails!.clockOut != null ? shiftId : ''),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator()));
                }
                // else {
                //   if (snapshot.data!.status == 400) {
                //     return Center(
                //         child: Container(
                //       height: 200,
                //       width: 200,
                //       child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //       Text(
                //         snapshot.data!.message!.toString(),
                //         textAlign: TextAlign.center,
                //         style: TextStyle(fontSize: 15, color: primaryColor),
                //       ),
                //       SizedBox(height: 20), // Add spacing if needed
                //       CustomButtonWidget(
                //         buttonTitle: 'Home',
                //         onBtnPress: () {
                //           screenNavigator(context, Home());
                //         },
                //       ),
                //       ]
                //     )));
                //   }

                else {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 25),
                          SvgPicture.asset('assets/green_tick.svg'),
                          const SizedBox(height: 10),
                          Text(
                            // 'You are currently clocked\n out from shift!'
                            snapshot.data!.message.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, color: primaryColor),
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
                                          snapshot.data!.imageBaseUrl
                                              .toString(),
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
                                          snapshot.data!.jobDetails!.firstName
                                                  .toString() +
                                              '' +
                                              snapshot
                                                  .data!.jobDetails!.lastName
                                                  .toString(),
                                          style:
                                              CustomTheme.blackTextStyle(17)),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      const Text(
                                        'Greylock Security',
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
                                          snapshot.data!.property!.propertyName
                                              .toString(),
                                          style:
                                              CustomTheme.blackTextStyle(15)),
                                      const SizedBox(height: 6),
                                      const Text(
                                        'Guard Post Duties',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 15),
                                      // Center(
                                      //     child: TimeDetailsWidget(
                                      //         isClockOutScreen: true)),
                                      // const SizedBox(height: 6),
                                      Center(
                                          child: CheckPointCountWidget(
                                        completedCheckPoint: snapshot.data!
                                            .jobDetails!.comletedCheckpoint
                                            .toString(),
                                        remainningCheckPoint: snapshot.data!
                                            .jobDetails!.remaningCheckpoint
                                            .toString(),
                                      )),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Divider(color: primaryColor),
                                      ),
                                      const SizedBox(height: 20),
                                      Center(
                                          child: TotalTimeWidget(
                                              totalTime: snapshot.data!
                                                  .currentShift!.timePeriod)),
                                      const SizedBox(height: 20),
                                    ]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 105,
                          ),
                          CustomButtonWidget(
                              buttonTitle: 'Home',
                              onBtnPress: () {
                                screenReplaceNavigator(context, Home());
                              }),
                        ]),
                  );
                }
                // }
              })),
    );

    // );
  }
}
