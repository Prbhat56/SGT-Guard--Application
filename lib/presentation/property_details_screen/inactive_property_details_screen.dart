import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';
import '../map_screen/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InActivePropertyDetailsScreen extends StatefulWidget {
  int? propertyId;

  InActivePropertyDetailsScreen({
    super.key,
    this.propertyId,
  });

  @override
  State<InActivePropertyDetailsScreen> createState() =>
      _InActivePropertyDetailsScreenState();
}

class _InActivePropertyDetailsScreenState
    extends State<InActivePropertyDetailsScreen> {
  Future<PropertyDetailsModel> getJobsList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Map<String, String> myHeader = <String, String>{
        "Authorization": "Bearer ${prefs.getString('token')}",
      };
      String apiUrl =
          baseUrl + apiRoutes['dutyDetails']! + widget.propertyId.toString();
      final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

      if (response.statusCode == 201) {
        final PropertyDetailsModel responseModel =
            propertyDetailsModelFromJson(response.body);
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

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: CustomAppBarWidget(appbarTitle: 'Inactive Property'),
          body: FutureBuilder(
            future: getJobsList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomCircularImage.getCircularImage(
                                snapshot.data!.propertyImageBaseUrl.toString(),
                                '${snapshot.data!.data!.propertyAvatars!.isEmpty ? null : snapshot.data!.data!.propertyAvatars!.first.propertyAvatar}',
                                false,
                                42,
                                0,
                                0),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.data!.propertyName
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data!.data!.location.toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Last Shift: ',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.red),
                                        ),
                                        Text(
                                          '${snapshot.data!.data!.shifts!.isEmpty ? null : snapshot.data!.data!.shifts!.last.clockIn.toString()} ~ ${snapshot.data!.data!.shifts!.isEmpty ? null : snapshot.data!.data!.shifts!.last.clockOut.toString()}',
                                          style: TextStyle(
                                              fontSize: 12, color: black),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: primaryColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Job Details',
                        style: CustomTheme.textField_Headertext_Style,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Gaurd Name: ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: black),
                          ),
                          Text(
                            ' ${snapshot.data!.data!.jobDetails == null ? null : snapshot.data!.data!.jobDetails!.firstName.toString()} ${snapshot.data!.data!.jobDetails == null ? null : snapshot.data!.data!.jobDetails!.lastName.toString()}',
                            style: TextStyle(
                              fontSize: 15,
                              color: primaryColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Position: ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: black),
                          ),
                          Text(
                            //' ${snapshot.data!.data!.jobDetails!.guardPosition.toString()}',
                            ' ${snapshot.data!.data!.jobDetails == null ? null : snapshot.data!.data!.jobDetails!.guardPosition.toString()}',
                            style: TextStyle(
                              fontSize: 15,
                              color: primaryColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Location',
                        style: CustomTheme.textField_Headertext_Style,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data!.data!.location.toString(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: CustomTheme.mapCardShadow),
                              height: 231,
                              width: 343.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            double.parse(snapshot
                                                    .data!.data!.latitude
                                                    .toString())
                                                .toDouble(),
                                            double.parse(snapshot
                                                    .data!.data!.longitude
                                                    .toString())
                                                .toDouble()),
                                        zoom: 14)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MapScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.near_me,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }
}
