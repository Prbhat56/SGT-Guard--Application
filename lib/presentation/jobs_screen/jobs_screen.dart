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
          backgroundColor: white,
          leadingWidth: 20,
          elevation: 0,
          toolbarHeight: 80,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(3, 3, 3, 0),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.close)),
            ),
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
                        style: TextStyle(color: black, fontSize: 20),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        'Inactive',
                        style: TextStyle(color: black, fontSize: 20),
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
