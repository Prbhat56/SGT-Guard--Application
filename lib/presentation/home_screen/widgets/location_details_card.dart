import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/home_screen/model/GuardHome.dart';
import 'package:sgt/presentation/jobs_screen/jobs_screen.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/widgets/job_details_widget.dart';
import 'package:sgt/presentation/property_details_screen/property_details_screen.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import 'location_details_model.dart';
import 'package:http/http.dart' as http;

class LocationDetailsCard extends StatefulWidget {
  const LocationDetailsCard({super.key});

  @override
  State<LocationDetailsCard> createState() => _LocationDetailsCardState();
}

class _LocationDetailsCardState extends State<LocationDetailsCard> {
  Future getJobsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['dutyList']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    // print(response.body.toString());
    // var data = jsonDecode(response.body.toString());
    // print(data);
    if (response.statusCode == 201) {
      final DutyListModel responseModel = dutyModelFromJson(response.body);
      activeDatum = responseModel.activeData ?? [];
      // print('Active: $activeDatum');
      inActiveDatum = responseModel.inactiveData ?? [];
      // print('InActive: $inActiveDatum');
      imgBaseUrl = responseModel.imageBaseUrl ?? '';
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
        return DutyListModel(
          activeData: [],
          inactiveData: [],
          status: response.statusCode,
          imageBaseUrl: '');
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: FutureBuilder(
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
                  ListView.builder(
                      itemCount: snapshot.data!.activeData!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            screenNavigator(
                                context,
                                PropertyDetailsScreen(
                                  propertyId:
                                      snapshot.data!.activeData![index].id,
                                  imageBaseUrl: snapshot.data!.imageBaseUrl,
                                  propertyImageBaseUrl:
                                      snapshot.data!.propertyImageBaseUrl,
                                  // activeData: snapshot.data?.activeData![index],
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 204,
                                  decoration: CustomTheme.locationCardStyle(
                                      snapshot.data!.propertyImageBaseUrl
                                          .toString(),
                                      snapshot.data!.activeData![index]
                                          .propertyAvatars!.first.propertyAvatar
                                          .toString()),
                                  // snapshot.data!.jobs!.data![index].propertyAvatars![0].propertyAvatar.toString()),
                                  // (locationData[index].imageUrl),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // snapshot.data!.jobs!.data![index].propertyName.toString(),
                                      snapshot.data!.activeData![index].propertyName
                                          .toString(),
                                      // locationData[index].title,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      locationData[index].duty,
                                      style: TextStyle(
                                          fontSize: 17, color: primaryColor),
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
                                          fontSize: 13, color: Colors.grey),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    // locationData[index].address,
                                    snapshot.data!.activeData![index].location
                                        // snapshot.data!.jobs!.data![index].location
                                        .toString(),
                                    style:
                                        TextStyle(fontSize: 13, color: black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            }
          }),
    );
  }
}
