import 'dart:convert';
import 'dart:async';

import 'package:carp_background_location/carp_background_location.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sgt/service/socket_home.dart';
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

class _CheckPointScreenState extends State<CheckPointScreen> {
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
      print("*****************************");
      return CheckPointPropertyShiftWise(
        // checkpoint: [],
        status: response.statusCode,
        message: response.body,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(checkpoint!.length);
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
            centerTitle: true,
            title: Text(
              "Checkpoints",
              textScaleFactor: 1.0,
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            ),
            actions: [
              InkWell(
                  onTap: () {
                    screenNavigator(context, ClockInScreen());
                  },
                  child: SvgPicture.asset('assets/clock.svg')),
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
                          child: Text(
                            "You are not assigned with this property",
                            // snapshot.data!.message.toString(),
                            style: TextStyle(color: Colors.red,fontSize: 16),
                          ),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              context
                                      .watch<ToggleSwitchCubit>()
                                      .state
                                      .isSwitched
                                  ? CheckPointMapScreen()
                                  : CheckPointWidget(
                                      property: property,
                                      propertyImageBaseUrl:snapshot.data!.propertyImageBaseUrl,
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
