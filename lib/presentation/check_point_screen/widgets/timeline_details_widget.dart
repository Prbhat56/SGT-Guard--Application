import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/work_report_screen/submit_report_screen.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class TimeLineDetailsWidget extends StatelessWidget {
  const TimeLineDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81 * 6,
      width: 100,
      // color: Colors.amber,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                screenNavigator(context, SubmitReportScreen());
              },
              child: Column(
                children: [
                  Container(
                    width: 287,
                    height: 80,
                    // margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: index == 0 ? seconderyMediumColor : white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Building Hallway 1',
                              style: CustomTheme.blueTextStyle(
                                  13, FontWeight.w400),
                            ),
                            Text(
                              'Check-in by 11:00 am',
                              style: CustomTheme.greyTextStyle(10),
                            )
                          ],
                        ),
                        SizedBox(width: 73),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 287,
                    child: Divider(
                      height: 0,
                      color: seconderyColor,
                      thickness: 2,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
