import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../utils/const.dart';

class EditLocationScreen extends StatefulWidget {
  LatLng? currentPosition;
  EditLocationScreen({super.key, this.currentPosition});

  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  // LatLng? _currentPosition;
  LatLng currentlocation = const LatLng(22.572645, 88.363892);
  late final GoogleMapController _googleMapController;
  final Set<Marker> _markers = {};
  String location = "Search Location";



  void _addMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('currentlocation'),
          position: currentlocation,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  // Future<LatLng?> _addMarker() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   _currentPosition = LatLng(position.latitude, position.longitude);
  //   print(_currentPosition);
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId('currentlocation'),
  //         position: _currentPosition!,
  //         icon: BitmapDescriptor.defaultMarker,
  //       ),
  //     );
  //   });
  //   return _currentPosition;
  // }

  Future<void> _moveToNewLocation() async {
    const _newoposition = LatLng(12, 31);
    _googleMapController.animateCamera(CameraUpdate.newLatLng(_newoposition));

    setState(() {
      const marker = Marker(
          markerId: MarkerId('newLocaion'),
          position: _newoposition,
          infoWindow: InfoWindow(title: "New work"));

      _markers
        ..clear()
        ..add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("=====================> ${widget.currentPosition}");

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              markers: _markers,
              initialCameraPosition:CameraPosition(target: widget.currentPosition!, zoom: 14)),


                  
                  // CameraPosition(target: widget.currentPosition!, zoom: 14)),
          // Positioned(
          //     //search input bar
          //     top: 10,
          //     child: InkWell(
          //         onTap: () async {
          //           var place = await PlacesAutocomplete.show(
          //               context: context,
          //               apiKey: 'AIzaSyB3cGAZqnXaZIm_Nks0yQ3vIdhfJR9Xtgc',
          //               mode: Mode.overlay,
          //               types: [],
          //               strictbounds: false,
          //               components: [Component(Component.country, 'np')],
          //               //google_map_webservice package
          //               onError: (err) {
          //                 print(err);
          //               });

          //           if (place != null) {
          //             setState(() {
          //               location = place.description.toString();
          //             });
          //             //form google_maps_webservice package
          //             final plist = GoogleMapsPlaces(
          //               apiKey: 'AIzaSyB3cGAZqnXaZIm_Nks0yQ3vIdhfJR9Xtgc',
          //               apiHeaders: await GoogleApiHeaders().getHeaders(),
          //               //from google_api_headers package
          //             );
          //             String placeid = place.placeId ?? "0";
          //             final detail = await plist.getDetailsByPlaceId(placeid);
          //             final geometry = detail.result.geometry!;
          //             final lat = geometry.location.lat;
          //             final lang = geometry.location.lng;
          //             var newlatlang = LatLng(lat, lang);

          //             //move map camera to selected place with animation
          //             _googleMapController.animateCamera(
          //                 CameraUpdate.newCameraPosition(
          //                     CameraPosition(target: newlatlang, zoom: 17)));
          //           }
          //         },
          //         child: Padding(
          //           padding: EdgeInsets.all(15),
          //           child: Card(
          //             child: Container(
          //                 padding: EdgeInsets.all(0),
          //                 width: MediaQuery.of(context).size.width - 40,
          //                 child: ListTile(
          //                   leading: Icon(Icons.search),
          //                   title: Text(
          //                     location,
          //                     style: TextStyle(fontSize: 18),
          //                   ),
          //                   trailing: Icon(Icons.search),
          //                   dense: true,
          //                 )),
          //           ),
          //         ))),
          Positioned(
            top: 60,
            left: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 57,
                  decoration: BoxDecoration(
                      color: white, border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Icon(Icons.arrow_back_ios, color: black),
                  ),
                ),
                Container(
                  //height: 40,
                  width: 300,
                  color: white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2),
                      ),
                      hintText: 'Search..',
                      hintStyle: GoogleFonts.montserrat(
                        textStyle: const TextStyle(color: Colors.grey),
                      ),
                      fillColor: white,
                      focusColor: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 60,
              left: 30,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _moveToNewLocation();
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          "Use Pinned Location",
                          style: TextStyle(color: white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _addMarker();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.my_location,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
