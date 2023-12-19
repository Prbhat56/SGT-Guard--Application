
import 'package:flutter/material.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timeSheet_model.dart';
import 'package:sgt/presentation/time_sheet_screen/subscreen/upcoming_tab.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/main_appbar_widget.dart';
import 'subscreen/completed_widget_tab.dart';
import 'package:http/http.dart' as http;

class TimeSheetScreen extends StatefulWidget {
  const TimeSheetScreen({super.key});

  @override
  State<TimeSheetScreen> createState() => _TimeSheetScreenState();
}

List<Completed> upcomingData = [];
List<Completed> completedData = [];
String imgBaseUrl = '';

class _TimeSheetScreenState extends State<TimeSheetScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<TimeSheetModel> getTimeSheetList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, String> myHeader = <String, String>{
        "Authorization": "Bearer ${prefs.getString('token')}",
      };
      String apiUrl = baseUrl + apiRoutes['timeSheet']!;
      final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
      // var data = jsonDecode(response.body.toString());
      // print(data);
      if (response.statusCode == 200) {
        final TimeSheetModel responseModel =
            timeSheetModelFromJson(response.body);
        upcomingData = responseModel.upcomming ?? [];
        print('Upcoming: $upcomingData');
        completedData = responseModel.completed ?? [];
        print('Completed: $completedData');
        imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
        return responseModel;
      } else {
        return TimeSheetModel(
            upcomming: [],
            completed: [],
            status: 500,
            propertyImageBaseUrl: '');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        appBarTitle: 'TimeSheet',
      ),
      body: FutureBuilder(
        future: getTimeSheetList(),
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
                          'Upcoming',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Completed',
                          style: TextStyle(fontSize: 17),
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
                      UpcomingWidgetTab(
                          imageBaseUrl: imgBaseUrl, upcomingData: upcomingData),
                      CompletedWidgetTab(
                        imageBaseUrl: imgBaseUrl,
                        completedData: completedData,
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

/*DefaultTabController(
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
      ), */