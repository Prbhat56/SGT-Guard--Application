import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/widgets/active_jobs.dart';
import 'package:sgt/presentation/jobs_screen/widgets/inactive_jobs.dart';

import '../../utils/const.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: greenColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Greylock Security',
                style: TextStyle(color: black),
              ),
            ],
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                TabBar(
                  labelColor: black,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 4,
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                      icon: Text(
                        'Active',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        'Inactive',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 700,
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
