import 'package:flutter/material.dart';
import 'package:sgt/presentation/time_sheet_screen/subscreen/upcoming_tab.dart';
import '../../utils/const.dart';
import '../widgets/main_appbar_widget.dart';
import 'subscreen/completed_widget_tab.dart';

class TimeSheetScreen extends StatelessWidget {
  const TimeSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: MainAppBarWidget(
          appBarTitle: 'TimeSheet',
        ),
        body: DefaultTabController(
          length: 2,
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        TabBar(
                       
                          indicatorWeight: 2,
                         
                          tabs: [
                            Tab(
                              icon: Text(
                                'Upcoming',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Tab(
                              icon: Text(
                                'Completed',
                                style: TextStyle(fontSize: 17),
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
    );
  }
}
