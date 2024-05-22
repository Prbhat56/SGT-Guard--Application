import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/all_team_member/all_team_member_screen.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/presentation/home_screen/model/GuardHome.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../connect_screen/widgets/chatting_screen.dart';
import 'package:http/http.dart' as http;

// class CircularProfile extends StatelessWidget {
class CircularProfile extends StatefulWidget {
  CircularProfile({
    super.key,
  });

  @override
  State<CircularProfile> createState() => _CircularProfileState();
}

class _CircularProfileState extends State<CircularProfile> {
  late List<ChatUsers> userList = [];

  Future getPropertyGuardListAPI() async {
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
        return GuardHome.fromJson(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
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
                    ?.map((e) =>
                        ChatUsers.fromJson(e.data() as Map<String, dynamic>))
                    .toList() ??
                [];
            userList.removeWhere(
                (element) => element.id == FirebaseHelper.user.uid.toString());

            if (userList.isNotEmpty) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Team (${userList.length.toString()})',
                          style: CustomTheme.textField_Headertext_Style),
                      InkWell(
                        onTap: () async {
                          screenNavigator(context, AllTeamMemberScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text('see_all'.tr,
                              style: CustomTheme.seeAllBtnStyle),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
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
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                        imageUrl: userList[index]
                                            .profileUrl
                                            .toString(),
                                        fit: BoxFit.fill,
                                        width: 60.0,
                                        height: 60.0,
                                        imageBuilder: (context, imageProvider) {
                                          return CircleAvatar(
                                            radius: 30,
                                            backgroundColor: grey,
                                            backgroundImage: NetworkImage(
                                              userList[index]
                                                  .profileUrl
                                                  .toString(),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(
                                              strokeCap: StrokeCap.round,
                                            ),
                                        errorWidget: (context, url, error) =>
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
                                              decoration: BoxDecoration(
                                                color: greenColor,
                                                border: Border.all(
                                                    color: white, width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(50),
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
                                width: 70,
                                child: Text(
                                  userList[index].name.toString().capitalized(),
                                  softWrap: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('team'.tr +'(0)',
                          style: CustomTheme.textField_Headertext_Style),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child:
                            Text('see_all'.tr, style: CustomTheme.seeAllBtnStyle),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      'No Team Found',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }
        }
      },
    ));
  }
}
