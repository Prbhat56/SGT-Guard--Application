import 'dart:convert';
import 'dart:async';

import 'package:carp_background_location/carp_background_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/service/socket_home.dart';
import 'package:sgt/theme/custom_theme.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websocket_universal/websocket_universal.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/presentation/clocked_in_out_screen/clock_in_screen.dart';
import 'package:sgt/presentation/widgets/should_pop_alert_dialog.dart';
import 'package:sgt/service/constant/constant.dart';
import '../../helper/navigator_function.dart';
import '../../utils/const.dart';
import '../settings_screen/cubit/toggle_switch/toggleswitch_cubit.dart';
import '../time_sheet_screen/check_point_map_screen.dart';
import 'widgets/check_points_widget.dart';
import 'package:http/http.dart' as http;

class CheckPointScreen extends StatefulWidget {
  CheckPointScreen({super.key});
  @override
  State<CheckPointScreen> createState() => _CheckPointScreenState();
}

Property? property = Property();
List<Checkpoint>? checkpoint = [];
Data? shiftDetails = Data();

class _CheckPointScreenState extends State<CheckPointScreen> {

   @override
  void initState() {
    super.initState();
    getJobsList();
  }

   Future<PropertyDetailsModel> getJobsList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? property_id = prefs.getString('propertyId');
      Map<String, String> myHeader = <String, String>{
        "Authorization": "Bearer ${prefs.getString('token')}",
      };
      String apiUrl = baseUrl + apiRoutes['dutyDetails']! + property_id.toString();
      final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

      if (response.statusCode == 201) {
        final PropertyDetailsModel responseModel = propertyDetailsModelFromJson(response.body);
        shiftDetails = responseModel.data;
        // print("-------------------->  ${shiftDetails}");
        return responseModel;
      } else {
        return PropertyDetailsModel(
          status: response.statusCode,
        );
      }
    } catch (e) {
      print('error caught: $e');
      return PropertyDetailsModel(
        status: 500,
      );
    }
  }


  Future<CheckPointPropertyShiftWise> getCheckpointsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? property_id = prefs.getString('propertyId');
    String? shift_id = prefs.getString('shiftId');
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    Map<String, String> myJsonBody = {
      'property_id': property_id.toString(),
      'shift_id': shift_id.toString()
    };
    String apiUrl = baseUrl + apiRoutes['checkpointListShiftWise']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    print("=============> ${response.body}");
    if (response.statusCode == 201) {
      final CheckPointPropertyShiftWise responseModel =
          checkPointPropertyShiftWiseFromJson(response.body);
      property = responseModel.property;
      checkpoint = responseModel.checkpoints;
      // var checks = json.decode(checkpoint.toString());
      // print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ===> ${checks}");
      return responseModel;
    } else {
      return CheckPointPropertyShiftWise(
        // checkpoint: [],
        status: response.statusCode,
        message: response.body,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
              ),
              onPressed: () {
                if (ModalRoute.of(context)!.settings.name != null) {
                  screenNavigator(context, ClockInScreen());
                } else {
                  screenNavigator(context, ShouldPopAlertDialog());
                }
                // String? currentPath;
                // navigatorKey.currentState?.popUntil((route) {
                //   currentPath = route.settings.name;
                //   return true;
                // });
                // Navigator.of(context).pop();
              },
            ),
            // centerTitle: true,
            title: Text(
              "Checkpoints",
              textScaleFactor: 1.0,
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            ),
            actions: [
              InkWell(
                  onTap: () {
                    // screenNavigator(context, ClockInScreen());
                  },
                  child: const Icon(
                    Icons.add,
                    color: CustomTheme.primaryColor,
                    size: 30,
                  )
                  // SvgPicture.asset('assets/clock.svg')
                  ),
              SizedBox(
                width: 12,
              ),
              InkWell(
                  onTap: () {
                    screenNavigator(context, ClockInScreen());
                  },
                  child: SvgPicture.asset('assets/clock.svg')
                  ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<ToggleSwitchCubit>(context)
                        .changingToggleSwitch();
                  },
                  icon: Icon(
                    Icons.map,
                    color: primaryColor,
                  ))
            ],
          ),
          // CustomAppBarWidget(
          //   appbarTitle: 'Checkpoints',
          //   widgets: [
          //     InkWell(
          //         onTap: () {
          //           screenNavigator(context, ClockInScreen());
          //         },
          //         child: SvgPicture.asset('assets/clock.svg')),
          //     IconButton(
          //         onPressed: () {
          //           BlocProvider.of<ToggleSwitchCubit>(context)
          //               .changingToggleSwitch();
          //         },
          //         icon: Icon(
          //           Icons.map,
          //           color: primaryColor,
          //         ))
          //   ],
          // ),
          backgroundColor: white,
          body:
              // checkpoint!.length == 0
              //   ? SizedBox(
              //       child: Center(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               'No CheckPoints Found',
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(height: 20),
              //             CustomButtonWidget(
              //                 buttonTitle: 'Clock Out',
              //                 onBtnPress: () {
              //                   screenNavigator(
              //                       context, CheckPointOutScanningScreen());
              //                 })
              //           ],
              //         ),
              //       ),
              //     )
              //   :
              FutureBuilder(
            future: getCheckpointsList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Container(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator()));
              } else {
                if (snapshot.data!.status != 201) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Something Went Wrong! Please Try Again to ClockIn",
                          // snapshot.data!.message.toString(),
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(
                          height: 12.dg,
                        ),
                        Container(
                          width: 180,
                          child: CustomButtonWidget(
                              buttonTitle: 'Home',
                              onBtnPress: () {
                                screenNavigator(context, Home());
                              }),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        context.watch<ToggleSwitchCubit>().state.isSwitched
                            ? CheckPointMapScreen()
                            : CheckPointWidget(
                                property: property,
                                propertyImageBaseUrl:
                                    snapshot.data!.propertyImageBaseUrl,
                                checkpoint: checkpoint),
                      ],
                    ),
                  );
                }
              }
            },
          )),
    );
  }
}
