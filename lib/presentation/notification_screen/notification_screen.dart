import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/notification_screen/widgets/general_tab.dart';
import 'package:sgt/presentation/notification_screen/widgets/tasks_tab.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/main_appbar_widget.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

// List<InactiveDatum> activeDatum = [];
// List<InactiveDatum> inActiveDatum = [];
String imgBaseUrl = '';

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<dynamic> getJobsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['dutyList']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());
    print(data);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    // LocationDependencyInjection.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBarWidget(
          appBarTitle: 'notification'.tr,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
                tabAlignment: TabAlignment.fill,
                padding: EdgeInsets.zero,
                controller: _tabController,
                indicatorWeight: 2,
                tabs: [
                  Tab(
                    child: Text(
                      'General',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'tasks'.tr,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ]),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  GeneralTab(),
                  TasksTab(),
                ],
              ),
            )
          ],
        ) /*FutureBuilder(
        future: getJobsList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                    tabAlignment: TabAlignment.fill,
                    padding: EdgeInsets.zero,
                    controller: _tabController,
                    indicatorWeight: 2,
                    tabs: [
                      Tab(
                        child: Text(
                          'General',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Tasks',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      GeneralTab(),
                      TasksTab(),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),*/
        );
  }
}
/**SafeArea(
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
      ), */