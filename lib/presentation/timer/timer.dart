import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/presentation/check_point_screen/utils/countdown_timer.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../utils/const.dart';
import 'package:http/http.dart' as http;

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

Property property = Property();
List<Checkpoint> checkpoint = [];

class _TimerWidgetState extends State<TimerWidget>{
  Duration duration = Duration();
  Timer? timer;
  bool? dataFetched = false;
  @override
  void initState() {
    super.initState();
    // startTimer();
    getCheckpointsList();
  }

  // @override
  // void dispose() {
  //   timer!.cancel();
  //   getCheckpointsList();
  //   super.dispose();
  // }

  Future getCheckpointsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? property_id = prefs.getString('propertyId');
    String? shift_id = prefs.getString('shiftId');
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    Map<String, String> myJsonBody = {
      'property_id': property_id.toString(),
      'shift_id': shift_id.toString()
    };
    String apiUrl = baseUrl + apiRoutes['checkpointListShiftWise']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    // print("=============> ${response.body}");
    if (response.statusCode == 201) {
      final CheckPointPropertyShiftWise responseModel =
          checkPointPropertyShiftWiseFromJson(response.body);
      property = responseModel.property ?? property;
      checkpoint = responseModel.checkpoints ?? [];
      String timeString = property.shift!.clockOutFull!.toString();
      DateTime dateTime = DateTime.parse(timeString);
      DateTime currentTime = DateTime.now();
      int differenceInSeconds = dateTime.difference(currentTime).inSeconds;
      var timerStatus =prefs.getString('isTimer');
      timerStatus=='1' ? initTimerOperation(differenceInSeconds.toInt()):'';
      dataFetched = true;
      // var checks = json.decode(checkpoint.toString());
      // print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ===> ${checks}");
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
        return CheckPointPropertyShiftWise(
          // checkpoint: [],
          status: response.statusCode,
          message: response.body,
        );
      }
    }
  }

  int? countdownSeconds; //total timer limit in seconds
  CountdownTimer? countdownTimer;
  bool isTimerRunning = false;

  void initTimerOperation(int countdownseconds) async {
    //timer callbacks
    countdownSeconds = countdownseconds;
    print("countdownseconds ==============> ${countdownSeconds}");
    countdownTimer = CountdownTimer(
      seconds: countdownSeconds!,
      onTick: (seconds) {
        isTimerRunning = true;
        setState(() {
          countdownSeconds = seconds; //this will return the timer values
        });
      },
      onFinished: () {
        stopTimer();
        removeTimer();
        // Handle countdown finished
      },
    );

    //native app life cycle
    SystemChannels.lifecycle.setMessageHandler((msg) {
      // On AppLifecycleState: paused
      if (msg == AppLifecycleState.paused.toString()) {
        if (isTimerRunning) {
          countdownTimer!.pause(countdownSeconds!); //setting end time on pause
        }
      }

      // On AppLifecycleState: resumed
      if (msg == AppLifecycleState.resumed.toString()) {
        if (isTimerRunning) {
          countdownTimer!.resume();
        }
      }
      return Future(() => null);
    });

    //starting timer
    isTimerRunning = true;
    countdownTimer!.start();
  }

  void stopTimer() async {
    isTimerRunning = false;
    countdownTimer!.stop();
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void removeTimer() async {
    context.read<TimerOnCubit>().turnOffTimer();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isTimer');
  }

  @override
  Widget build(BuildContext context) {
    // getCheckpointsList();
    int hours = countdownSeconds! ~/ 3600;
    int remainingSeconds = countdownSeconds! % 3600;
    int minutes = remainingSeconds ~/ 60;
    int secondsOutput = remainingSeconds % 60;
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = secondsOutput.toString().padLeft(2, '0');
    // print("countdownSeconds this----------------> ${countdownSeconds}");
    print("countdownSeconds----------------> ${countdownSeconds!.isNegative}");
    if (countdownSeconds! <= 0 || countdownSeconds!.isNegative) {
      stopTimer();
      removeTimer();
    }

    // String twoDigits(int n) => n.toString().padLeft(2, '0');
    // final hours = twoDigits(duration.inHours);
    // final minutes = twoDigits(duration.inMinutes.remainder(60));
    // final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Container(
            padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
            width: Get.width - 32.w,
            decoration: BoxDecoration(
                color: seconderyColor,
                borderRadius: BorderRadius.circular(8.r)),
            child: InkWell(
              onTap: remainingSeconds == 0
                  ? () {}
                  : () {
                      screenNavigator(context, CheckPointScreen());
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'shift_time_text'.tr,
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    height: 30.h,
                    width: 2.w,
                    color: white,
                    child: Text(''),
                  ),
                  Text(
                    ' $hoursStr Hrs',
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '$minutesStr Min',
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '$secondsStr Sec',
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ));
  }
}
