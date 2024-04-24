import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //final Map<String, Marker> _markers = {};
  // Future<void> _onMapCreated(GoogleMapController controller) async {
  // final googleOffices = await locations.getGoogleOffices();
  // setState(() {
  //   _markers.clear();

  // final marker = Marker(
  //   markerId: MarkerId(office.name),
  //   position: LatLng(office.lat, office.lng),
  //   infoWindow: InfoWindow(
  //     title: office.name,
  //     snippet: office.address,
  //   ),
  // );
  // _markers[office.name] = marker;
  //   });
  // }

  LatLng? _currentPosition;
  Future<LatLng?> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // await Geolocator.getCurrentPosition(
    //         desiredAccuracy: LocationAccuracy.high,
    //         forceAndroidLocationManager: true)
    // .then((Position position) {
    print(position);
    _currentPosition = LatLng(position.latitude, position.longitude);
    print(_currentPosition);
    // });
    setState(() {
      _currentPosition;
    });
    return _currentPosition;
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Container(
                    height: 60, width: 60, child: CircularProgressIndicator()));
          } else {
          return Scaffold(
              body: SafeArea(
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(target: _currentPosition!, zoom: 14)
                        ),
              ),
            );
          }
        });
  }
}
