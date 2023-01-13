import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/widgets/curve_design_widget.dart';
import 'package:sgt/presentation/check_point_screen/widgets/timeline_details_widget.dart';
import 'package:sgt/presentation/clocked_in_out_screen/clock_out_error_screen.dart';
import 'package:sgt/presentation/check_point_screen/widgets/check_point_card_wieget.dart';
import 'package:sgt/presentation/check_point_screen/widgets/check_point_time_line.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';

class CheckPointWidget extends StatelessWidget {
  const CheckPointWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurveDesignWidget(),
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
              Expanded(child: TimeLineDetailsWidget())
            ],
          ),
          Center(
            child: CustomButtonWidget(
                buttonTitle: 'Clock Out',
                onBtnPress: () {
                  screenNavigator(context, ClockOutErrorScreen());
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
