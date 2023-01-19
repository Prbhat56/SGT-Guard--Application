import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';

import 'widget/day_wise_reports_widget.dart';
import 'widget/recent_report_card.dart';

class YourReportScreen extends StatelessWidget {
  const YourReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: "Your Reports"),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            RecentReportCardWidget(),
            SizedBox(
              height: 30,
            ),
            DayWiseReportWidget()
          ],
        ),
      )),
    );
  }
}
