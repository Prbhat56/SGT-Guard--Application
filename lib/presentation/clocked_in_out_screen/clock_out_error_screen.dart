import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../authentication_screen/firebase_auth.dart';
import '../cubit/timer_on/timer_on_cubit.dart';
import 'clock_out_screen.dart';
import 'widget/check_point_count_widget.dart';
import 'widget/clock_out_total_time_widget.dart';
import 'package:http/http.dart' as http;

class ClockOutErrorScreen extends StatefulWidget {
  String? shiftId;
  ClockOutErrorScreen({super.key, this.shiftId});

  @override
  State<ClockOutErrorScreen> createState() => _ClockOutErrorScreenState();
}

Data? detailsData = Data();

class _ClockOutErrorScreenState extends State<ClockOutErrorScreen> {
  Future getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? property_id = prefs.getString('propertyId');
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
          backgroundColor: white,
          body: FutureBuilder(
            future: getDetails(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Container(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator()));
              } else {
                return SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 120, left: 30, right: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 210, 29, 16),
                            size: 45,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'all_checkpoints_not_completed_text'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: primaryColor),
                          ),
                          SizedBox(
                            height: 80.h,
                          ),
                          // Center(child: TotalTimeWidget()),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: CheckPointCountWidget(
                            completedCheckPoint: detailsData!
                                .jobDetails!.completedCheckpoint
                                .toString(),
                            remainningCheckPoint: detailsData!
                                .jobDetails!.remainingCheckpoint
                                .toString(),
                          )),
                          SizedBox(
                            height: 80.h,
                          ),
                          Text(
                            'You want to clock out without completing your duty?',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomButtonWidget(
                              buttonTitle: 'back'.tr,
                              btnColor: seconderyColor,
                              onBtnPress: () {
                                Navigator.pop(context);
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButtonWidget(
                              buttonTitle: 'clock_out_button'.tr,
                              onBtnPress: () {
                                // context.read<TimerOnCubit>().state.istimerOn
                                //     ? context.read<TimerOnCubit>().turnOffTimer()
                                //     : null ;
                                screenNavigator(context,
                                    ClockOutScreen(shiftId: widget.shiftId));
                              }),
                        ]),
                  ),
                );
              }
            },
          )),
    );
  }
}
