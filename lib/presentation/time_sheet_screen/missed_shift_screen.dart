import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/time_sheet_screen/model/missed_shift_model.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/missed_shift_details.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/time_sheet_model.dart';
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
                return ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            onTap: () {
                              screenNavigator(
                                  context,
                                  MissedShiftDetailsScreen(
                                    details: snapshot.data!.data![index],
                                    imageBaseUrl:
                                        snapshot.data!.propertyImageBaseUrl,
                                  ));
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            dense: false,
                            leading: CustomCircularImage.getCircularImage(
                                snapshot.data!.propertyImageBaseUrl.toString(),
                                snapshot.data!.data![index].propertyAvatars!
                                    .first.propertyAvatar
                                    .toString(),
                                false,
                                30,
                                0,
                                0),
                            /*Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                      imageUrl: snapshot
                                              .data!.propertyImageBaseUrl
                                              .toString() +
                                          '/' +
                                          snapshot
                                              .data!
                                              .data![index]
                                              .propertyAvatars!
                                              .first
                                              .propertyAvatar
                                              .toString(),
                                      fit: BoxFit.fill,
                                      // width: 60,
                                      // height: 60,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                            strokeCap: StrokeCap.round,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            'assets/sgt_logo.jpg',
                                            fit: BoxFit.fill,
                                          )),
                                ),
                                radius: 30,
                                backgroundColor: seconderyColor,
                              ),
                            ),*/
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  snapshot.data!.data![index].propertyName
                                      .toString(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  DateFormat.MMMMEEEEd().format(DateTime.parse(
                                      snapshot
                                          .data!.data![index].shift!.shiftDate
                                          .toString())),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                  '${snapshot.data!.data![index].shift!.clockIn.toString()}-${snapshot.data!.data![index].shift!.clockOut.toString()}'),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  getDifference(
                                          snapshot
                                              .data!.data![index].shift!.clockIn
                                              .toString(),
                                          snapshot.data!.data![index].shift!
                                              .clockOut
                                              .toString())
                                      .toString(),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  height: 20,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'Missed',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              }
            }))
        /* SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dummytimeSheetData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            screenNavigator(
                                context, MissedShiftDetailsScreen());
                          },
                          contentPadding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 0),
                          dense: false,
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: grey,
                            backgroundImage: NetworkImage(
                              dummytimeSheetData[index].imageUrl,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                dummytimeSheetData[index].title,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                dummytimeSheetData[index].date,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(dummytimeSheetData[index].time),
                          ),
                          trailing: Column(
                            children: [
                              Text(dummytimeSheetData[index].shiftTime),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    'Missed',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 80),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),*/
        );
  }
}
