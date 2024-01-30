import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/model/report_list_model.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/widget/custom_filter_report.dart';
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
String imgUrl = '';

class _YourReportScreenState extends State<YourReportScreen> {
  int propView = 0;
  int dateRange = 0;
  String fromDate = '';
  String toDate = '';
  String reportType = '';

  void _onData(
      int _propView, int _dateRange, String _from, String _to, String _type) {
    print(_propView);
    print(_dateRange);
    print(_from);
    print(_to);
    print(_type);

    propView = _propView;
    dateRange = _dateRange;
    fromDate = _from;
    toDate = _to;
    reportType = _type;
  }

  Future<ReportListModel> getShiftList(
      int propView, int dateRange, String from, String to, String type) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, String> myHeader = <String, String>{
        "Authorization": "Bearer ${prefs.getString('token')}",
      };
      String apiUrl = baseUrl + apiRoutes['myReport']!;

      Map<String, dynamic> myJsonBody = {
        'is_filtered': "1",
        'property_view': propView.toString(),
        'date_range': dateRange.toString(),
        'date_from': from.toString(),
        'date_to': to.toString(),
        'report_type': type.toString(),
      };
      print(myJsonBody);
      final response = await http.post(Uri.parse(apiUrl),
          headers: myHeader, body: myJsonBody);

      if (response.statusCode == 200) {
        final ReportListModel responseModel =
            reportListModelFromJson(response.body);
        reportDatum = responseModel.response ?? [];
        imgUrl = responseModel.imageBaseUrl ?? '';
        return responseModel;
      } else {
        return ReportListModel();
      }
    } catch (e) {
      print('error caught: $e');
      return ReportListModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          shadowColor: Color.fromARGB(255, 186, 185, 185),
          elevation: 6,
          backgroundColor: white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Your Reports',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    showDragHandle: false,
                    enableDrag: false,
                    isDismissible: false,
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    builder: (context) {
                      return FilterReportWidget(onData: _onData);
                    }).whenComplete(
                  () {
                    getShiftList(
                        propView, dateRange, fromDate, toDate, reportType);
                    setState(() {});
                  },
                );
              },
              icon: Icon(
                Icons.filter_alt_rounded,
                color: primaryColor,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
              future: getShiftList(
                  propView, dateRange, fromDate, toDate, reportType),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return reportDatum.isEmpty
                      ? SizedBox(
                          child: Center(
                            child: Text(
                              'No Report Found',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                final myData = reportDatum[index];
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CircleAvatar(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                  imageUrl: imgUrl +
                                                      '${myData.images!.length != 0 ? myData.images!.first.toString() : ''}',
                                                  fit: BoxFit.fill,
                                                  width: 40,
                                                  height: 40,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(
                                                        strokeCap:
                                                            StrokeCap.round,
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                            'assets/sgt_logo.jpg',
                                                            fit: BoxFit.fill,
                                                          )),
                                            ),
                                            radius: 20,
                                            backgroundColor: Colors.transparent,
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
                                              myData.subject.toString(),
                                              style: CustomTheme.blueTextStyle(
                                                  15, FontWeight.w400),
                                            ),
                                            Text(
                                              myData.reportType.toString(),
                                              style: CustomTheme.blackTextStyle(
                                                  12),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                        color: primaryColor,
                                      ),
                              itemCount: reportDatum.length),
                        );
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
