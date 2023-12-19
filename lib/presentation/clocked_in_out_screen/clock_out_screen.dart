import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/clocked_in_out_screen/modal/clock_out_modal.dart';
import 'package:sgt/presentation/clocked_in_out_screen/widget/clock_out_total_time_widget.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../home.dart';
import '../shift_details_screen/widgets/time_details_widget.dart';
import 'widget/check_point_count_widget.dart';
import 'package:http/http.dart' as http;

class ClockOutScreen extends StatefulWidget {
  String? clockOutQrData;
  ClockOutScreen({super.key, this.clockOutQrData});

  @override
  State<ClockOutScreen> createState() => _ClockOutScreenState();
}

Future<ClockOutModal> getClockOutData(shift_id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  Map<String, dynamic> myJsonBody = {'shift_id': shift_id.toString()};
  String apiUrl = baseUrl + apiRoutes['clockOut']!;
  final response =
      await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
  print(response.body.toString());
  var data = jsonDecode(response.body.toString());
  print(data);
  if (response.statusCode == 200) {
    final ClockOutModal responseModel = clockOutModalFromJson(response.body);
    return responseModel;
  } else {
    return ClockOutModal(
      status: response.statusCode,
    );
  }
}

final imageUrl =
    'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

class _ClockOutScreenState extends State<ClockOutScreen> {
  @override
  Widget build(BuildContext context) {
    print("widget.clockOutQrData =====> ${widget}");
    String? jsonString = widget.clockOutQrData;
    Map<String, dynamic> jsonData = jsonDecode(jsonString!);
    int shiftId = jsonData['shift_details']['shift_id'];
    print('Shift ID: $shiftId');
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: CustomAppBarWidget(appbarTitle: 'Clocked Out'),
          body: FutureBuilder(
              future: getClockOutData(shiftId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator()));
                } else {
                  return Center(
                    child: Column(children: [
                      const SizedBox(height: 25),
                      SvgPicture.asset('assets/green_tick.svg'),
                      const SizedBox(height: 10),
                      Text(
                        'You are currently clocked\n out from shift!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: primaryColor),
                      ),
                      const SizedBox(height: 40),
                      //not getting api data of details on clock out.
                      // Container(
                      //   decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //       colors: [primaryColor, seconderyColor],
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //     ),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(2),
                      //     child: Container(
                      //       width: 300.w,
                      //       decoration: CustomTheme.clockInCardStyle,
                      //       child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             const SizedBox(height: 16),
                      //             CustomCircularImage.getCircularImage(
                      //                 '', imageUrl, false, 30, 0, 0),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Text('Matheus Paolo',
                      //                 style: CustomTheme.blackTextStyle(17)),
                      //             const SizedBox(
                      //               height: 2,
                      //             ),
                      //             const Text(
                      //               'Greylock Security',
                      //               style: TextStyle(
                      //                   fontSize: 13, color: Colors.grey),
                      //             ),
                      //             const SizedBox(height: 28),
                      //             Text(
                      //               'Property',
                      //               style: CustomTheme.blueTextStyle(
                      //                   15, FontWeight.w400),
                      //             ),
                      //             const SizedBox(height: 6),
                      //             Text('Rivi Properties',
                      //                 style: CustomTheme.blackTextStyle(15)),
                      //             const SizedBox(height: 6),
                      //             const Text(
                      //               'Guard Post Duties',
                      //               style: TextStyle(
                      //                   fontSize: 15, color: Colors.grey),
                      //             ),
                      //             const SizedBox(height: 15),
                      //             Center(
                      //                 child: TimeDetailsWidget(
                      //                     isClockOutScreen: true)),
                      //             const SizedBox(height: 6),
                      //             Center(
                      //                 child: CheckPointCountWidget(
                      //               completedCheckPoint: '13',
                      //               remainningCheckPoint: '0',
                      //             )),
                      //             const SizedBox(height: 15),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 30.0),
                      //               child: Divider(color: primaryColor),
                      //             ),
                      //             const SizedBox(height: 20),
                      //             Center(child: TotalTimeWidget()),
                      //             const SizedBox(height: 20),
                      //           ]),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 105,
                      ),
                      CustomButtonWidget(
                          buttonTitle: 'Home',
                          onBtnPress: () {
                            screenReplaceNavigator(context, Home());
                          }),
                    ]),
                  );
                }
              })),
    );
  }
}
