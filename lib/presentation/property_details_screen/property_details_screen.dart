import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/check_points_list.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/presentation/property_details_screen/widgets/shift_cards.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/work_report_screen/work_report_screen.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/timer_on/timer_on_cubit.dart';
import '../qr_screen/scanning_screen.dart';
import '../widgets/custom_text_widget.dart';
import 'widgets/job_details_widget.dart';
import 'widgets/map_card_widget.dart';
import 'widgets/property_description_widget.dart';
import 'widgets/property_details_widget.dart';
import 'package:http/http.dart' as http;

class PropertyDetailsScreen extends StatefulWidget {
  InactiveDatum? activeData = InactiveDatum();
  String? imageBaseUrl;
  int? propertyId;
  PropertyDetailsScreen(
      {super.key, this.activeData, this.imageBaseUrl, this.propertyId});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

Future<PropertyDetailsModel> getJobsList(property_id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  String apiUrl = baseUrl + apiRoutes['dutyDetails']! + property_id.toString();
  final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
  print(response.body.toString());
  var data = jsonDecode(response.body.toString());
  print(data);
  if (response.statusCode == 201) {
    final PropertyDetailsModel responseModel =
        propertyDetailsModelFromJson(response.body);
    return responseModel;
  } else {
    return PropertyDetailsModel(
      status: response.statusCode,
    );
  }
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  LatLng currentlocation = const LatLng(22.572645, 88.363892);
  @override
  Widget build(BuildContext context) {
    print("property id ===> ${widget.propertyId}");
    print("activeData  ===> ${widget.activeData}");

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Property Detail'),
        body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: FutureBuilder(
                future: getJobsList(widget.propertyId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Container(
                            height: 60,
                            width: 60,
                            child: CircularProgressIndicator()));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PropertyDetailsWidget(
                          imageBaseUrl: snapshot.data!.propertyImageBaseUrl,
                          activeData: widget.activeData,
                          propertyId: widget.propertyId,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 2.0,
                          child: DecoratedBox(
                            decoration:
                                BoxDecoration(color: Colors.grey.withAlpha(50)),
                          ),
                        ),
                        const SizedBox(height: 30),
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
                                          context, ScanningScreen());
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 32,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: SvgPicture.asset(
                                        'assets/qr1.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Scan QR',
                                    style: TextStyle(
                                        fontSize: 13,
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
                                            propertyId: snapshot.data!.data!.id,
                                            checkPoint: widget.activeData!.checkPoints,
                                            imageBaseUrl: widget.imageBaseUrl,
                                          ));
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 32,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                    height: 5,
                                  ),
                                  Text(
                                    'Checkpoints',
                                    style: TextStyle(
                                        fontSize: 13,
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
                                          context, WorkReportScreen());
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 32,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: SvgPicture.asset(
                                        'assets/plus.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Report',
                                    style: TextStyle(
                                        fontSize: 13,
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
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 2.0,
                          child: DecoratedBox(
                            decoration:
                                BoxDecoration(color: Colors.grey.withAlpha(50)),
                          ),
                        ), //widget to create top property detials card
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldHeaderWidget(title: 'Upcoming Shifts'),
                              const SizedBox(height: 10),
                              // ShiftCards(shifts: widget.activeData!.shifts), //shift cards widget
                              ShiftCards(
                                shifts: snapshot.data!.data!.shifts
                                ), //shift cards widget
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldHeaderWidget(title: 'Job Details'),
                                  const SizedBox(height: 10),
                                  JobDetailsWidget(
                                    jobDetails:snapshot.data!.data?.jobDetails
                                  ), //widgets to show job details
                                  //const SizedBox(height: 25),
                                  TextFieldHeaderWidget(title: 'Description'),
                                  const SizedBox(height: 10),
                                  PropertyDescriptionWidget(
                                    imageBaseUrl: snapshot.data!.propertyImageBaseUrl,
                                    activeData: widget.activeData,
                                  ), //widget to show property details
                                  const SizedBox(height: 25),
                                  TextFieldHeaderWidget(title: 'Location'),
                                  const SizedBox(height: 10),
                                  Text(
                                    widget.activeData!.location.toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 20),
                                  MapCardWidget(
                                    currentlocation: LatLng(
                                        double.parse(widget.activeData!.latitude
                                                .toString())
                                            .toDouble(),
                                        double.parse(widget
                                                .activeData!.longitude
                                                .toString())
                                            .toDouble()),
                                  ), //showing map card
                                  const SizedBox(height: 30),
                                  Center(
                                      child: CustomButtonWidget(
                                          buttonTitle: 'Start Shift',
                                          onBtnPress: () {
                                            //logic to start the timer if it's not start
                                            context
                                                    .read<TimerOnCubit>()
                                                    .state
                                                    .istimerOn
                                                ? null
                                                : context
                                                    .read<TimerOnCubit>()
                                                    .turnOnTimer();
                                            screenNavigator(
                                                context, ScanningScreen());
                                          })),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                })),
      ),
    );
  }
}
