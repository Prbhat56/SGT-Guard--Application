import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import 'package:http/http.dart' as http;

class CheckPointMapScreen extends StatefulWidget {
  CheckPointMapScreen({super.key});

  @override
  State<CheckPointMapScreen> createState() => _CheckPointMapScreenState();
}

String imgBaseUrl = '';
List<Checkpoint> checkpoint = [];
var checkpointListDataFetched;
class _CheckPointMapScreenState extends State<CheckPointMapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = <Marker>[];

   @override
  void initState() {
    super.initState();
  checkpointListDataFetched = getCheckpointsList();
  }

  Future getCheckpointsList() async {
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
    // print("================> ${shift_id}");
    // print("********************==> ${property_id}");
    String apiUrl = baseUrl + apiRoutes['checkpointListShiftWise']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    if (response.statusCode == 201) {
      final CheckPointPropertyShiftWise responseModel =
          checkPointPropertyShiftWiseFromJson(response.body);
      checkpoint = responseModel.checkpoints ?? [];

      imgBaseUrl = responseModel.imageBaseUrl ?? '';

      for (var i = 0; i < checkpoint.length; i++) {
        markers.add(Marker(
          markerId: MarkerId(checkpoint[i].id.toString()),
          infoWindow: InfoWindow(title: checkpoint[i].checkpointName),
          position: LatLng(
            double.parse(checkpoint[i].latitude.toString()),
            double.parse(checkpoint[i].longitude.toString()),
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
        return CheckPointPropertyShiftWise(
          checkpoints: [],
          status: response.statusCode,
          propertyImageBaseUrl: '');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 4.5 / 5,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
            body: FutureBuilder(
                future: checkpointListDataFetched,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        GoogleMap(
                          padding: EdgeInsets.only(bottom: 150, left: 15),
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>[
                            new Factory<OneSequenceGestureRecognizer>(
                              () => new EagerGestureRecognizer(),
                            ),
                          ].toSet(),
                          mapType: MapType.normal,
                          zoomControlsEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                double.parse(
                                    checkpoint.first.latitude.toString()),
                                double.parse(
                                    checkpoint.first.longitude.toString()),
                              ),
                              zoom: 14),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          markers: Set<Marker>.of(markers),
                        ),
                        Positioned(
                          bottom: 20,
                          child: SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: checkpoint.length,
                              itemBuilder: (context, index) {
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
                                  child: 
                                  GestureDetector(
                                    onTap: () {
                                      CameraPosition(target: LatLng(
                                double.parse(checkpoint[index].latitude.toString()),
                                double.parse(checkpoint[index].longitude.toString()),
                              ),zoom: 14);
                                    },
                                    child: 
                                    Row(
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
                                          child: checkpoint[index]
                                                      .checkPointAvatar!
                                                      .length !=
                                                  0
                                              ? Image.network(
                                                  fit: BoxFit.fill,
                                                  '${imgBaseUrl}/${checkpoint[index].checkPointAvatar!.first.checkpointAvatars.toString()}',
                                                )
                                              : Image.asset(
                                                  'assets/sgt_logo.jpg'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: 130,
                                                child: Text(
                                                  checkpoint[index]
                                                      .checkpointName
                                                      .toString(),
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      overflow:
                                                          TextOverflow.ellipsis),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // Text(
                                              //   'Check-in by ${myData.shifts!.first.clockIn.toString()}',
                                              //   style: TextStyle(
                                              //       fontSize: 15,
                                              //       color: Colors.grey),
                                              // ),
                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  checkpoint[index]
                                                      .propertyName
                                                      .toString(),
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
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Positioned(
                        //   bottom: 50,
                        //   child: SizedBox(
                        //     height: 150,
                        //     width: MediaQuery.of(context).size.width,
                        //     child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: checkpoint.length,
                        //       itemBuilder: (context, index) {
                        //         return Container(
                        //           padding: const EdgeInsets.symmetric(horizontal: 10),
                        //           margin: EdgeInsets.all(15),
                        //           height: 130,
                        //           width: 300,
                        //           decoration: BoxDecoration(
                        //             color: white,
                        //             borderRadius: BorderRadius.circular(15),
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               Container(
                        //                 clipBehavior: Clip.antiAlias,
                        //                 decoration: BoxDecoration(
                        //                   color: grey,
                        //                   borderRadius: BorderRadius.circular(10),
                        //                 ),
                        //                 height: 90,
                        //                 width: 90,
                        //                 child: Image.network(
                        //                   fit: BoxFit.fill,
                        //                   '${imgBaseUrl}/${checkpoint[index].checkPointAvatar!.first.checkpointAvatars.toString()}',
                        //                   errorBuilder: (context, error, stackTrace) {
                        //                     return Image.asset(
                        //                       'assets/sgt_logo.jpg',
                        //                       fit: BoxFit.fill,
                        //                     );
                        //                   },
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding: const EdgeInsets.only(left: 15.0, top: 10),
                        //                 child: Column(
                        //                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                   children: [
                        //                     Text(
                        //                       checkpoint[index].checkpointName
                        //                           .toString(),
                        //                       maxLines: 1,
                        //                       style: TextStyle(fontSize: 17),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 5,
                        //                     ),
                        //                     // Text(
                        //                     //   widget.checkpoint![index].status == "Visited"
                        //                     //       ? 'Check-in by' +
                        //                     //           '' +
                        //                     //           DateFormat('MMM d, yyyy').format(
                        //                     //               DateTime.parse(widget
                        //                     //                   .checkpoint![index].visitAt
                        //                     //                   .toString()))
                        //                     //       : widget.checkpoint![index].status
                        //                     //           .toString(),
                        //                     //   style:
                        //                     //       TextStyle(fontSize: 15, color: Colors.grey),
                        //                     // ),
                        //                     SizedBox(
                        //                       height: 5,
                        //                     ),
                        //                     SizedBox(
                        //                       width: 120,
                        //                       child: Text(
                        //                         checkpoint[index].propertyName
                        //                             .toString(),
                        //                         maxLines: 2,
                        //                         style: TextStyle(
                        //                             fontSize: 15,
                        //                             color: Colors.grey,
                        //                             overflow: TextOverflow.ellipsis),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         );

                        //         // Container(
                        //         //   padding: const EdgeInsets.symmetric(
                        //         //       vertical: 10, horizontal: 10),
                        //         //   margin: EdgeInsets.all(15),
                        //         //   height: 120,
                        //         //   width: 300,
                        //         //   decoration: BoxDecoration(
                        //         //     color: white,
                        //         //     borderRadius: BorderRadius.circular(15),
                        //         //   ),
                        //         //   child: Row(
                        //         //     children: [
                        //         //       Container(
                        //         //         decoration: BoxDecoration(
                        //         //           color: grey,
                        //         //           borderRadius: BorderRadius.circular(10),
                        //         //         ),
                        //         //         height: 90,
                        //         //         width: 90,
                        //         //         child: Image.network(
                        //         //           fit: BoxFit.contain,
                        //         //           widget.imageBaseUrl.toString()+'/'+widget.checkpoint![index].checkPointAvatar!.first.checkpointAvatars.toString(),
                        //         //           // checkpointData[index].imageUrl,
                        //         //         ),
                        //         //       ),
                        //         //       Padding(
                        //         //         padding: const EdgeInsets.only(left: 15.0, top: 10),
                        //         //         child: Column(
                        //         //           crossAxisAlignment: CrossAxisAlignment.start,
                        //         //           children: [
                        //         //             Text(
                        //         //               widget.checkpoint![index].checkpointName.toString(),
                        //         //               style: TextStyle(fontSize: 17),
                        //         //             ),
                        //         //             SizedBox(
                        //         //               height: 5,
                        //         //             ),
                        //         //             Text(
                        //         //               widget.checkpoint![index].status=="Visited"
                        //         //                   ? 'Check-in by'+''+DateFormat('MMM d, yyyy').format(DateTime.parse(widget.checkpoint![index].visitAt.toString()))
                        //         //                   : widget.checkpoint![index].status.toString(),
                        //         //               style:
                        //         //                   TextStyle(fontSize: 15, color: Colors.grey),
                        //         //             ),
                        //         //             SizedBox(
                        //         //               height: 5,
                        //         //             ),
                        //         //             SizedBox(
                        //         //               width: 120,
                        //         //               child: Text(
                        //         //                 widget.checkpoint![index].propertyName.toString(), //checkPointAddress Missing in Api Response
                        //         //                 style: TextStyle(
                        //         //                     fontSize: 15, color: Colors.grey),
                        //         //               ),
                        //         //             ),
                        //         //           ],
                        //         //         ),
                        //         //       )
                        //         //     ],
                        //         //   ),
                        //         // );
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  }
                })));
  }
}
