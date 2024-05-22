import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/home_screen/widgets/circular_profile_widget.dart';
import 'package:sgt/presentation/jobs_screen/jobs_screen.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/property_details_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timeSheet_model.dart';
import 'package:sgt/presentation/time_sheet_screen/time_sheet_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/upcoming_screen.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../widgets/main_appbar_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
// var activeToursDataFetched;
// var upcomingToursDataFetched;

class _HomeScreenState extends State<HomeScreen> {
  // @override void initState() {
  //   // TODO: implement initState
  // // activeToursDataFetched = getJobsList();
  // // upcomingToursDataFetched = getUpcomingJobsList();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   // activeToursDataFetched;
  //   // upcomingToursDataFetched;
  //   super.dispose();
  // }

  int? totalTeams;
  String? propertyImgBaseUrl;
  List<Completed> upcomingData = [];

  Future<DutyListModel> getJobsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['dutyList']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

    if (response.statusCode == 201) {
      final DutyListModel responseModel = dutyModelFromJson(response.body);
      activeDatum = responseModel.activeData ?? [];
      // print('Active: $activeDatum');
      inActiveDatum = responseModel.inactiveData ?? [];
      // print('InActive: $inActiveDatum');
      // imgBaseUrl = responseModel.imageBaseUrl ?? '';
      return responseModel;
    } else {
      return DutyListModel(
          activeData: [],
          inactiveData: [],
          status: response.statusCode,
          imageBaseUrl: '');
    }
  }

  Future<TimeSheetModel> getUpcomingJobsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['timeSheet']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      final TimeSheetModel responseModel =
          timeSheetModelFromJson(response.body);
      upcomingData = responseModel.upcomming ?? [];
      print('Upcoming: ${upcomingData.length}');

      propertyImgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
      return responseModel;
    } else {
      return TimeSheetModel(
          upcomming: [], completed: [], status: 500, propertyImageBaseUrl: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String dateStr = "${today.day}/${today.month}/${today.year}";
    print(dateStr);
    return Scaffold(
      appBar: MainAppBarWidget(
        appBarTitle: 'Security Guard Tracking',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getJobsList();
          getUpcomingJobsList();
          // activeToursDataFetched;
          // upcomingToursDataFetched;
          // setState(() {});
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Team (${totalTeams.toString()})',
                      style: CustomTheme.textField_Headertext_Style),
                  //btn to see all team members
                  InkWell(
                    onTap: () async {
                      //screenNavigator(context, AllTeamMemberScreen());
                      await FirebaseHelper.createGuardLocation('22.572645',
                              '88.363892', 'current_shift', 'checkpId')
                          .then((value) {
                        screenNavigator(context, AllTeamMemberScreen());
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text('see_all'.tr, style: CustomTheme.seeAllBtnStyle),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),*/
              //LocationDetailsCard(),
              FutureBuilder<DutyListModel>(
                  future: getJobsList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Container(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator()));
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: 145,
                            child:
                                CircularProfile(), //showing all team member horizontally
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'active_tours'.tr+ '(${snapshot.data!.activeData!.length})',
                                style: CustomTheme.textField_Headertext_Style,
                              ),
                              //btn to see all the active jobs
                              snapshot.data!.activeData!.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        screenNavigator(context, JobsScreen());
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text('see_all'.tr,
                                            style: CustomTheme.seeAllBtnStyle),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          snapshot.data!.activeData!.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          dateStr,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          snapshot.data!.activeData!.isEmpty
                              ? SizedBox(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Image.asset(
                                            'assets/no_active_jobs.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          'No active jobs',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                              color:
                                                  Colors.grey.withOpacity(0.6)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data!.activeData!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        screenNavigator(
                                            context,
                                            PropertyDetailsScreen(
                                              propertyId: snapshot
                                                  .data!.activeData![index].id,
                                              imageBaseUrl:
                                                  snapshot.data!.imageBaseUrl,
                                              propertyImageBaseUrl: snapshot
                                                  .data!.propertyImageBaseUrl,
                                              // activeData:
                                              //     snapshot.data?.activeData![index],
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 204,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: white,
                                                ),
                                                child: Center(
                                                    child: Image.network(
                                                        snapshot.data!
                                                                .propertyImageBaseUrl
                                                                .toString() +
                                                            snapshot
                                                                .data!
                                                                .activeData![
                                                                    index]
                                                                .propertyAvatars!
                                                                .first
                                                                .propertyAvatar
                                                                .toString(),
                                                        frameBuilder: (context,
                                                            child,
                                                            frame,
                                                            wasSynchronouslyLoaded) {
                                                  return child;
                                                }, loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                }))
                                                // CustomTheme.locationCardStyle(
                                                //     snapshot.data!
                                                //         .propertyImageBaseUrl
                                                //         .toString(),
                                                //     snapshot
                                                //         .data!
                                                //         .activeData![index]
                                                //         .propertyAvatars!
                                                //         .first
                                                //         .propertyAvatar
                                                //         .toString()),
                                                ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // AppFontStyle.FlexibleText(snapshot.data!.activeData![index].propertyName.toString(),AppFontStyle.mediumTextStyle(AppColors.black,17.sp)),
                                                Flexible(
                                                  flex: 1,
                                                  child: Text(
                                                    snapshot
                                                        .data!
                                                        .activeData![index]
                                                        .propertyName
                                                        .toString(),
                                                    // locationData[index].title,
                                                    // maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        // AppFontStyle.mediumTextStyle(AppColors.black,17.sp),
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .activeData![index]
                                                      .latestShiftTime
                                                      .toString(),
                                                  // locationData[index].duty,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: primaryColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: primaryColor,
                                                  size: 15,
                                                ),
                                                Text(
                                                  snapshot
                                                      // .data!.jobs!.data![index].propertyName
                                                      .data!
                                                      .activeData![index]
                                                      .propertyName
                                                      .toString(),
                                                  // locationData[index].subtitle,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Text(
                                                // locationData[index].address,
                                                snapshot.data!
                                                    .activeData![index].location
                                                    // snapshot.data!.jobs!.data![index].location
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 13, color: black),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                          FutureBuilder<TimeSheetModel>(
                              future: getUpcomingJobsList(),
                              builder: (context, snapshot) {
                                // if (!snapshot.hasData) {
                                //   return Center(
                                //       child: Container(
                                //           height: 60,
                                //           width: 60,
                                //           child: CircularProgressIndicator()));
                                // } else {
                                if (upcomingData.isEmpty) {
                                  return SizedBox(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'upcoming_tours'.tr+ '(${upcomingData.length})',
                                                style: CustomTheme
                                                    .textField_Headertext_Style,
                                              ),
                                              //btn to see all the active jobs
                                              InkWell(
                                                onTap: () {
                                                  // screenNavigator(context, JobsScreen());
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return UpcomingThimeSheet();
                                                  }));
                                                  // screenNavigator(context, TimeSheetScreen());
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: upcomingData.length ==
                                                          0
                                                      ? Container()
                                                      : Text('see_all'.tr,
                                                          style: CustomTheme
                                                              .seeAllBtnStyle),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 120,
                                            child: Image.asset(
                                              'assets/no_active_jobs.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            'No Inactive jobs',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                color: Colors.grey
                                                    .withOpacity(0.6)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'upcoming_tours'.tr+ '(${upcomingData.length})',
                                            style: CustomTheme
                                                .textField_Headertext_Style,
                                          ),
                                          //btn to see all the active jobs
                                          InkWell(
                                            onTap: () {
                                              // screenNavigator(context, JobsScreen());
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return UpcomingThimeSheet();
                                              }));
                                              // screenNavigator(context, TimeSheetScreen());
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: upcomingData.length == 0
                                                  ? Container()
                                                  : Text('see_all'.tr,
                                                      style: CustomTheme
                                                          .seeAllBtnStyle),
                                            ),
                                          )
                                        ],
                                      ),
                                      ListView.builder(
                                          itemCount: upcomingData.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                upcomingData.isNotEmpty
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                upcomingData[
                                                                        index]
                                                                    .shifts!
                                                                    .first
                                                                    .formattedDate
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.9),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                                GestureDetector(
                                                  onTap: () {
                                                    screenNavigator(
                                                        context,
                                                        PropertyDetailsScreen(
                                                          propertyId:
                                                              upcomingData[
                                                                      index]
                                                                  .id,
                                                          imageBaseUrl: snapshot
                                                              .data!
                                                              .propertyImageBaseUrl,
                                                          propertyImageBaseUrl:
                                                              snapshot.data!
                                                                  .propertyImageBaseUrl,
                                                          // activeData: snapshot.data?.activeData![index],
                                                        ));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            height: 204,
                                                            child: Center(
                                                                child: Image.network(
                                                                    snapshot.data!
                                                                            .propertyImageBaseUrl
                                                                            .toString() +
                                                                        upcomingData[index]
                                                                            .propertyAvatars!
                                                                            .first
                                                                            .propertyAvatar
                                                                            .toString(),
                                                                    frameBuilder:
                                                                        (context,
                                                                            child,
                                                                            frame,
                                                                            wasSynchronouslyLoaded) {
                                                              return child;
                                                            }, loadingBuilder:
                                                                        (context,
                                                                            child,
                                                                            loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              }
                                                            }))
                                                            // decoration: CustomTheme
                                                            //     .locationCardStyle(
                                                            //         snapshot.data!
                                                            //             .propertyImageBaseUrl
                                                            //             .toString(),
                                                            //         upcomingData[
                                                            //                 index]
                                                            //             .propertyAvatars!
                                                            //             .first
                                                            //             .propertyAvatar
                                                            //             .toString()),
                                                            ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              child: Text(
                                                                upcomingData[
                                                                        index]
                                                                    .propertyName
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                // locationData[index].title,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ),
                                                            Text(
                                                              upcomingData[
                                                                      index]
                                                                  .latestShiftTime
                                                                  .toString(),
                                                              // locationData[index].duty,
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color:
                                                                      primaryColor),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color:
                                                                  primaryColor,
                                                              size: 15,
                                                            ),
                                                            Text(
                                                              upcomingData[
                                                                      index]
                                                                  .propertyName
                                                                  .toString(),
                                                              // locationData[index].subtitle,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            // locationData[index].address,
                                                            upcomingData[index]
                                                                .location
                                                                // snapshot.data!.jobs!.data![index].location
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: black),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          })
                                    ],
                                  );
                                }
                                // }
                              })
                        ],
                      );
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
