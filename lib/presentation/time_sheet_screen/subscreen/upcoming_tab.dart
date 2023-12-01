import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/presentation/property_details_screen/property_details_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timeSheet_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/navigator_function.dart';
import '../../../utils/const.dart';
import '../../widgets/custom_circular_image_widget.dart';
import 'package:http/http.dart' as http;

class UpcomingWidgetTab extends StatefulWidget {
  const UpcomingWidgetTab({super.key});

  @override
  State<UpcomingWidgetTab> createState() => _UpcomingWidgetTabState();
}

Future<TimeSheetModel> getTimeSheetList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  String apiUrl = baseUrl + apiRoutes['timeSheet']!;
  final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

  var data = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    return TimeSheetModel(upcomming: data);
  } else {
    return TimeSheetModel(upcomming: data);
  }
}

class _UpcomingWidgetTabState extends State<UpcomingWidgetTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TimeSheetModel>(
        future: getTimeSheetList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            print(snapshot.data!.upcomming.toString());
            return ListView.builder(
                physics:NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.upcomming!.length,
                // itemCount: snapshot.data!.activeData!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            screenNavigator(context, PropertyDetailsScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: CustomCircularImage.getlgCircularImage(
                                      '',
                                      // dummytimeSheetData[index].imageUrl,
                                      '',
                                      false)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    // dummytimeSheetData[index].title,
                                    '',
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    // dummytimeSheetData[index].date,
                                    '',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    // dummytimeSheetData[index].time,
                                    '',
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                // dummytimeSheetData[index].shiftTime,
                                '',
                                style: TextStyle(
                                    fontSize: 11, color: primaryColor),
                              ),
                            ]),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                });
          }
        });
  }
}
