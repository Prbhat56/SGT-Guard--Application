import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/clocked_in_out_screen/modal/clock_in_modal.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/theme/font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../authentication_screen/firebase_auth.dart';
import '../shift_details_screen/widgets/time_details_widget.dart';
import '../shift_details_screen/widgets/time_stamp_widget.dart';
import 'package:http/http.dart' as http;

class ClockInScreen extends StatefulWidget {
  List<ClockInModal> checkpointList = [];
  int? propId;
  String? shiftId;
  ClockInScreen({super.key, this.propId,this.shiftId});

  @override
  State<ClockInScreen> createState() => _ClockInScreenState();
}
// final imageUrl ='https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

Future getCheckpointsTaskList(propertyId,shiftId,context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? shift_id = prefs.getString('shiftId');
  String? prop_id = prefs.getString('propertyId');
  print("shift_id =====>  ${shift_id}");
  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  Map<String, dynamic> myJsonBody = {
    'shift_id': shiftId == null ? shift_id : shiftId,
    'property_id': propertyId == null ? prop_id : propertyId.toString()
  };
  String apiUrl = baseUrl + apiRoutes['clockIn']!;
  final response =
      await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
  // print("=============> ${myJsonBody}");
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    await prefs.setString('propertyId', data["property"]["id"].toString());
    final ClockInModal responseModel = clockInModalFromJson(response.body);
    // prefs.setString('isTimer', '1');
    // context.read<TimerOnCubit>().turnOnTimer();
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
      // if (response.statusCode == 400) {
      //   final ClockInModal responseModel = clockInModalFromJson(response.body);
      //   return responseModel;
      // } else {
      final ClockInModal responseModel = clockInModalFromJson(response.body);
      return responseModel;
      // }
    }
  }
}

backToHome(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('isTimer');
  prefs.remove('shiftId');
  prefs.remove('propertyId');
  screenNavigator(context, Home());
}

class _ClockInScreenState extends State<ClockInScreen> {
  @override
  void initState() {
    setLocalStorage(widget.shiftId);
    super.initState();
  }

  setLocalStorage(shiftId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('shiftId', shiftId);
  }

  @override
  Widget build(BuildContext context) {
    //logic to start the timer if it's not start
    // context.read<TimerOnCubit>().state.istimerOn
    //     ? context.read<TimerOnCubit>().turnOffTimer()
        print(context.read<TimerOnCubit>().state.istimerOn);
        context.read<TimerOnCubit>().turnOnTimer();
    return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
                appBar: CustomAppBarWidget(appbarTitle: 'clocked_in'.tr),
                body: FutureBuilder(
                    future: getCheckpointsTaskList(widget.propId,widget.shiftId, context),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.message!.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.red),
                                        ),
                                        SizedBox(
                                            height:
                                                20), // Add spacing if needed
                                        CustomButtonWidget(
                                          buttonTitle: 'Home'.tr,
                                          onBtnPress: () {
                                            context
                                                .read<TimerOnCubit>()
                                                .turnOffTimer();
                                            backToHome(context);
                                            // screenNavigator(
                                            //     context,
                                            //     ScanningScreen(
                                            //         propertyId:
                                            //             widget.propId));
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
                                  style: TextStyle(
                                      fontSize: 15, color: primaryColor),
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
                                              // 'Matheus Paolo',
                                              snapshot.data!.jobDetails!
                                                      .firstName
                                                      .toString() +
                                                  ' ' +
                                                  snapshot.data!.jobDetails!
                                                      .lastName
                                                      .toString(),
                                              style: CustomTheme.blackTextStyle(
                                                  17)),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            snapshot
                                                .data!.jobDetails!.guardPosition
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(height: 28),
                                          Text(
                                            'property'.tr,
                                            style: CustomTheme.blueTextStyle(
                                                15, FontWeight.w400),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                              // 'Rivi Properties',
                                              snapshot
                                                  .data!.property!.propertyName
                                                  .toString(),
                                              style: CustomTheme.blackTextStyle(
                                                  15)),
                                          const SizedBox(height: 6),
                                          Text(
                                            'guard_post_duties'.tr,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          //    const SizedBox(height: 15),
                                          // Center(
                                          //     child: CheckPointCountWidget(
                                          //   completedCheckPoint: snapshot.data!.jobDetails!.,
                                          //   remainningCheckPoint: snapshot.data!.jobDetails!.remaningCheckpoint.toString(),
                                          // )),
                                          const SizedBox(height: 15),
                                          Center(
                                              child: TimeDetailsWidget(
                                                  isClockOutScreen: false,
                                                  currentShiftData: snapshot
                                                      .data!.currentShift)),
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
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              child: Text(
                                                'checkpoint'.tr,
                                                style: TextStyle(
                                                    color: white, fontSize: 17),
                                              ),
                                              onPressed: () {
                                                screenNavigator(context,
                                                    CheckPointScreen());
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
                              //     buttonTitle: 'clock_out'.tr,
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
