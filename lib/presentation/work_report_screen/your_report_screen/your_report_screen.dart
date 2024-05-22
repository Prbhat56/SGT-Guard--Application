import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/model/report_list_model.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/report_details.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/widget/custom_filter_report.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class YourReportScreen extends StatefulWidget {
  String? property_id;
  String? shift_id;
  String? shift_date;
  YourReportScreen(
      {super.key, this.property_id, this.shift_id, this.shift_date});
  @override
  State<YourReportScreen> createState() => _YourReportScreenState();
}

class _YourReportScreenState extends State<YourReportScreen> {
  List<ReportResponse> recentReportDatum = [];

  int current_page = 1;
  late int last_page = 0;
  List<ReportResponse> reportDatum = [];
  String imgUrl = '';
  String propertyImgUrl = '';

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

  Future getRecentList(
    int propView,
    int dateRange,
    String from,
    String to,
    String type,
    String property_id,
    String shift_id,
    String shift_date,
  ) async {
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
        'property_id': property_id.toString(),
        'shift_id': shift_id.toString(),
        'shift_date': shift_date.toString(),
      };
      print(myJsonBody);
      final response = await http.post(Uri.parse(apiUrl),
          headers: myHeader, body: myJsonBody);
      if (response.statusCode == 200) {
        final ReportListModel responseModel =
            reportListModelFromJson(response.body);
        recentReportDatum = responseModel.recentReports!.data ?? [];
        imgUrl = responseModel.imageBaseUrl ?? '';
        propertyImgUrl = responseModel.propertyImageBaseUrl ?? '';
        return responseModel;
      } else {
        if (response.statusCode == 401) {
          print("--------------------------------Unauthorized");
          var apiService = ApiCallMethodsService();
          apiService.updateUserDetails('');
          var commonService = CommonService();
          FirebaseHelper.signOut();
          FirebaseHelper.auth = FirebaseAuth.instance;
          commonService.logDataClear();
          commonService.clearLocalStorage();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('welcome', '1');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false,
          );
        } else {
          return ReportListModel();
        }
      }
    } catch (e) {
      print('error caught: $e');
      return ReportListModel();
    }
  }

  Future getReportsList(
    int propView,
    int dateRange,
    String from,
    String to,
    String type,
    String property_id,
    String shift_id,
    String shift_date,
  ) async {
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
      'property_id': property_id.toString(),
      'shift_id': shift_id.toString(),
      'shift_date': shift_date.toString(),
    };
    print(myJsonBody);
    final response = await http.post(Uri.parse(pageApiUrl),
        headers: myHeader, body: myJsonBody);

    if (response.statusCode == 200) {
      final ReportListModel responseModel =
          reportListModelFromJson(response.body);
      reportDatum.addAll(responseModel.response!.data!);
      print("reports data => ${responseModel.response!.data!}");
      imgUrl = responseModel.imageBaseUrl ?? '';
      propertyImgUrl = responseModel.propertyImageBaseUrl ?? '';

      current_page = responseModel.response!.currentPage ?? 0;

      current_page++;
      print(current_page.toString());
      last_page = responseModel.response!.lastPage ?? 0;
      print('Last page: ${last_page}');
      EasyLoading.dismiss();
      setState(() {});
      return true;
    } else {
      if (response.statusCode == 401) {
        print("--------------------------------Unauthorized");
        var apiService = ApiCallMethodsService();
        apiService.updateUserDetails('');
        var commonService = CommonService();
        FirebaseHelper.signOut();
        FirebaseHelper.auth = FirebaseAuth.instance;
        commonService.logDataClear();
        commonService.clearLocalStorage();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('welcome', '1');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false,
        );
      } else {
        EasyLoading.dismiss();
        return false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getReportsList(
        propView,
        dateRange,
        fromDate,
        toDate,
        reportType,
        widget.property_id == null || widget.property_id == 'null'
            ? ''
            : widget.property_id.toString(),
        widget.shift_id == null || widget.shift_id == 'null'
            ? ''
            : widget.shift_id.toString(),
        widget.shift_date == null || widget.shift_date == 'null'
            ? ''
            : widget.shift_date.toString());
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
              size: 20.sp,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Align(
            alignment: Alignment(-1.1.w, 0.w),
            child: Text(
              'Your Reports',
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            ),
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
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    // RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    builder: (context) {
                      return FilterReportWidget(onData: _onData);
                    }).whenComplete(
                  () {
                    getRecentList(
                            propView,
                            dateRange,
                            fromDate,
                            toDate,
                            reportType,
                            widget.property_id == null
                                ? ''
                                : widget.property_id.toString(),
                            widget.shift_id == null
                                ? ''
                                : widget.shift_id.toString(),
                            widget.shift_date == null
                                ? ''
                                : widget.shift_date.toString())
                        .whenComplete(() {
                      current_page = 1;
                      reportDatum.clear();
                      getReportsList(
                          propView,
                          dateRange,
                          fromDate,
                          toDate,
                          reportType,
                          widget.property_id == null ||
                                  widget.property_id == 'null'
                              ? ''
                              : widget.property_id.toString(),
                          widget.shift_id == null || widget.shift_id == 'null'
                              ? ''
                              : widget.shift_id.toString(),
                          widget.shift_date == null ||
                                  widget.shift_date == 'null'
                              ? ''
                              : widget.shift_date.toString());
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
                        propView,
                        dateRange,
                        fromDate,
                        toDate,
                        reportType,
                        widget.property_id == null ||
                                widget.property_id == 'null'
                            ? ''
                            : widget.property_id.toString(),
                        widget.shift_id == null || widget.shift_id == 'null'
                            ? ''
                            : widget.shift_id.toString(),
                        widget.shift_date == null || widget.shift_date == 'null'
                            ? ''
                            : widget.shift_date.toString()),
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
                                                imageUrl: propertyImgUrl +
                                                    '${myData.propertyAvatars!.length != 0 ? myData.propertyAvatars!.first.propertyAvatar.toString() : ''}',
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
                                        myData.subject.toString(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
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
                                                imgUrl: imgUrl,
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
              Text('all_reports'.tr,
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
                        propView,
                        dateRange,
                        fromDate,
                        toDate,
                        reportType,
                        widget.property_id == null ||
                                widget.property_id == 'null'
                            ? ''
                            : widget.property_id.toString(),
                        widget.shift_id == null || widget.shift_id == 'null'
                            ? ''
                            : widget.shift_id.toString(),
                        widget.shift_date == null || widget.shift_date == 'null'
                            ? ''
                            : widget.shift_date.toString());
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
                            InkWell(
                              onTap: () {
                                screenNavigator(
                                    context,
                                    ReportDetailsPage(
                                      imgUrl: imgUrl,
                                      recentReportDatum: myData,
                                    ));
                              },
                              child: Row(
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
                                            imageUrl: propertyImgUrl +
                                                '${myData.propertyAvatars!.length != 0 ? myData.propertyAvatars!.first.propertyAvatar.toString() : ''}',
                                            fit: BoxFit.fill,
                                            width: 60,
                                            height: 60,
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                myData.subject.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                // maxLines: 2,
                                                style:
                                                    CustomTheme.blueTextStyle(
                                                        15, FontWeight.w400),
                                              ),
                                            ),
                                            Text(
                                              myData.createTime.toString(),
                                              maxLines: 2,
                                              style:
                                                  CustomTheme.greyTextStyle(12),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          myData.createDate.toString(),
                                          maxLines: 2,
                                          style: CustomTheme.blackTextStyle(12),
                                        ),
                                      ],
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
