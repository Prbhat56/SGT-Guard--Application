import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/model/report_list_model.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/report_details.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/widget/custom_filter_report.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class YourReportScreen extends StatefulWidget {
  const YourReportScreen({super.key});
  @override
  State<YourReportScreen> createState() => _YourReportScreenState();
}

class _YourReportScreenState extends State<YourReportScreen> {
  List<ReportResponse> recentReportDatum = [];

  int current_page = 1;
  late int last_page = 0;
  List<ReportResponse> reportDatum = [];
  String imgUrl = '';

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

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

  Future<ReportListModel> getRecentList(
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
        recentReportDatum = responseModel.recentReports!.data ?? [];
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

  Future<bool> getReportsList(
      int propView, int dateRange, String from, String to, String type) async {
    EasyLoading.show();
    // if (current_page < last_page) {
    //   refreshController.loadNoData();
    //   return true;
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['myReport']!;
    String pageApiUrl = "${apiUrl}?page=$current_page";
    print(pageApiUrl);

    Map<String, dynamic> myJsonBody = {
      'is_filtered': "1",
      'property_view': propView.toString(),
      'date_range': dateRange.toString(),
      'date_from': from.toString(),
      'date_to': to.toString(),
      'report_type': type.toString(),
    };
    print(myJsonBody);
    final response = await http.post(Uri.parse(pageApiUrl),
        headers: myHeader, body: myJsonBody);

    if (response.statusCode == 200) {
      final ReportListModel responseModel =
          reportListModelFromJson(response.body);
      reportDatum.addAll(responseModel.response!.data!);
      imgUrl = responseModel.imageBaseUrl ?? '';

      current_page = responseModel.response!.currentPage ?? 0;

      current_page++;
      print(current_page.toString());
      last_page = responseModel.response!.lastPage ?? 0;
      print('Last page: ${last_page}');
      EasyLoading.dismiss();
      setState(() {});
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getReportsList(propView, dateRange, fromDate, toDate, reportType);
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
                    getRecentList(
                            propView, dateRange, fromDate, toDate, reportType)
                        .whenComplete(() {
                      current_page = 1;
                      reportDatum.clear();
                      getReportsList(
                          propView, dateRange, fromDate, toDate, reportType);
                    });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recents Reports',
                  style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 120,
                child: FutureBuilder(
                    future: getRecentList(
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
                        return recentReportDatum.isEmpty
                            ? SizedBox(
                                child: Center(
                                  child: Text(
                                    'No Report Found',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final myData = recentReportDatum[index];
                                  return Container(
                                    width: 105,
                                    margin: EdgeInsets.only(right: 14),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color: CustomTheme.seconderyMediumColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(children: [
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
                                        height: 10,
                                      ),
                                      Text(
                                        myData.reportType.toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: CustomTheme.blueTextStyle(
                                            10, FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          screenNavigator(
                                              context,
                                              ReportDetailsPage(
                                                recentReportDatum: myData,
                                              ));
                                        },
                                        child: Container(
                                          height: 22,
                                          width: 65,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: CustomTheme.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                                color: CustomTheme.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      )
                                    ]),
                                  );
                                },
                                itemCount: recentReportDatum.length);
                      }
                    })),
              ),
              SizedBox(
                height: 20,
              ),
              Text('All Reports',
                  style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: false,
                  onLoading: () async {
                    final result = await getReportsList(
                        propView, dateRange, fromDate, toDate, reportType);
                    if (result) {
                      if (current_page <= last_page) {
                        refreshController.loadComplete();
                      } else {
                        refreshController.loadNoData();
                      }
                    } else {
                      refreshController.loadFailed();
                    }
                  },
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final myData = reportDatum[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CachedNetworkImage(
                                          imageUrl: imgUrl +
                                              '${myData.images!.length != 0 ? myData.images!.first.toString() : ''}',
                                          fit: BoxFit.fill,
                                          width: 60,
                                          height: 60,
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
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myData.reportType.toString(),
                                        maxLines: 2,
                                        style: CustomTheme.blueTextStyle(
                                            15, FontWeight.w400),
                                      ),
                                      Text(
                                        myData.subject.toString(),
                                        maxLines: 2,
                                        style: CustomTheme.blackTextStyle(12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                            color: Colors.grey,
                          ),
                      itemCount: reportDatum.length),
                ),
              )
            ],
          ),
        ));
  }
}
