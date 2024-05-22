import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/jobs_screen/subscreen/active_jobs.dart';
import 'package:sgt/presentation/jobs_screen/subscreen/inactive_jobs.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

List<InactiveDatum> activeDatum = [];
List<InactiveDatum> inActiveDatum = [];
String imgBaseUrl = '';
int? propertyId;
String? propertyImageBaseUrl;
var getAllJobList;

class _JobsScreenState extends State<JobsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future getJobsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['dutyList']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    if (response.statusCode == 201) {
      final DutyListModel responseModel = dutyModelFromJson(response.body);
      activeDatum = responseModel.activeData ?? [];
      // print('Active: $activeDatum');
      inActiveDatum = responseModel.inactiveData ?? [];
      // print('InActive: $inActiveDatum');
      imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
      propertyImageBaseUrl = responseModel.propertyImageBaseUrl ?? '';
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
        return DutyListModel(
            activeData: [],
            inactiveData: [],
            status: response.statusCode,
            imageBaseUrl: '');
      }
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
    getAllJobList = getJobsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: 'Jobs'),
      body: FutureBuilder(
        future: getAllJobList,
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
                        'active'.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Inactive'.tr,
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
                    ActiveJobsTab(
                      activeData: activeDatum,
                      imageBaseUrl: imgBaseUrl,
                      propertyImageBaseUrl: propertyImageBaseUrl,
                    ),
                    InactiveJobsTab(
                      inActiveData: inActiveDatum,
                      imageBaseUrl: imgBaseUrl,
                      propertyImageBaseUrl: propertyImageBaseUrl,
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

/*


      DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicatorWeight: 2,
                    tabs: [
                      Tab(
                        icon: Text(
                          'active'.tr,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Tab(
                        icon: Text(
                          'Inactive'.tr,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  TabBarView(children: [
                    ActiveJobsTab(activeData: activeDatum),
                    InactiveJobsTab(inActiveData: inActiveDatum),
                  ]),
                  // SizedBox(
                  //   height: 700.h,
                  //   child: TabBarView(children: [
                  //     ActiveJobsTab(activeData: activeDatum),
                  //     InactiveJobsTab(inActiveData: inActiveDatum),
                  //   ]),
                  // )
                ],
              ),
            );*/