import 'package:flutter/material.dart';
import 'package:sgt/presentation/notification_screen/widgets/general_tab.dart';
import 'package:sgt/presentation/notification_screen/widgets/tasks_tab.dart';
import '../../utils/const.dart';
import '../widgets/main_appbar_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: MainAppBarWidget(
          appBarTitle: 'Notifications',
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                TabBar(
                  labelColor: black,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 2,
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                      icon: Text(
                        'General',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        'Tasks',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 800,
                  child: TabBarView(children: [
                    GeneralTab(),
                    TasksTab(),
                  ]),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
