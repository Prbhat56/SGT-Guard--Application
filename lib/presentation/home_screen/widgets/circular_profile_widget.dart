import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/presentation/home_screen/model/GuardHome.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../connect_screen/widgets/chatting_screen.dart';
import 'package:http/http.dart' as http;

// class CircularProfile extends StatelessWidget {
class CircularProfile extends StatefulWidget {
  final void Function(int) myCallback;
   CircularProfile({super.key,required this.myCallback});

  @override
  State<CircularProfile> createState() => _CircularProfileState();
}

class _CircularProfileState extends State<CircularProfile> {
  late 
  List<ChatUsers> userList = [];

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
                userList = data ?.map((e) => ChatUsers.fromJson(
                            e.data() as Map<String, dynamic>))
                        .toList() ?? [];
                widget.myCallback(userList.length);
                userList.removeWhere((element) =>
                    element.id == FirebaseHelper.user.uid.toString());

                if (userList.isNotEmpty) {
                  return ListView.builder(
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
                                      imageUrl:
                                          userList[index].profileUrl.toString(),
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
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            )
                          ],
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
      /*Expanded(
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
                      itemCount: snapshot.data!.teams!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                //screenNavigator(context, ChattingScreen(index: index));
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
              }))*/
    ]));
  }
}
