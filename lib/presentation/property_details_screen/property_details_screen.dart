// ignore_for_file: unnecessary_import, unused_import

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/account_screen/account_screen.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/check_points_list.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/presentation/property_details_screen/widgets/job_details_widget.dart';
import 'package:sgt/presentation/property_details_screen/widgets/map_card_widget.dart';
import 'package:sgt/presentation/property_details_screen/widgets/property_description_widget.dart';
import 'package:sgt/presentation/property_details_screen/widgets/property_details_widget.dart';
import 'package:sgt/presentation/property_details_screen/widgets/shift_cards.dart';
import 'package:sgt/presentation/qr_screen/scanning_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';
import 'package:sgt/presentation/work_report_screen/work_report_screen.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PropertyDetailsScreen extends StatefulWidget {
  // InactiveDatum? activeData = InactiveDatum();
  String? imageBaseUrl;
  String? propertyImageBaseUrl;
  int? propertyId;
  PropertyDetailsScreen(
      {super.key,
      // this.activeData,
      this.imageBaseUrl,
      this.propertyId,
      this.propertyImageBaseUrl});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

bool? disable = true;
Data? detailsData = Data();
var jobDetailDataFetched;
String? imageBaseUrlData;
String? propertyImageBaseUrlData;
class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {

 @override
  void initState() {
    super.initState();
   jobDetailDataFetched = getJobDetailList(widget.propertyId);
  }


  
  Future getJobDetailList(property_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl =
        baseUrl + apiRoutes['dutyDetails']! + property_id.toString();
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    // var data = jsonDecode(response.body.toString());
    // print(data);
    if (response.statusCode == 201) {
      final PropertyDetailsModel responseModel =
          propertyDetailsModelFromJson(response.body);
      detailsData = responseModel.data ?? Data();
      imageBaseUrlData = responseModel.imageBaseUrl;
      propertyImageBaseUrlData = responseModel.propertyImageBaseUrl;
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
        return PropertyDetailsModel(
        status: response.statusCode,
      );
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: CustomAppBarWidget(appbarTitle: 'Property Detail'),
          body: FutureBuilder(
              future: jobDetailDataFetched,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
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
                        PropertyDetailsWidget(
                            imageBaseUrl: propertyImageBaseUrlData,
                            detailsData: detailsData,
                            checkPoint:
                                detailsData!.checkpointCount.toString()
                            // widget.activeData!.checkPoints!.length.toString(),
                            ),
                        SizedBox(
                          width: double.infinity,
                          height: 2.h,
                          child: DecoratedBox(
                            decoration:
                                BoxDecoration(color: Colors.grey.withAlpha(50)),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //mapping the customIconsData list
                            //to show all the icons
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      screenNavigator(
                                          context,
                                          ScanningScreen(
                                              propertyId:
                                                  detailsData!.id));
                                    },
                                    child: Container(
                                      height: 32.h,
                                      width: 32.w,
                                      padding: EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: SvgPicture.asset(
                                        'assets/qr1.svg',
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'Scan QR',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      screenNavigator(
                                          context,
                                          CheckPointListsScreen(
                                            propertyId: widget.propertyId,
                                            imageBaseUrl: widget.imageBaseUrl,
                                          ));
                                    },
                                    child: Container(
                                      height: 32.h,
                                      width: 32.w,
                                      padding: EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: SvgPicture.asset(
                                        'assets/map.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'Checkpoints',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      screenNavigator(
                                          context,
                                          WorkReportScreen(
                                            propertyId: detailsData!.id
                                                .toString(),
                                            propertyName: detailsData!.propertyName,
                                          ));
                                    },
                                    child: Container(
                                      height: 32.h,
                                      width: 32.w,
                                      padding: EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: SvgPicture.asset(
                                        'assets/plus.svg',
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'Report',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                            ]
                            // customIconsData
                            //     .map((e) => CustomIconWidget(
                            //           iconUrl: e.iconUrl,
                            //           title: e.title,
                            //           widget: e.widget,
                            //           // checkpoint: widget.activeData!.checkPoints,
                            //           // imgUrl: widget.imageBaseUrl,
                            //         ))
                            //     .toList()
                            ),
                        SizedBox(height: 25.h),
                        SizedBox(
                          width: double.infinity,
                          height: 2.h,
                          child: DecoratedBox(
                            decoration:
                                BoxDecoration(color: Colors.grey.withAlpha(50)),
                          ),
                        ), //widget to create top property detials card
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldHeaderWidget(title: 'Upcoming Shifts'),
                              const SizedBox(height: 10),
                              // ShiftCards(shifts: widget.activeData!.shifts), //shift cards widget
                              detailsData!.shifts!.length != 0
                                  ? ShiftCards(
                                      shifts: detailsData!.shifts,
                                      imageBaseUrl: imageBaseUrlData)
                                  : Text(
                                      'No Upcoming Shift Available',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                    ),
                              SizedBox(height: 20.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldHeaderWidget(title: 'Job Details'),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Guard Name: ',
                                              style: CustomTheme.blackTextStyle(
                                                  15.sp)),
                                          Text(
                                            '${detailsData!.jobDetails == null ? '' : detailsData!.jobDetails!.firstName.toString()} ${detailsData!.jobDetails == null ? '' : detailsData!.jobDetails!.lastName.toString()}',
                                            style: CustomTheme.blueTextStyle(
                                                15.sp, FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Position: ',
                                              style: CustomTheme.blackTextStyle(
                                                  15.sp)),
                                          Text(
                                            ' ${detailsData!.jobDetails == null ? '' : detailsData!.jobDetails!.guardPosition.toString()}',
                                            style: CustomTheme.blueTextStyle(
                                                15.sp, FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Shift Time: ',
                                              style: CustomTheme.blackTextStyle(
                                                  15.sp)),
                                          Text(
                                            '${detailsData!.jobDetails == null ? "" : detailsData!.jobDetails!.shiftTime.toString()}',
                                            style: CustomTheme.blueTextStyle(
                                                15.sp, FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 19.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Emergency Contact",
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w500,
                                                color: black),
                                          ),
                                          detailsData!.emergencyContact!
                                                      .length <=
                                                  1
                                              ? Container()
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      disable = !disable!;
                                                    });
                                                  },
                                                  child: Text(
                                                    disable == true
                                                        ? 'Show more'
                                                        : 'Show less',
                                                    style:
                                                        // detailsData!
                                                        //             .emergencyContact!
                                                        //             .length <=
                                                        //         1
                                                        //     ? TextStyle(
                                                        //         fontSize: 13.sp,
                                                        //         color:
                                                        //             Colors.grey.shade500,
                                                        //         fontWeight:
                                                        //             FontWeight.w500)
                                                        //     :
                                                        CustomTheme
                                                            .blueTextStyle(
                                                                15.sp,
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      disable == true
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                                Text(
                                                  'Contact 1',
                                                  style:
                                                      CustomTheme.blueTextStyle(
                                                          15.sp,
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                                TextFormField(
                                                  initialValue: detailsData!
                                                      .emergencyContact!
                                                      .first
                                                      .contactName
                                                      .toString(),
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1.w,
                                                            color: CustomTheme
                                                                .seconderyLightColor)),
                                                    label: Text(
                                                      'Name',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                TextFormField(
                                                  initialValue: detailsData!
                                                      .emergencyContact!
                                                      .first
                                                      .contactNumber
                                                      .toString(),
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1.w,
                                                            color: CustomTheme
                                                                .seconderyLightColor)),
                                                    label: Text(
                                                      'Mobile Number',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       left: 19.w),
                                                //   child: Text(
                                                //     'Name',
                                                //     style: TextStyle(
                                                //         fontSize: 12.sp,
                                                //         color: Colors
                                                //             .grey.shade700,
                                                //         fontWeight:
                                                //             FontWeight.w400),
                                                //   ),
                                                // ),
                                                // Container(
                                                //   width: MediaQuery.of(context)
                                                //           .size
                                                //           .width *
                                                //       .9,
                                                //   padding: EdgeInsets.symmetric(
                                                //       horizontal: 19.w,
                                                //       vertical: 14.h),
                                                //   decoration: BoxDecoration(
                                                //       color: CustomTheme.white,
                                                //       border: Border.all(
                                                //           width: 1.w,
                                                //           color:
                                                //               CustomTheme.grey),
                                                //       borderRadius:
                                                //           BorderRadius.all(
                                                //               Radius.elliptical(
                                                //                   5.r, 5.r))),
                                                //   child: Text(
                                                //     detailsData!
                                                //         .emergencyContact!
                                                //         .first
                                                //         .contactName
                                                //         .toString(),
                                                //     style: TextStyle(
                                                //         fontSize: 15.sp,
                                                //         color: Colors
                                                //             .grey.shade700,
                                                //         fontWeight:
                                                //             FontWeight.w400),
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       left: 19.w),
                                                //   child: Text(
                                                //     'Mobile Number',
                                                //     style: TextStyle(
                                                //         fontSize: 12.sp,
                                                //         color: Colors
                                                //             .grey.shade700,
                                                //         fontWeight:
                                                //             FontWeight.w400),
                                                //   ),
                                                // ),
                                                // Container(
                                                //   width: MediaQuery.of(context)
                                                //           .size
                                                //           .width *
                                                //       .9,
                                                //   padding: EdgeInsets.symmetric(
                                                //       horizontal: 19.w,
                                                //       vertical: 14.h),
                                                //   decoration: BoxDecoration(
                                                //       color: CustomTheme.white,
                                                //       border: Border.all(
                                                //           width: 1.w,
                                                //           color:
                                                //               CustomTheme.grey),
                                                //       borderRadius:
                                                //           BorderRadius.all(
                                                //               Radius.elliptical(
                                                //                   5.r, 5.r))),
                                                //   child: Text(
                                                //     detailsData!
                                                //         .emergencyContact!
                                                //         .first
                                                //         .contactNumber
                                                //         .toString(),
                                                //     style: TextStyle(
                                                //         fontSize: 15.sp,
                                                //         color: Colors
                                                //             .grey.shade700,
                                                //         fontWeight:
                                                //             FontWeight.w400),
                                                //   ),
                                                // ),
                                              ],
                                            )
                                          : EmergencyContact()
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 2.h,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withAlpha(50)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFieldHeaderWidget(title: 'Description'),
                                  const SizedBox(height: 10),
                                  PropertyDescriptionWidget(
                                    propertyImageBaseUrl:
                                        propertyImageBaseUrlData,
                                    propDesc: detailsData!.propertyDescription,
                                    propvatars: detailsData!.propertyAvatars,
                                  ), //widget to show property details
                                  const SizedBox(height: 25),
                                  TextFieldHeaderWidget(title: 'Location'),
                                  const SizedBox(height: 10),
                                  Text(
                                    detailsData!.location.toString(),
                                    // widget.activeData!.location.toString(),
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  const SizedBox(height: 20),
                                  MapCardWidget(
                                    currentlocation: LatLng(
                                        double.parse(detailsData!.latitude
                                                .toString())
                                            .toDouble(),
                                        double.parse(detailsData!.longitude
                                                .toString())
                                            .toDouble()),
                                  ), //showing map card
                                  const SizedBox(height: 30),
                                  Center(
                                      child: CustomButtonWidget(
                                          buttonTitle: 'Start Shift',
                                          onBtnPress: () {
                                            screenNavigator(
                                                context,
                                                ScanningScreen(
                                                    propertyId: detailsData!.id));
                                          })),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })),
    );
  }

  SizedBox EmergencyContact() {
    return SizedBox(
      height: 180.h * detailsData!.emergencyContact!.length,
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: detailsData!.emergencyContact!.length,
          itemBuilder: (context, index) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'Contact ${index + 1}',
                    style: CustomTheme.blueTextStyle(15.sp, FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  TextFormField(
                    initialValue: detailsData!.emergencyContact![index].contactName
                          .toString(),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.w,
                              color: CustomTheme.grey)),
                      label: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    initialValue: detailsData!.emergencyContact![index].contactNumber
                          .toString(),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.w,
                              color: CustomTheme.grey)),
                      label: Text(
                        'Mobile Number',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),


                  // Padding(
                  //   padding: EdgeInsets.only(left: 19.w),
                  //   child: Text(
                  //     'Name',
                  //     style: TextStyle(
                  //         fontSize: 12.sp,
                  //         color: Colors.grey.shade700,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * .9,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 19.w, vertical: 14.h),
                  //   decoration: BoxDecoration(
                  //       color: CustomTheme.white,
                  //       border: Border.all(width: 1, color: CustomTheme.grey),
                  //       borderRadius:
                  //           BorderRadius.all(Radius.elliptical(5.r, 5.r))),
                  //   child: Text(
                  //     detailsData!.emergencyContact![index].contactName
                  //         .toString(),
                  //     style: TextStyle(
                  //         fontSize: 15.sp,
                  //         color: Colors.grey.shade700,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 19.h),
                  //   child: Text(
                  //     'Mobile Number',
                  //     style: TextStyle(
                  //         fontSize: 12.sp,
                  //         color: Colors.grey.shade700,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * .9,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 19.w, vertical: 14.h),
                  //   decoration: BoxDecoration(
                  //       color: CustomTheme.white,
                  //       border: Border.all(width: 1, color: CustomTheme.grey),
                  //       borderRadius:
                  //           BorderRadius.all(Radius.elliptical(5.r, 5.r))),
                  //   child: Text(
                  //     detailsData!.emergencyContact![index].contactNumber
                  //         .toString(),
                  //     style: TextStyle(
                  //         fontSize: 15.sp,
                  //         color: Colors.grey.shade700,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
                ]);
          }),
    );
  }
}
