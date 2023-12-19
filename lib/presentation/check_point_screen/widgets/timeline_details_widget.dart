import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/presentation/work_report_screen/checkpoint_report_screen.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../qr_screen/chack_in_points_scanning_screen.dart';

class TimeLineDetailsWidget extends StatefulWidget {
  int? propertyId;
  TimeLineDetailsWidget({super.key, required this.propertyId});

  @override
  State<TimeLineDetailsWidget> createState() => _TimeLineDetailsWidgetState();
}
List<Checkpoint> checkpointList =[];

class _TimeLineDetailsWidgetState extends State<TimeLineDetailsWidget> {
  Future<CheckPointPropertyWise> getCheckpointsList(property_id) async {
    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  Map<String,String> myJsonBody = {'property_id': property_id.toString()};
  String apiUrl = baseUrl + apiRoutes['checkpointListPropertyWise']!;
  final response =
      await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
  if (response.statusCode == 201) {
    final CheckPointPropertyWise responseModel =
        checkPointPropertyWiseFromJson(response.body);
        checkpointList = responseModel.checkpoints ?? [];
    return responseModel;
  } else {
    return CheckPointPropertyWise(
      status: response.statusCode,
    );
  }
    } catch (e) {
      print("777777777777777========> ${e.toString()}");
    }
    return CheckPointPropertyWise(
      status: 400,
    );
}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCheckpointsList(widget.propertyId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Container(
                    height: 60, width: 60, child: CircularProgressIndicator()));
          } else {
            return Container(
              height: 81 * 6,
              width: 100,
              // color: Colors.amber,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: checkpointList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        screenNavigator(context, CheckPointScanningScreen());
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 287,
                            height: 80,
                            // margin: EdgeInsets.only(right: 20),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              color: 
                              // index == 0 ? seconderyMediumColor :
                               white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      // 'Building Hallway 1',
                                      checkpointList[index]
                                          .propertyName
                                          .toString(),
                                      style: CustomTheme.blueTextStyle(
                                          13, FontWeight.w400),
                                    ),
                                    Text(
                                      // checkpointList[index]..toString(),
                                      'Check-in by 11:00 am', // checkin time missing in ApiResponse
                                      style: CustomTheme.greyTextStyle(10),
                                    )
                                  ],
                                ),
                                SizedBox(width: 73),
                                CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          snapshot.data!.imageBaseUrl! +
                                              '' +''
                                              // checkpointList[index]
                                              //   .checkPointAvatar!.first.checkpointAvatars.toString(),
                                          // 'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                                        ),
                                      )
                              
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 287,
                            child: Divider(
                              height: 0,
                              color: seconderyColor,
                              thickness: 2,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }
}
