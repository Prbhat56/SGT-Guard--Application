import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/connect_screen/widgets/chatting_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:sgt/presentation/home_screen/model/GuardHome.dart';

class AllTeamMemberScreen extends StatefulWidget {
  const AllTeamMemberScreen({super.key});

  @override
  State<AllTeamMemberScreen> createState() => _AllTeamMemberScreenState();
}

class _AllTeamMemberScreenState extends State<AllTeamMemberScreen> {
  Future<GuardHome> getAllGuardListAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    print(myHeader);

    String apiUrl = baseUrl + apiRoutes['homePage']!;
    final response = await http.post(Uri.parse(apiUrl), headers: myHeader);

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 201) {
      return GuardHome.fromJson(data);
    } else {
      return GuardHome.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(
          appbarTitle: 'All Teams',
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child:
                  Text('Team', style: CustomTheme.textField_Headertext_Style),
            ),
            FutureBuilder<GuardHome>(
                future: getAllGuardListAPI(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.teams!.data!.length,
                          shrinkWrap:
                              true, //stoping default scrolling behaviour
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                screenNavigator(
                                    context, ChattingScreen(index: index));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomCircularImage.getCircularImage(
                                            snapshot.data!.imageBaseUrl
                                                .toString(),
                                            snapshot.data!.teams!.data![index]
                                                .avatar
                                                .toString(),
                                            // '',
                                            // dummyData[index].profileUrl,
                                            snapshot.data!.teams!.data![index]
                                                        .apiToken !=
                                                    null
                                                ? true
                                                : false,
                                            30,
                                            4,
                                            43),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.teams!
                                                        .data![index].firstName
                                                        .toString() +
                                                    '' +
                                                    snapshot.data!.teams!
                                                        .data![index].lastName
                                                        .toString(),
                                                // dummyData[index].name,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                (snapshot
                                                                .data!
                                                                .teams!
                                                                .data![index]
                                                                .street !=
                                                            null
                                                        ? snapshot.data!.teams!
                                                            .data![index].street
                                                            .toString()
                                                        : '') +
                                                    ' ' +
                                                    (snapshot
                                                                .data!
                                                                .teams!
                                                                .data![index]
                                                                .cityText !=
                                                            null
                                                        ? snapshot
                                                            .data!
                                                            .teams!
                                                            .data![index]
                                                            .cityText
                                                            .toString()
                                                        : ''),
                                                // dummyData[index].location,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                snapshot.data!.teams!
                                                    .data![index].guardPosition
                                                    .toString(),
                                                // dummyData[index].position,
                                                style: TextStyle(
                                                    fontSize: 12, color: black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    height: 20,
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  }
                })
          ],
        ));
  }
}

/*
SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child:
                  Text('Team', style: CustomTheme.textField_Headertext_Style),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<GuardHome>(
                future: getAllGuardListAPI(),
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
                        itemCount: snapshot.data!.teams!.data!.length,
                        shrinkWrap: true, //stoping default scrolling behaviour
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              screenNavigator(
                                  context, ChattingScreen(index: index));
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      CustomCircularImage.getCircularImage(
                                          snapshot.data!.imageBaseUrl
                                              .toString(),
                                          snapshot
                                              .data!.teams!.data![index].avatar
                                              .toString(),
                                          // '',
                                          // dummyData[index].profileUrl,
                                          snapshot.data!.teams!.data![index]
                                                      .apiToken !=
                                                  null
                                              ? true
                                              : false,
                                          30,
                                          4,
                                          43),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.teams!.data![index]
                                                    .firstName
                                                    .toString() +
                                                '' +
                                                snapshot.data!.teams!
                                                    .data![index].lastName
                                                    .toString(),
                                            // dummyData[index].name,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            (snapshot
                                                            .data!
                                                            .teams!
                                                            .data![index]
                                                            .street !=
                                                        null
                                                    ? snapshot.data!.teams!
                                                        .data![index].street
                                                        .toString()
                                                    : '') +
                                                ' ' +
                                                (snapshot
                                                            .data!
                                                            .teams!
                                                            .data![index]
                                                            .cityText !=
                                                        null
                                                    ? snapshot.data!.teams!
                                                        .data![index].cityText
                                                        .toString()
                                                    : ''),
                                            // dummyData[index].location,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            snapshot.data!.teams!.data![index]
                                                .guardPosition
                                                .toString(),
                                            // dummyData[index].position,
                                            style: TextStyle(
                                                fontSize: 12, color: black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 20,
                                )
                              ],
                            ),
                          );
                        });
                  }
                })
          ],
        ),
      ), */