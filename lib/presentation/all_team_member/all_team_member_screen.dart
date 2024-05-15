import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/presentation/connect_screen/widgets/chatting_screen.dart';
import 'package:sgt/presentation/connect_screen/widgets/profile_image.dart';
import 'package:sgt/presentation/share_location_screen/share_location_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
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
  List<ChatUsers> userList = [];
  Future getAllGuardListAPI() async {
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
        throw Exception('Failed to load guard');
      }
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child:
                  Text('Team', style: CustomTheme.textField_Headertext_Style),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseHelper.getAllUsers(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      userList = data
                              ?.map((e) => ChatUsers.fromJson(
                                  e.data() as Map<String, dynamic>))
                              .toList() ??
                          [];
                      userList.removeWhere((element) =>
                          element.id == FirebaseHelper.user.uid.toString());

                      if (userList.isNotEmpty) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemCount: userList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ChattingScreen(
                                      user: userList[index],
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                                begin: const Offset(1, 0),
                                                end: Offset.zero)
                                            .animate(animation),
                                        child: child,
                                      );
                                    },
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      ChatImageDialogue(
                                                          user:
                                                              userList[index]));
                                            },
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                    imageUrl: userList[index]
                                                        .profileUrl
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                    width: 60.0,
                                                    height: 60.0,
                                                    imageBuilder: (context,
                                                        imageProvider) {
                                                      return CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor: grey,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          userList[index]
                                                              .profileUrl
                                                              .toString(),
                                                        ),
                                                      );
                                                    },
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(
                                                          strokeCap:
                                                              StrokeCap.round,
                                                        ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        CircleAvatar(
                                                          radius: 30,
                                                          child: Image.asset(
                                                            'assets/chatProfile.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        )),
                                                userList[index].isOnline
                                                    ? Positioned(
                                                        top: 45,
                                                        left: 42,
                                                        child: Container(
                                                          height: 15,
                                                          width: 15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: greenColor,
                                                            border: Border.all(
                                                                color: white,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      )
                                                    : Positioned(
                                                        top: 45,
                                                        left: 42,
                                                        child: Container(),
                                                      )
                                              ],
                                            ),
                                          ),
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
                                                  userList[index]
                                                      .name
                                                      .toString()
                                                      .capitalized(),
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  userList[index]
                                                      .location
                                                      .toString(),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  userList[index]
                                                      .position
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: black),
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
                            });
                      } else {
                        return SizedBox(
                          child: Center(
                            child: Text(
                              'No Team Found',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
            )
            /*FutureBuilder<GuardHome>(
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
                                //screenNavigator(context, ChattingScreen(index: index));
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
                })*/
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