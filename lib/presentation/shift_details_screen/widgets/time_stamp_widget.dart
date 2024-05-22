import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';

class TimeStampWidget extends StatefulWidget {
  const TimeStampWidget({super.key});

  @override
  State<TimeStampWidget> createState() => _TimeStampWidgetState();
}

class _TimeStampWidgetState extends State<TimeStampWidget> {
  Duration duration = Duration();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer();
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

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(hours, style: CustomTheme.blueTextStyle(13, FontWeight.w400)),
            Text(
              "hours".tr,
              style: CustomTheme.blueTextStyle(13, FontWeight.bold),
            )
          ],
        ),
        Text(':', style: CustomTheme.blueTextStyle(13, FontWeight.w400)),
        Column(
          children: [
            Text(minutes,
                style: CustomTheme.blueTextStyle(13, FontWeight.w400)),
            Text(
              "minutes".tr,
              style: CustomTheme.blueTextStyle(13, FontWeight.bold),
            )
          ],
        ),
        Text(':', style: CustomTheme.blueTextStyle(13, FontWeight.w400)),
        Column(
          children: [
            Text(
              seconds,
              style: TextStyle(fontSize: 13, color: primaryColor),
            ),
            Text(
              "seconds".tr,
              style: CustomTheme.blueTextStyle(13, FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}
