import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/connect_screen/widgets/chatting_screen.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/presentation/widgets/main_appbar_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';
import '../connect_screen/widgets/chat_model.dart';
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: MainAppBarWidget(appBarTitle: 'Greylock Security'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:
                    Text('Team', style: CustomTheme.textField_Headertext_Style),
              ),
              FutureBuilder<GuardHome>(
              future: getAllGuardListAPI(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return
              Container(
                //giving height to the list view by multiplying
                //the height of one widget with length of data
                // height: 74 * dummyData.length.toDouble(),
                height: 74 * snapshot.data!.teams!.data!.length.toDouble(),
                child: ListView.builder(
                    // itemCount: dummyData.length,
                    itemCount: snapshot.data!.teams!.data!.length,
                    physics:
                        NeverScrollableScrollPhysics(), //stoping default scrolling behaviour
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
                                    snapshot.data!.imageBaseUrl.toString(),
                                    snapshot.data!.teams!.data![index].avatar.toString(),
                                      // '',
                                      // dummyData[index].profileUrl,
                                    snapshot.data!.teams!.data![index].apiToken !=null ? true :   
                                      false,
                                      25,
                                      4,
                                      43),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.teams!.data![index].firstName.toString()+''+
                                        snapshot.data!.teams!.data![index].lastName.toString(),
                                        // dummyData[index].name,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        (snapshot.data!.teams!.data![index].street != null ? snapshot.data!.teams!.data![index].street.toString():'')+' '+
                                        (snapshot.data!.teams!.data![index].cityText != null ?  snapshot.data!.teams!.data![index].cityText.toString():''),
                                        // dummyData[index].location,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        snapshot.data!.teams!.data![index].guardPosition.toString(),
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
                    }),
              );
                }
              }
              )
            ],
          ),
        ),
      ),
    );
  }
}
