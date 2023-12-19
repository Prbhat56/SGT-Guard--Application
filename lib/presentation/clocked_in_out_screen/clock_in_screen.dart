import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/clocked_in_out_screen/modal/clockin_modal.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import 'clock_out_error_screen.dart';
import '../shift_details_screen/widgets/time_details_widget.dart';
import '../shift_details_screen/widgets/time_stamp_widget.dart';
import 'package:http/http.dart' as http;


class ClockInScreen extends StatefulWidget {
String? qrData;
  ClockInScreen({super.key, this.qrData});

  @override
  State<ClockInScreen> createState() => _ClockInScreenState();
}

Future<ClockInModal> getCheckpointsTaskList(shift_id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  Map<String, dynamic> myJsonBody = {'shift_id': shift_id.toString()};
  String apiUrl = baseUrl + apiRoutes['clockIn']!;
  final response =
      await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
  print(response.body.toString());
  var data = jsonDecode(response.body.toString());
  print(data);
  if (response.statusCode == 200) {
    final ClockInModal responseModel =
        clockInModalFromJson(response.body);
    return responseModel;
  } else {
    // if(response.statusCode == 400)
    // {
    //   print("response StatusCode ======> ${response.statusCode}");
    //   print("response${data?.message}");
    //   var common_service = CommonService();
    //   common_service.openSnackBar('you have already clocked In',context);
    // }
   return ClockInModal();
  }
}

final imageUrl =
    'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

class _ClockInScreenState extends State<ClockInScreen> {
  @override
  Widget build(BuildContext context) {
    print("widget.qrData =====> ${widget.qrData}");
    String? jsonString = widget.qrData;
    Map<String, dynamic> jsonData = jsonDecode(jsonString!);
    int shiftId = jsonData['shift_details']['shift_id'];
    print('Shift ID: $shiftId');
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Clocked In'),
        body: FutureBuilder(
                future: getCheckpointsTaskList(shiftId),
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
              'You are currently clocked in\n and ready to go!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: primaryColor),
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, seconderyColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: 300.w,
                  decoration: CustomTheme.clockInCardStyle,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(height: 16),
                    CustomCircularImage.getCircularImage(
                        snapshot.data!.imageBaseUrl.toString(),snapshot.data!.jobDetails!.avatar.toString(), false, 30, 0, 0),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      // 'Matheus Paolo',
                      snapshot.data!.jobDetails!.firstName.toString()+''+snapshot.data!.jobDetails!.lastName.toString(),
                        style: CustomTheme.blackTextStyle(17)),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      'Greylock Security',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Property',
                      style: CustomTheme.blueTextStyle(15, FontWeight.w400),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      // 'Rivi Properties',
                        snapshot.data!.property!.propertyName.toString(),
                        style: CustomTheme.blackTextStyle(15)),
                    const SizedBox(height: 6),
                    const Text(
                      'Guard Post Duties',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Center(child: TimeDetailsWidget(isClockOutScreen: false,currentShiftData: snapshot.data!.currentShift)),
                    const SizedBox(height: 6),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(color: primaryColor),
                    ),
                    const SizedBox(height: 20),
                    TimeStampWidget(),
                    const SizedBox(height: 30),
                    CupertinoButton(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(13),
                        child: Text(
                          'Checkpoints',
                          style: TextStyle(color: white, fontSize: 17),
                        ),
                        onPressed: () {
                          screenNavigator(context, CheckPointScreen(
                            propertyId:snapshot.data!.property!.id
                          ));
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 57,
            ),
            // CustomButtonWidget(
            //     buttonTitle: 'Clock Out',
            //     onBtnPress: () {
            //       screenNavigator(context, ClockOutErrorScreen());
            //     }),
          ]),
        );
                  }
                }
        )
      ),
    );
  }
}
