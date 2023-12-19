import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/presentation/jobs_screen/model/active_list_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
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

  Iterable markers = [];

  Future<ReportListModel> getJobsList() async {
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
      print('Active: $activeDatum');

      imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';

      markers = Iterable.generate(activeDatum.length, (index) {
        return Marker(
            markerId: MarkerId(activeDatum[index].id.toString()),
            position: LatLng(
              double.parse(activeDatum[index].latitude.toString()),
              double.parse(activeDatum[index].longitude.toString()),
            ),
            infoWindow: InfoWindow(title: activeDatum[index].propertyName));
      });

      return responseModel;
    } else {
      return ReportListModel(
          data: [], status: response.statusCode, propertyImageBaseUrl: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: 'Active Properties'),
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
              padding: const EdgeInsets.only(bottom: 30),
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(22.572645, 88.363892), zoom: 14),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set.from(markers),
                  ),
                  Positioned(
                    bottom: 20,
                    child: SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          var myData = activeDatum[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 90,
                                  width: 90,
                                  child: Image.network(
                                    fit: BoxFit.contain,
                                    '${imgBaseUrl}/${myData.propertyAvatars!.first.propertyAvatar.toString()}',
                                    errorBuilder: (context, error, stackTrace) {
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
                                      Text(
                                        myData.propertyName.toString(),
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Check-in by ${myData.shifts!.first.clockIn.toString()}',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
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
                                              overflow: TextOverflow.ellipsis),
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
