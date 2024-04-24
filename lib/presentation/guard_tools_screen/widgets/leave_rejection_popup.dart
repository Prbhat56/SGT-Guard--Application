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
  String statusOfLeave;
  LeaveRejectInfo(
      {super.key,
      required this.name,
      required this.date,
      required this.time,
      required this.reason,
      required this.statusOfLeave,});

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
                title: statusOfLeave=='Rejected'? 'Rejected By: ' : 'Approved By: ',
                titleValue: name,
                fontsize: 15,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStyleWidget1(
                title:statusOfLeave=='Rejected'?  'Rejected On: ':'Approved On: ',
                titleValue: date,
                fontsize: 15,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStyleWidget1(
                title:statusOfLeave=='Rejected'? 'Rejected At: ':'Approved At: ',
                titleValue: time,
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
            statusOfLeave=='Rejected'? 'Reason Of Rejection' : 'Leave Subject',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            textScaleFactor: 1.0,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            reason,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: CustomTheme.black.withOpacity(0.4)),
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
