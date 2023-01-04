import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/time_sheet_screen/widgets/upcoming_tab.dart';
import '../../utils/const.dart';
import 'widgets/completed_widget_tab.dart';

class TimeSheetScreen extends StatelessWidget {
  const TimeSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Stack(
              children: [
                SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, bottom: 20),
                      child: Text(
                        'Timesheet',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: black,
                            unselectedLabelColor: Colors.grey,
                            indicatorWeight: 4,
                            indicatorColor: primaryColor,
                            tabs: [
                              Tab(
                                icon: Text(
                                  'Upcoming',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Tab(
                                icon: Text(
                                  'Completed',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 900,
                            child: TabBarView(children: [
                              UpcomingWidgetTab(),
                              CompletedWidgetTab(),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
