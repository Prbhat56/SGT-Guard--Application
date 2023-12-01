import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import '../../property_details_screen/property_details_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timeSheet_model.dart';
import 'package:http/http.dart' as http;


class CompletedWidgetTab extends StatefulWidget {
  const CompletedWidgetTab({super.key});

  @override
  State<CompletedWidgetTab> createState() => _CompletedWidgetTabState();
}

Future<TimeSheetModel> getTimeSheetList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  String apiUrl = baseUrl + apiRoutes['timeSheet']!;
  final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

  var data = jsonDecode(response.body.toString());
  // print("data ==> $data");
  if (response.statusCode == 200) {
    return TimeSheetModel.fromJson(data);
  } else {
    return TimeSheetModel.fromJson(data);
  }
}

class _CompletedWidgetTabState extends State<CompletedWidgetTab> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: FutureBuilder<TimeSheetModel>(
              future: getTimeSheetList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.completed!.length,
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
                                snapshot.data!.propertyImageBaseUrl.toString(),
                                snapshot.data!.completed![index].shifts![index].propertyImage.toString(),
                                // '',
                                // '',
                                false
                                // '',dummytimeSheetData[index].imageUrl, false
                                )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              snapshot.data!.completed![index].shifts![index].propertyName.toString(),
                              // '',
                              // dummytimeSheetData[index].title,
                              style: const TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              snapshot.data!.completed![index].shifts![index].date.toString(),
                              // 'date',
                              // dummytimeSheetData[index].date,
                              style: const TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!.completed![index].shifts![index].clockIn.toString(),
                              // '',
                              // dummytimeSheetData[index].time,
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                        Spacer(),
                        // Text(
                        //   "${dummytimeSheetData[index].shiftTime} Ago",
                        //   style: TextStyle(fontSize: 11, color: primaryColor),
                        // ),
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
           else {
            if(snapshot.hasError){
              print(snapshot.error);
              return Text(
                      snapshot.error.toString(),
                      style: const TextStyle(
                            fontSize: 11, color: Colors.grey),
              );
            }
            else{
                return CircularProgressIndicator();
                }
        }
      }
    ),
    );
  }
}
