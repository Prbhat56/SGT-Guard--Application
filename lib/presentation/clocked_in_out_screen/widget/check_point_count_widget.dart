import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/const.dart';

class CheckPointCountWidget extends StatelessWidget {
  const CheckPointCountWidget(
      {super.key,
      required this.completedCheckPoint,
      required this.remainningCheckPoint});
  final String completedCheckPoint;
  final String remainningCheckPoint;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'completed_checkpoints'.tr+':',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              completedCheckPoint,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'remaining_checkpoints'.tr+':',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              remainningCheckPoint,
              style: TextStyle(
                color: primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
