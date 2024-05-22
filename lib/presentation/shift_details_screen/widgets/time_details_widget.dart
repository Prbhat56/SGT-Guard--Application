import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/clocked_in_out_screen/modal/clock_in_modal.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';
import 'package:sgt/theme/custom_theme.dart';

// class TimeDetailsModel {
//   final String title;
//   final String titleValue;
//   TimeDetailsModel({
//     required this.title,
//     required this.titleValue,
//   });
// }

// List<TimeDetailsModel> timeData = [
//   TimeDetailsModel(
//       title: 'Day:',
//       titleValue: ' Monday, October 24'), // missing in api response
//   TimeDetailsModel(
//       title: 'shift_time'.tr+': ',
//       titleValue: '10:00 AM - 04:00 PM') //missing in apiResponse
// ];

class TimeDetailsWidget extends StatefulWidget {
  CurrentShift? currentShiftData;
  TimeDetailsWidget(
      {super.key, required this.isClockOutScreen, this.currentShiftData, });
  final bool isClockOutScreen;

  @override
  State<TimeDetailsWidget> createState() => _TimeDetailsWidgetState();
}

class _TimeDetailsWidgetState extends State<TimeDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // height: 18 * timeData.length.toDouble(),
      height: 18 * 2,
      child: widget.isClockOutScreen
          ? Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'day'.tr+':',
                      style: CustomTheme.blackTextStyle(13),
                    ),
                    Text(
                      widget.currentShiftData!.shiftDate.toString(),
                      style: CustomTheme.blueTextStyle(13, FontWeight.w400),
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'shift_time'.tr+': ',
                      style: CustomTheme.blackTextStyle(13),
                    ),
                    Text(
                      widget.currentShiftData!.shiftTime.toString(),
                      style: CustomTheme.blueTextStyle(13, FontWeight.w400),
                    ),
                  ],
                ),
                // TextStyleWidget1(
                //   title: timeData[0].title,
                //   fontsize: 13,
                //   titleValue: timeData[0].titleValue,
                // ),
                SizedBox(
                  height: 5,
                )
              ],
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              // itemCount: timeData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // TextStyleWidget1(
                    //   title: timeData[index].title,
                    //   fontsize: 13,
                    //   titleValue: timeData[index].titleValue,
                    // ),
                    Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'day'.tr+':',
                      style: CustomTheme.blackTextStyle(13),
                    ),
                    Text(
                      widget.currentShiftData!.shiftDate.toString(),
                      style: CustomTheme.blueTextStyle(13, FontWeight.w400),
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'shift_time'.tr+': ',
                      style: CustomTheme.blackTextStyle(13),
                    ),
                    Text(
                      widget.currentShiftData!.shiftTime.toString(),
                      style: CustomTheme.blueTextStyle(13, FontWeight.w400),
                    ),
                  ],
                ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                );
              }),
    );
  }
}
