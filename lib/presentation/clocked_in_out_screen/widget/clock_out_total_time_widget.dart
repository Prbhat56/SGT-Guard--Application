import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../../utils/const.dart';

class TotalTimeWidget extends StatefulWidget {
  String? totalTime;
  TotalTimeWidget({super.key, this.totalTime});

  @override
  State<TotalTimeWidget> createState() => _TotalTimeWidgetState();
}

class _TotalTimeWidgetState extends State<TotalTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('total_time'.tr+':',
            style: CustomTheme.blueTextStyle(15, FontWeight.w500)),
        SizedBox(
          width: 15,
        ),
        Text(
          widget.totalTime.toString(),
          style: TextStyle(
              color: primaryColor, fontSize: 15, fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(
          width: 5,
        ),
        // Text(
        //   'Hours',
        //   style: TextStyle(
        //       color: primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
        // ),
        // SizedBox(
        //   width: 15,
        // ),
        // Text(
        //   '12',
        //   style: TextStyle(
        //     color: primaryColor,
        //     fontSize: 15,
        //   ),
        // ),
        // SizedBox(
        //   width: 5,
        // ),
        // Text(
        //   'Minutes',
        //   style: TextStyle(
        //       color: primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
        // ),
      ],
    );
  }
}
