import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/home_screen/model/GuardHome.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../connect_screen/widgets/chatting_screen.dart';
import '../../widgets/custom_circular_image_widget.dart';
import 'package:http/http.dart' as http;

// class CircularProfile extends StatelessWidget {
class CircularProfile extends StatefulWidget {
  const CircularProfile({super.key});

  @override
  State<CircularProfile> createState() => _CircularProfileState();
}

class _CircularProfileState extends State<CircularProfile> {
  // List<dynamic> guardList = [];
  // Future<List<dynamic>> profile_details() async {
  //   var apiCallService = ApiCallMethodsService();
  //   apiCallService.post(apiRoutes['homePage']!, '').then((value) async {
  //     var usera = await jsonDecode(value.toString());
  //     if (usera['status'] == 201) {
  //       guardList = usera['teams']['data'];
  //       print(guardList);
  //       return guardList;
  //     } else {
  //       return guardList;
  //     }
  //   });
  //   return guardList;

  Future<GuardHome> getPropertyGuardListAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['homePage']!;
    final response = await http.post(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return GuardHome.fromJson(data);
    } else {
      return GuardHome.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: FutureBuilder<GuardHome>(
              future: getPropertyGuardListAPI(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator()));
                } else {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      // itemCount: dummyData.length,
                      itemCount: snapshot.data!.teams!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                screenNavigator(context, ChattingScreen(index: index));
                              },
                              child: CustomCircularImage.getCircularImage(
                                  snapshot.data!.imageBaseUrl.toString(),
                                  snapshot.data!.teams!.data![index].avatar.toString(),
                                  snapshot.data!.teams!.data![index].apiToken != null
                                  ? true : false,
                                  30,
                                  4,
                                  43),
                            ),
                            SizedBox(
                              width: 70,
                              child: Text(
                                snapshot.data!.teams!.data![index].firstName.toString(),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        );
                      });
                }
              }))
    ]));
  }
}
