import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class LeaveRejectInfo extends StatelessWidget {
  String name;
  String date;
  String time;
  String reason;
  LeaveRejectInfo(
      {super.key,
      required this.name,
      required this.date,
      required this.time,
      required this.reason});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStyleWidget1(
                title: 'Rejected By: ',
                titleValue: 'name',
                fontsize: 15,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStyleWidget1(
                title: 'Rejected On: ',
                titleValue: 'date',
                fontsize: 15,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStyleWidget1(
                title: 'Rejected At: ',
                titleValue: 'time',
                fontsize: 15,
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(
            color: primaryColor,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            'Reason Of Rejection',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            textScaleFactor: 1.0,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            reason != "null" ? reason : "No Reason",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            textScaleFactor: 1.0,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10),
            child: CustomButtonWidget(
                buttonTitle: 'Go Back',
                onBtnPress: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}
