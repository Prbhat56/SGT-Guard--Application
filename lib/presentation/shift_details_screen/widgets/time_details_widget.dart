import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';

class TimeDetailsModel {
  final String title;
  final String titleValue;
  TimeDetailsModel({
    required this.title,
    required this.titleValue,
  });
}

List<TimeDetailsModel> timeData = [
  TimeDetailsModel(title: 'Day:', titleValue: ' Monday, October 24'),
  TimeDetailsModel(title: 'Shift Time:', titleValue: ' 10:00 AM - 04:00 PM')
];

class TimeDetailsWidget extends StatelessWidget {
  const TimeDetailsWidget({super.key, required this.isClockOutScreen});
  final bool isClockOutScreen;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 18 * timeData.length.toDouble(),
      child: isClockOutScreen
          ? Column(
              children: [
                TextStyleWidget1(
                  title: timeData[0].title,
                  fontsize: 13,
                  titleValue: timeData[0].titleValue,
                ),
                SizedBox(
                  height: 5,
                )
              ],
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: timeData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextStyleWidget1(
                      title: timeData[index].title,
                      fontsize: 13,
                      titleValue: timeData[index].titleValue,
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
