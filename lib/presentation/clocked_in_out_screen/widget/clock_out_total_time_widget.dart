import 'package:flutter/material.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../../utils/const.dart';

class TotalTimeWidget extends StatelessWidget {
  const TotalTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Total Time:',
            style: CustomTheme.blueTextStyle(15, FontWeight.w500)),
        SizedBox(
          width: 15,
        ),
        Text(
          '6',
          style: TextStyle(
            color: primaryColor,
            fontSize: 15,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Hours',
          style: TextStyle(
              color: primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          '12',
          style: TextStyle(
            color: primaryColor,
            fontSize: 15,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Minutes',
          style: TextStyle(
              color: primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
