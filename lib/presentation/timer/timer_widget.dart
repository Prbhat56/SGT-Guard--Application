import 'package:flutter/material.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerShiftWidget extends StatefulWidget {
  
  TimerShiftWidget({super.key});

  @override
  State<TimerShiftWidget> createState() => _TimerShiftWidgetState();
}

  String? formattedTime;
  bool? dottedTime;
  int? countdownseconds;
class _TimerShiftWidgetState extends State<TimerShiftWidget> {

  @override
  void initState() {
    super.initState();
    checkAllDetails();
  }

  checkAllDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dottedTime = prefs.getBool('dottedTime');
    formattedTime = prefs.getString('formattedTime');
    countdownseconds = prefs.getInt('countdownseconds');
  }

  @override
  Widget build(BuildContext context) {

    return countdownseconds != 0
        ? Text(
            formattedTime.toString(),
            style: CustomTheme.blueTextStyle(12, FontWeight.w400),
          )
        : Container();
  }
}
