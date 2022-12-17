import 'package:flutter/material.dart';
import 'package:sgt/presentation/notification_screen/widgets/general_tab.dart';
import 'package:sgt/presentation/notification_screen/widgets/tasks_tab.dart';
import '../../utils/const.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 20),
                child: Text(
                  'Notifications',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              TabBar(
                labelColor: black,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 4,
                indicatorColor: primaryColor,
                tabs: [
                  Tab(
                    icon: Text(
                      'General',
                      style: TextStyle(color: black, fontSize: 20),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'Tasks',
                      style: TextStyle(color: black, fontSize: 20),
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
    );
  }
}
