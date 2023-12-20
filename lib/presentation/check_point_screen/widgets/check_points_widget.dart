import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/widgets/curve_design_widget.dart';
import 'package:sgt/presentation/check_point_screen/widgets/timeline_details_widget.dart';
import 'package:sgt/presentation/check_point_screen/widgets/check_point_time_line.dart';
import 'package:sgt/presentation/qr_screen/check_out_points_scanning_screen.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';

class CheckPointWidget extends StatefulWidget {
  int? propertyId;
  CheckPointWidget({super.key,this.propertyId});

  @override
  State<CheckPointWidget> createState() => _CheckPointWidgetState();
}

class _CheckPointWidgetState extends State<CheckPointWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurveDesignWidget(
            propertyId: widget.propertyId,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 26),
                child: CheckPointTimeLineWidget(),
              ),
              Expanded(child: TimeLineDetailsWidget(
                propertyId: widget.propertyId,
              ))
            ],
          ),
          Center(
            child: CustomButtonWidget(
                buttonTitle: 'Clock Out',
                onBtnPress: () {
                  // screenNavigator(context, ClockOutErrorScreen());
                  screenNavigator(context, CheckPointOutScanningScreen());
                  // screenNavigator(context, ClockOutScreen());
                }),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
