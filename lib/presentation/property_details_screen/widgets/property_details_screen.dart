import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/helper/navigator_function.dart';
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
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PropertyDetailsScreen extends StatefulWidget {
  InactiveDatum? activeData = InactiveDatum();
  String? imageBaseUrl;
  String? propertyImageBaseUrl;
  int? propertyId;
  PropertyDetailsScreen(
      {super.key,
      this.activeData,
      this.imageBaseUrl,
      this.propertyId,
      this.propertyImageBaseUrl});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

Data? detailsData = Data();

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  Future<PropertyDetailsModel> getJobsList(property_id) async {
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
      detailsData = responseModel.data;
      return responseModel;
    } else {
      return PropertyDetailsModel(
        status: response.statusCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Property Detail'),
        body: FutureBuilder(
                future: getJobsList(widget.propertyId),
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
                          imageBaseUrl: snapshot.data!.propertyImageBaseUrl,
                          detailsData: detailsData,
                          checkPoint:widget.activeData!.checkPoints!.length.toString(),
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
                                          context, ScanningScreen(propertyId:snapshot.data!.data!.id));
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
                                            propertyId:widget.propertyId,
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
                                          context,
                                          WorkReportScreen(
                                            propertyId: snapshot.data!.data!.id
                                                .toString(),
                                            propertyName: snapshot
                                                .data!.data!.propertyName,
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
                              detailsData!.shifts!.length != 0
                                  ? ShiftCards(shifts: detailsData!.shifts, imageBaseUrl:snapshot.data!.imageBaseUrl)
                                  : Text(
                                      'No Upcoming Shift Available',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                    ),
                              SizedBox(height: 20),
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
                                                  15)),
                                          Text(
                                            '${detailsData!.jobDetails == null ? '' : detailsData!.jobDetails!.firstName.toString()} ${detailsData!.jobDetails == null ? '' : detailsData!.jobDetails!.lastName.toString()}',
                                            style: CustomTheme.blueTextStyle(
                                                15, FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Position: ',
                                              style: CustomTheme.blackTextStyle(
                                                  15)),
                                          Text(
                                            ' ${detailsData!.jobDetails == null ? '' : detailsData!.jobDetails!.guardPosition.toString()}',
                                            style: CustomTheme.blueTextStyle(
                                                15, FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Shift Time: ',
                                              style: CustomTheme.blackTextStyle(
                                                  15)),
                                          Text(
                                            '${detailsData!.jobDetails == null ? "" : detailsData!.jobDetails!.shiftTime.toString()}',
                                            style: CustomTheme.blueTextStyle(
                                                15, FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                    ],
                                  ), //widgets to show job details
                                  TextFieldHeaderWidget(title: 'Description'),
                                  const SizedBox(height: 10),
                                  PropertyDescriptionWidget(
                                    propertyImageBaseUrl:snapshot.data!.propertyImageBaseUrl,
                                    propDesc: detailsData!.propertyDescription,
                                    propvatars: detailsData!.propertyAvatars,
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
                                        double.parse(snapshot
                                                .data!.data!.latitude
                                                .toString())
                                            .toDouble(),
                                        double.parse(snapshot
                                                .data!.data!.longitude
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
                                                context, ScanningScreen(propertyId:snapshot.data!.data!.id));
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
                })
                ),
      );
  }
}
