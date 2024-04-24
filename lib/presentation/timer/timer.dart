import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/presentation/check_point_screen/utils/countdown_timer.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../utils/const.dart';
import 'package:http/http.dart' as http;


class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration duration = Duration();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    // startTimer();
    getCheckpointsList();
    String timeString = property!.shift!.clockOutFull!.toString();
    DateTime dateTime = DateTime.parse(timeString);
    DateTime currentTime = DateTime.now();
    int differenceInSeconds = dateTime.difference(currentTime).inSeconds;
    initTimerOperation(differenceInSeconds.toInt());
  }


    Future<CheckPointPropertyShiftWise> getCheckpointsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? property_id = prefs.getString('propertyId');
    String? shift_id = prefs.getString('shiftId');
    prefs.setString('timerStatus','1');
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
      property = responseModel.property;
      checkpoint = responseModel.checkpoints;
      // var checks = json.decode(checkpoint.toString());
      // print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ===> ${checks}");
      return responseModel;
    } else {
      return CheckPointPropertyShiftWise(
        // checkpoint: [],
        status: response.statusCode,
        message: response.body,
      );
    }
  }

  late int countdownSeconds; //total timer limit in seconds
  late CountdownTimer countdownTimer;
  bool isTimerRunning = false;
  
  

  void initTimerOperation( int countdownseconds) async{
    
    //timer callbacks
    countdownSeconds = countdownseconds;
    countdownTimer = CountdownTimer(
      seconds: countdownSeconds,
      onTick: (seconds) {
        isTimerRunning = true;
        countdownSeconds = seconds;
        // setState(() {
        //   countdownSeconds = seconds; //this will return the timer values
        // });
      },
      onFinished: () {
        stopTimer();
        // Handle countdown finished
      },
    );

    //native app life cycle
    SystemChannels.lifecycle.setMessageHandler((msg) {
      // On AppLifecycleState: paused
      if (msg == AppLifecycleState.paused.toString()) {
        if (isTimerRunning) {
          countdownTimer.pause(countdownSeconds); //setting end time on pause
        }
      }

      // On AppLifecycleState: resumed
      if (msg == AppLifecycleState.resumed.toString()) {
        if (isTimerRunning) {
          countdownTimer.resume();
        }
      }
      return Future(() => null);
    });

    //starting timer
    isTimerRunning = true;
    countdownTimer.start();
  }

   void stopTimer() async{
    isTimerRunning = false;
    countdownTimer.stop();
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

  void removeTimer() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('timerStatus','0');
  }

  @override
  Widget build(BuildContext context) {
  int hours = countdownSeconds ~/ 3600;
  int remainingSeconds = countdownSeconds % 3600;
  int minutes = remainingSeconds ~/ 60;
  int secondsOutput = remainingSeconds % 60;
  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = secondsOutput.toString().padLeft(2, '0');
  if(secondsStr=='00'){
    removeTimer();
  }

    // String twoDigits(int n) => n.toString().padLeft(2, '0');
    // final hours = twoDigits(duration.inHours);
    // final minutes = twoDigits(duration.inMinutes.remainder(60));
    // final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: seconderyColor, borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: secondsStr == "00" ? () {} : () {
            screenNavigator(context,CheckPointScreen());
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Shift Time',
                style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                height: 30,
                width: 2,
                color: white,
                child: Text(''),
              ),
              Text(
                ' $hoursStr Hrs',
                style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                ':',
                style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                '$minutesStr Min',
                style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                ':',
                style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                '$secondsStr Sec',
                style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
