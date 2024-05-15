import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/notification_screen/modal/general_notification_modal.dart';
import 'package:sgt/presentation/notification_screen/widgets/notification_model.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/model/report_list_model.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/const.dart';

class GeneralTab extends StatefulWidget {
  const GeneralTab({super.key});

  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

List<Datum> messageList = [];
var generalNotificationDataFetched;

class _GeneralTabState extends State<GeneralTab> {
  @override
  void initState() {
    super.initState();
   generalNotificationDataFetched = generalNotificationsList();
  }

  Future generalNotificationsList() async {
    // print("****************************************");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    print(myHeader);
    Map<String, String> myJsonBody = {
      'category': 'general',
    };
    String apiUrl = baseUrl + apiRoutes['notification']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    if (response.statusCode == 200) {
      final GeneralNotification responseModel =
          generalNotificationFromJson(response.body);
          messageList = responseModel.response!.data ?? [];
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
        return GeneralNotification();
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: generalNotificationDataFetched,
        builder: (context, snapshot) {
          // if (!snapshot.hasData) {
          //   return SizedBox(
          //     height: MediaQuery.of(context).size.height / 1.3,
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   );
          // } else {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text(
                                  messageList[index].message.toString()),
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
                                    Text(messageList[index].notificationTime.toString()+' '+'(${messageList[index].notificationDate.toString()})'),
                                  //   Text(
                                  // snapshot.data!.response!.data![index].notificationTime.toString()),
                                  ],
                                ),
                              ),
                              trailing: CircleAvatar(
                                radius: 30,
                                backgroundColor: grey,
                                backgroundImage: NetworkImage(
                                  messageList[index].userAvtar.toString()
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
//   }
// }
