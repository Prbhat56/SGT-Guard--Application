import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class LeavePendingInfo extends StatelessWidget {
  String reason;
  String statusOfLeave;
  LeavePendingInfo(
      {super.key,
      required this.reason,
      required this.statusOfLeave,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
