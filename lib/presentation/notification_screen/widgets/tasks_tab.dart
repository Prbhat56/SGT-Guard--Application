import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/notification_screen/modal/duty_notification_modal.dart';
import 'package:sgt/presentation/notification_screen/widgets/notification_model.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
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

var taskNotificationDataFetched;
List<DutyDatum> taskNotificationList= [];
class _TasksTabState extends State<TasksTab> {
  @override
  void initState() {
    super.initState();
   taskNotificationDataFetched=dutyNotificationsList();
  }

  Future dutyNotificationsList() async {
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
      taskNotificationList = responseModel.response!.data ?? [];
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
        return DutyNotification();
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: taskNotificationDataFetched,
        builder: (context, snapshot) {
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: taskNotificationList.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(taskNotificationList[index].message.toString()),
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
                              Text(taskNotificationList[index].notificationTime.toString()+' '+'(${taskNotificationList[index].notificationDate.toString()})'),
                            ],
                          ),
                        ),
                        trailing: CircleAvatar(
                          radius: 30,
                          backgroundColor: grey,
                          backgroundImage: NetworkImage(
                            taskNotificationList[index].userAvtar.toString()
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                });
        });
  }
}
