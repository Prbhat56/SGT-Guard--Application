import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/jobs_screen/subscreen/active_jobs.dart';
import 'package:sgt/presentation/jobs_screen/subscreen/inactive_jobs.dart';
import 'package:sgt/presentation/widgets/main_appbar_widget.dart';
import '../../utils/const.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: MainAppBarWidget(appBarTitle: 'Greylock Security'),
        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TabBar(
                  // labelColor: black,
                  // unselectedLabelColor: Colors.grey,
                  indicatorWeight: 2,
                  // indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                      icon: Text(
                        'Active',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        'Inactive',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 700.h,
                  child: TabBarView(children: [
                    ActiveJobsTab(),
                    InactiveJobsTab(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
