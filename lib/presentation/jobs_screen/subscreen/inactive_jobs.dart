import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/jobs_screen/widgets/job_tiles.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InactiveJobsTab extends StatefulWidget {
  const InactiveJobsTab({super.key});

  @override
  State<InactiveJobsTab> createState() => _InactiveJobsTabState();
}

Future<DutyListModel> getInactiveJobsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    print(myHeader);

    String apiUrl = baseUrl + apiRoutes['dutyList']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 201) {
      print("data with 201 ===> ${data['inactive_data']}");
      return DutyListModel(inactiveData: data['inactive_data']);
    } else {
      print("data without 201 ===> ${data['inactive_data']}");
      return DutyListModel(inactiveData: data['inactive_data']);
    }
  }

class _InactiveJobsTabState extends State<InactiveJobsTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DutyListModel>(
        future: getInactiveJobsList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            print(snapshot.data!.inactiveData!.length);
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.inactiveData!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      JobsTile(
                        isActive: false,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                    ],
                  );
                });
          }
        });
  }
}
