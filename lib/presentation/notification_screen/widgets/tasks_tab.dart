import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgt/presentation/notification_screen/modal/duty_notification_modal.dart';
import 'package:sgt/presentation/notification_screen/widgets/notification_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/const.dart';
import 'package:intl/intl.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  void initState() {
    super.initState();
    dutyNotificationsList();
  }

  Future<DutyNotification> dutyNotificationsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    print(myHeader);
    Map<String, String> myJsonBody = {
      'category': 'duty',
    };
    String apiUrl = baseUrl + apiRoutes['notification']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    if (response.statusCode == 200) {
      final DutyNotification responseModel =
          dutyNotificationFromJson(response.body);
      return responseModel;
    } else {
      return DutyNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dutyNotificationsList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.response!.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(snapshot.data!.response!.data![index].message.toString()),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidClock,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(snapshot.data!.response!.data![index].notificationTime.toString()+' '+'(${snapshot.data!.response!.data![index].notificationDate.toString()})'),
                            ],
                          ),
                        ),
                        trailing: CircleAvatar(
                          radius: 30,
                          backgroundColor: grey,
                          backgroundImage: NetworkImage(
                            snapshot.data!.response!.data![index].userAvtar.toString()
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                });
          }
        });
  }
}
