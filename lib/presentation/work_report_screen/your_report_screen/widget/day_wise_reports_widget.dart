import 'package:flutter/material.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/widget/report_widget.dart';
import '../../../../theme/custom_theme.dart';

class DayWiseReportWidget extends StatelessWidget {
  const DayWiseReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Today',
                style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: CustomTheme.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CustomTheme.primaryColor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Report type',
                    style: CustomTheme.blueTextStyle(12, FontWeight.w400),
                  ),
                  Icon(Icons.keyboard_arrow_up)
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ReportWidget(),
        SizedBox(
          height: 20,
        ),
        Text('Monady, 2 October',
            style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
        SizedBox(
          height: 20,
        ),
        ReportWidget(),
      ],
    );
  }
}
