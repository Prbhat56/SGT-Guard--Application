import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Map<String, Marker> _markers = {};
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

  LatLng currentlocation = const LatLng(22.572645, 88.363892);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
            zoomGesturesEnabled: false,
            initialCameraPosition:
                CameraPosition(target: currentlocation, zoom: 14)),
      ),
    );
  }
}
