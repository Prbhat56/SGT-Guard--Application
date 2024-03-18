import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/time_sheet_screen/model/missed_shift_model.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/missed_shift_details.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MissedShiftScreen extends StatefulWidget {
  const MissedShiftScreen({super.key});

  @override
  State<MissedShiftScreen> createState() => _MissedShiftScreenState();
}

List<MissedDatum> shiftDatum = [];
String imgBaseUrl = '';

class _MissedShiftScreenState extends State<MissedShiftScreen> {
  getDifference(String date1, String date2) {
    var dt1 = DateFormat("HH:mm:ss").parse(date1);
    var dt2 = DateFormat("HH:mm:ss").parse(date2);
    Duration duration = dt2.difference(dt1).abs();
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours Hrs $minutes mins';
  }

  Future<MissedShiftModel> getShiftList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['missedShiftList']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

    if (response.statusCode == 200) {
      final MissedShiftModel responseModel =
          missedShiftModelFromJson(response.body);
      shiftDatum = responseModel.data ?? [];
      print('Shift: $shiftDatum');
      imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
      return responseModel;
    } else {
      return MissedShiftModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Missed Shifts'),
        body: FutureBuilder(
            future: getShiftList(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  screenNavigator(
                                      context,
                                      MissedShiftDetailsScreen(
                                        details: shiftDatum[index],
                                        imageBaseUrl: imgBaseUrl,
                                      ));
                                },
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                dense: false,
                                leading: CustomCircularImage.getCircularImage(
                                    imgBaseUrl.toString(),
                                    shiftDatum[index]
                                        .propertyAvatars!
                                        .first
                                        .propertyAvatar
                                        .toString(),
                                    false,
                                    30,
                                    0,
                                    0),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shiftDatum[index].propertyName.toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      shiftDatum[index].lastShiftTime.toString(),
                                      // shiftDatum[index].shift == null
                                      //     ? ''
                                      //     :
                                          //  '${DateFormat.MMMMEEEEd().format(DateTime.parse(shiftDatum[index].shift!.shiftDate.toString()))}'
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                      '${shiftDatum[index].shift == null ? '' : shiftDatum[index].shift!.clockIn.toString()} - ${shiftDatum[index].shift == null ? '' : shiftDatum[index].shift!.clockOut.toString()}'),
                                ),
                                trailing: Column(
                                  children: [
                                    // Text(
                                    //   getDifference(
                                    //           shiftDatum[index].shift == null
                                    //               ? ''
                                    //               : shiftDatum[index]
                                    //                   .shift!
                                    //                   .clockIn
                                    //                   .toString(),
                                    //           shiftDatum[index].shift == null
                                    //               ? ''
                                    //               : shiftDatum[index]
                                    //                   .shift!
                                    //                   .clockOut
                                    //                   .toString())
                                    //       .toString(),
                                    // ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          'Missed',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                              color: primaryColor,
                            ),
                        itemCount: shiftDatum.length));
              }
            })));
  }
}
