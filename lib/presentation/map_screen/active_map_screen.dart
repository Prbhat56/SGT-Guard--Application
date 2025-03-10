import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/jobs_screen/model/active_list_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import '../../utils/const.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ActiveMapScreen extends StatefulWidget {
  const ActiveMapScreen({super.key});

  @override
  State<ActiveMapScreen> createState() => _ActiveMapScreenState();
}

List<ActiveResponseData> activeDatum = [];
String imgBaseUrl = '';

class _ActiveMapScreenState extends State<ActiveMapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = <Marker>[];

  Future getJobsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['activePropertyList']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 201) {
      final ReportListModel responseModel =
          reportListModelFromJson(response.body);
      activeDatum = responseModel.data ?? [];

      imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';

      for (var i = 0; i < activeDatum.length; i++) {
        markers.add(Marker(
          markerId: MarkerId(activeDatum[i].id.toString()),
          infoWindow: InfoWindow(title: activeDatum[i].propertyName),
          position: LatLng(
            double.parse(activeDatum[i].latitude.toString()),
            double.parse(activeDatum[i].longitude.toString()),
          ),
        ));
      }

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
        return ReportListModel(
          data: [], status: response.statusCode, propertyImageBaseUrl: '');
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: 'active_properties'.tr),
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
            return activeDatum.length == 0
                ? SizedBox(
                    child: Center(
                      child: Text(
                        'No Active Property Found',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Stack(
                      children: [
                        GoogleMap(
                          padding: EdgeInsets.only(bottom: 150, left: 15),
                          mapType: MapType.normal,
                          zoomControlsEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                double.parse(
                                    activeDatum.first.latitude.toString()),
                                double.parse(
                                    activeDatum.first.longitude.toString()),
                              ),
                              zoom: 14),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          markers: Set<Marker>.of(markers),
                          myLocationEnabled: true,
                        ),
                        Positioned(
                          bottom: 20,
                          child: SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: activeDatum.length,
                              itemBuilder: (context, index) {
                                var myData = activeDatum[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  margin: EdgeInsets.all(15),
                                  height: 130,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 90,
                                        width: 90,
                                        child: Image.network(
                                          fit: BoxFit.fill,
                                          '${imgBaseUrl}${myData.propertyAvatars!.first.propertyAvatar.toString()}',
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/sgt_logo.jpg',
                                              fit: BoxFit.fill,
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: Text(
                                                myData.propertyName.toString(),
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              'Check-in by ${myData.shifts!.first.clockIn.toString()}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Text(
                                                myData.location.toString(),
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          }
        },
      ),
    );
  }
}
