
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timeSheet_model.dart';
import 'package:sgt/presentation/time_sheet_screen/subscreen/upcoming_tab.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
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
var timeSheetDataFetched;
class _TimeSheetScreenState extends State<TimeSheetScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future getTimeSheetList() async {
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
        final TimeSheetModel responseModel = timeSheetModelFromJson(response.body);
        upcomingData = responseModel.upcomming ?? [];
        print('Upcoming: $upcomingData');
        completedData = responseModel.completed ?? [];
        print('Completed: $completedData');
        imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
        return responseModel;
      } else {
        if (response.statusCode == 401) {
        print("--------------------------------Unauthorized");
        var apiService = ApiCallMethodsService();
        apiService.updateUserDetails('');
        var commonService = CommonService();
        FirebaseHelper.signOut();
        FirebaseHelper.auth = FirebaseAuth.instance;
        commonService.logDataClear();
        commonService.clearLocalStorage();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('welcome', '1');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false,
        );
      } else {
        return TimeSheetModel(
            upcomming: [],
            completed: [],
            status: 500,
            propertyImageBaseUrl: '');
      }
        
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
   timeSheetDataFetched= getTimeSheetList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        appBarTitle: 'timesheet'.tr,
      ),
      body: FutureBuilder(
        future: timeSheetDataFetched,
        builder: (context, snapshot) {
          // if (!snapshot.hasData) {
          //   return SizedBox(
          //     height: MediaQuery.of(context).size.height / 1.3,
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   );
          // } else {
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
                          'upcoming'.tr,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'completed'.tr,
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
          // }
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
                              'upcoming'.tr,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Tab(
                            icon: Text(
                              'completed'.tr,
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