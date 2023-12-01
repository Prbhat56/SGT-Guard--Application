import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/jobs_screen/widgets/job_tiles.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ActiveJobsTab extends StatefulWidget {
  const ActiveJobsTab({super.key});

  @override
  State<ActiveJobsTab> createState() => _ActiveJobsTabState();
}

Future<DutyListModel> getActiveJobsList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  String apiUrl = baseUrl + apiRoutes['dutyList']!;
  final response = await http.get(Uri.parse(apiUrl),headers: myHeader);

  var data = jsonDecode(response.body.toString());
  print(data['active_data']);

  if (response.statusCode == 201) {
    return DutyListModel(activeData: data['active_data']);
  } else {
    return DutyListModel(activeData: data['active_data']);
  }
}

class _ActiveJobsTabState extends State<ActiveJobsTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DutyListModel>(
            future: getActiveJobsList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                print(snapshot.data!.activeData);
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.activeData!.length,
                    itemBuilder: (context, index) {
                      return Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              JobsTile(
                isActive: true,
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          );
        });
  }
}
    );
  }
}
