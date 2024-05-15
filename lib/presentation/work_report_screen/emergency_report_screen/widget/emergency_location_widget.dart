import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen/emergency_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/widget/edit_location.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/allWorkReport/static_emergency_report.dart';
import '../../../../theme/custom_theme.dart';

class EmergencyLocationWidget extends StatefulWidget {
  final ValueChanged<LatLng> onStatusChanged;
  EmergencyLocationWidget({super.key, required this.onStatusChanged});

  @override
  State<EmergencyLocationWidget> createState() =>
      _EmergencyLocationWidgetState();
}

class _EmergencyLocationWidgetState extends State<EmergencyLocationWidget> {
  LatLng? _currentPosition;
  LatLng? pinnedLocation;
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;

  Future<LatLng?> locateUser() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // await Geolocator.getCurrentPosition(
    //         desiredAccuracy: LocationAccuracy.high,
    //         forceAndroidLocationManager: true)
    //     .then((Position position) {
    _currentPosition = LatLng(position.latitude, position.longitude);
    // widget.onCallback(currentPosition:_currentPosition);
    // print(_currentPosition);
    // });
    //setState(() {});
    return _currentPosition;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: locateUser(),
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
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.my_location, color: CustomTheme.primaryColor),
                      SizedBox(width: 5),
                      Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: CustomTheme.black,
                            fontWeight: FontWeight.bold),
                        textScaleFactor: 1.0,
                      ),
                      SizedBox(width: 135),
                      InkWell(
                        onTap: () {
                          screenNavigator(
                              context,
                              EditLocationScreen(
                                currentPosition:pinnedLocation==null? _currentPosition:pinnedLocation,
                                onStatusChangedSecond: (pinLocation) {
                                  print(
                                      "----------emergency_location_widget ===> ${pinLocation}");
                                  pinnedLocation = pinLocation;
                                  widget.onStatusChanged(pinLocation);
                                  gettingMarker(
                                      googleMapController, pinnedLocation);
                                },
                              ));
                        },
                        child: Text(
                          'Edit Location',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: CustomTheme.primaryColor,
                              fontWeight: FontWeight.bold),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    height: 200,
                    child: GoogleMap(
                        myLocationEnabled: true,
                        markers: markersList,
                        zoomGesturesEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          googleMapController = controller;
                        },
                        onCameraMove: (position) {
                          EmergencyReportScreen.of(context)!.latValue =
                              position.target.latitude.toString();
                          EmergencyReportScreen.of(context)!.longValue =
                              position.target.longitude.toString();

                          StaticEmergencyReportScreen.of(context)!.latValue =
                              position.target.latitude.toString();
                          StaticEmergencyReportScreen.of(context)!.longValue =
                              position.target.longitude.toString();
                        },
                        initialCameraPosition: CameraPosition(
                            target: _currentPosition!, zoom: 14)),
                  ),
                ],
              ),
            );
          }
        });
  }

  void gettingMarker(
      GoogleMapController _googleMapController, LatLng? pinnedLocation) {
    markersList.clear();
    setState(() {
      markersList.add(Marker(
        markerId: MarkerId(pinnedLocation.toString()),
        position: pinnedLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
      _currentPosition = pinnedLocation;
      _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(pinnedLocation.latitude, pinnedLocation.longitude), 14.0));
    });
  }
}
