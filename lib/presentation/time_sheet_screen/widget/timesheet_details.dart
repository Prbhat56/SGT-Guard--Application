import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/property_details_screen/cubit/showmore/showmore_cubit.dart';
import 'package:sgt/presentation/property_details_screen/property_details_screen.dart';
import 'package:sgt/presentation/property_details_screen/widgets/job_details_widget.dart';
import 'package:sgt/presentation/property_details_screen/widgets/map_card_widget.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timesheet_details_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/your_report_screen.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/font_style.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../authentication_screen/sign_in_screen.dart';

class TimeSheetDetailsWidget extends StatefulWidget {
  String propId = '';
  String propName = '';
  String shiftId = '';
  String shiftDate = '';
  TimeSheetDetailsWidget(
      {super.key, required this.propId, required this.propName,required this.shiftId,required this.shiftDate});

  @override
  State<TimeSheetDetailsWidget> createState() => _TimeSheetDetailsWidgetState();
}

TimeSheetData detailsData = TimeSheetData();
String imgBaseUrl = '';

class _TimeSheetDetailsWidgetState extends State<TimeSheetDetailsWidget> {

  // Future<TimeSheetDetailsModel> getTimeSheetList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Map<String, String> myHeader = <String, String>{
  //     "Authorization": "Bearer ${prefs.getString('token')}",
  //   };
  //   String apiUrl = baseUrl + 'guard/duty-details/${widget.propId}';
  //   final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
  //   if (response.statusCode == 201) {
  //     final TimeSheetDetailsModel responseModel =
  //         timeSheetDetailsModelFromJson(response.body);
  //     detailsData = responseModel.data!;
  //     imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
  //     return responseModel;
  //   } else {
  //     return TimeSheetDetailsModel();
  //   }
  // }

   Future getTimeSheetList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
     Map<String, String> myJsonBody = {
        'property_id': widget.propId,
        'shift_id': widget.shiftId,
        'shift_date':widget.shiftDate,
      };
    String apiUrl = baseUrl + 'guard/timesheet-details';
    final response = await http.post(Uri.parse(apiUrl), headers: myHeader,body: myJsonBody);
    if (response.statusCode == 201) {
      final TimeSheetDetailsModel responseModel =
          timeSheetDetailsModelFromJson(response.body);
      detailsData = responseModel.data!;
      imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
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
        return TimeSheetDetailsModel();
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
  print("-------propId--------> ${widget.propId}");
  print("-------shiftId--------> ${widget.shiftId}");
  print("-------shiftdate--------> ${widget.shiftDate}");
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: widget.propName),
      body: FutureBuilder(
        future: getTimeSheetList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3.h,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      margin: EdgeInsets.all(15.w),
                      height: 140.h,
                      width: MediaQuery.of(context).size.width * 0.8.w,
                      decoration: BoxDecoration(
                        color: seconderyMediumColor,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CachedNetworkImage(
                                  imageUrl: (imgBaseUrl.toString() +
                                      '' +
                                      detailsData
                                          .propertyAvatars!.first.propertyAvatar
                                          .toString()),
                                  fit: BoxFit.fill,
                                  width: 100.w,
                                  height: 100.h,
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
                            radius: 50.r,
                            backgroundColor: Colors.transparent,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.w,
                              top: 40.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 180.w,
                                  child: Text(
                                    widget.propName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: 
                                    TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: black,
                                      ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    // 'shift_time'.tr+': ',${detailsData.shifts!.isEmpty ? '' : detailsData.shifts!.first.clockIn.toString()} - ${detailsData.shifts!.isEmpty ? '' : detailsData.shifts!.first.clockOut.toString()}',
                                  'shift_time'.tr+': '+'${detailsData.jobDetails!.shiftTime.toString()}',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldHeaderWidget(title: 'completed_checkpoints'.tr+':'),
                        TextFieldHeaderWidget(title: detailsData.jobDetails!.completedCheckpoint.toString())
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldHeaderWidget(title: 'missed_checkpoints'.tr+':'),
                        TextFieldHeaderWidget(title: detailsData.jobDetails!.remainingCheckpoint.toString())
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldHeaderWidget(title: 'clock_in_time'.tr+':'),
                        TextFieldHeaderWidget(
                            title: detailsData.shifts!.isEmpty
                                ? ''
                                : detailsData.shifts!.first.actualClockin.toString())
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldHeaderWidget(title: 'clock_out_time'.tr+':'),
                        TextFieldHeaderWidget(
                            title: detailsData.shifts!.isEmpty
                                ? ''
                                : detailsData.shifts!.first.actualClockOut.toString())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        screenNavigator(context, YourReportScreen(
                          property_id:detailsData.id.toString(),
                          shift_id:detailsData.shifts!.first.id.toString(),
                          shift_date:detailsData.shifts!.first.date,
                        ));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5.h, horizontal: 14.w),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: primaryColor)),
                        child: Text(
                          "view_report".tr,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 2.0,
                    child: DecoratedBox(
                      decoration:
                          BoxDecoration(color: Colors.grey.withAlpha(50)),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: 20.h, horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldHeaderWidget(title: 'job_details'.tr),
                            SizedBox(height: 10.h),
                            JobDetailsWidget(jobDetails: detailsData.jobDetails)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 2.0,
                    child: DecoratedBox(
                      decoration:
                          BoxDecoration(color: Colors.grey.withAlpha(50)),
                    ),
                  ),
                  //const SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20, horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldHeaderWidget(title: 'description'.tr),
                        SizedBox(height: 10),
                        // Text(
                        //   detailsData.propertyDescription.toString(),
                        //   maxLines:
                        //       context.watch<ShowmoreCubit>().state.showmore
                        //           ? 1000
                        //           : 3,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //   ),
                        // ),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 300.w,
                                  child: Text(
                                    detailsData.propertyDescription.toString(),
                                    maxLines: context
                                            .watch<ShowmoreCubit>()
                                            .state
                                            .showmore
                                        ? 1000
                                        : 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                context.watch<ShowmoreCubit>().state.showmore
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          context
                                              .read<ShowmoreCubit>()
                                              .showMore();
                                          print(context
                                              .read<ShowmoreCubit>()
                                              .state
                                              .showmore);
                                        },
                                        child: Text(
                                          'more',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: primaryColor),
                                        ),
                                      )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 2.0,
                    child: DecoratedBox(
                      decoration:
                          BoxDecoration(color: Colors.grey.withAlpha(50)),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.h, horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldHeaderWidget(title: 'location'.tr),
                        SizedBox(height: 10.h),
                        Text(
                          detailsData.location.toString(),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        SizedBox(height: 20.h),
                        MapCardWidget(
                          currentlocation: LatLng(
                              double.parse(detailsData.latitude.toString())
                                  .toDouble(),
                              double.parse(detailsData.longitude.toString())
                                  .toDouble()),
                        ), //showing map card
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
