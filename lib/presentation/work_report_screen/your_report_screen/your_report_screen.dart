import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/model/report_list_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/day_wise_reports_widget.dart';
import 'widget/recent_report_card.dart';
import 'package:http/http.dart' as http;

class YourReportScreen extends StatefulWidget {
  const YourReportScreen({super.key});

  @override
  State<YourReportScreen> createState() => _YourReportScreenState();
}

List<ReportResponse> reportDatum = [];

class _YourReportScreenState extends State<YourReportScreen> {
  Future<ReportListModel> getShiftList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['myReport']!;

    Map<String, dynamic> myJsonBody = {
      'is_filtered': "1",
      'report_type': '',
      'date_range': "",
      'date_from': '',
      'date_to': "",
      'property_view': ''
    };

    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);

    if (response.statusCode == 200) {
      final ReportListModel responseModel =
          reportListModelFromJson(response.body);
      reportDatum = responseModel.response ?? [];
      print('Reports: $reportDatum');
      return responseModel;
    } else {
      return ReportListModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: "Your Reports"),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
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
                      itemCount: snapshot.data!.response!.length,
                      itemBuilder: (context, index) {
                        final myData = snapshot.data!.response![index];
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircleAvatar(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                            imageUrl: '' + '/' + '',
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(
                                                  strokeCap: StrokeCap.round,
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                                      'assets/sgt_logo.jpg',
                                                      fit: BoxFit.fill,
                                                    )),
                                      ),
                                      radius: 20,
                                      backgroundColor: seconderyColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Report title',
                                        style: CustomTheme.blueTextStyle(
                                            15, FontWeight.w400),
                                      ),
                                      Text(
                                        myData.reportType.toString(),
                                        style: CustomTheme.blackTextStyle(12),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: CustomTheme.seconderyColor,
                            )
                          ],
                        );
                      });
                }
              })),
        )
        // FutureBuilder(
        //   future: getShiftList(),
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) {
        //           return SizedBox(
        //             height: MediaQuery.of(context).size.height / 1.3,
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     } else {
        //       return SingleChildScrollView(
        //           child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 16),
        //         child: Column(
        //           children: [
        //             SizedBox(
        //               height: 30,
        //             ),
        //             RecentReportCardWidget(myData: reportDatum),
        //             SizedBox(
        //               height: 30,
        //             ),
        //             DayWiseReportWidget()
        //           ],
        //         ),
        //       ));
        //     }
        //   },
        // )
        );
  }
}
