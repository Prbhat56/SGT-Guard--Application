import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sgt/theme/colors.dart';

import '../../../utils/const.dart';

class EditLocationScreen extends StatefulWidget {
  LatLng? currentPosition;
  final ValueChanged<LatLng> onStatusChangedSecond;
  EditLocationScreen(
      {super.key, this.currentPosition, required this.onStatusChangedSecond});

  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

const kGoogleApiKey = 'AIzaSyC8ANlL0wwuYmR3Y64I6qqv6vpxbkdKdsM';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _EditLocationScreenState extends State<EditLocationScreen> {
  // LatLng? _currentPosition;
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;

  Set<Marker> markersList = {};
  Timer? _debounce;
  LatLng? currentlocation;
  String location = "Search Location";

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

//  setState(() {
//       _markers.add(Marker(
//         markerId: MarkerId(point.toString()),
//         position: point,
//         infoWindow: InfoWindow(
//           title: 'I am a marker',
//         ),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       ));
//     });

  void _addMarker(GoogleMapController controller, currentPosition) {
    // markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: currentPosition,
        infoWindow: InfoWindow(title: 'I am a marker')));
    setState(() {});
    currentlocation = currentPosition;
    controller.animateCamera(CameraUpdate.newLatLngZoom(currentPosition, 14.0));
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

  // Future<void> _moveToNewLocation() async {
  //   const _newoposition = LatLng(12, 31);
  //   _googleMapController.animateCamera(CameraUpdate.newLatLng(_newoposition));

  //   setState(() {
  //     const marker = Marker(
  //         markerId: MarkerId('newLocaion'),
  //         position: _newoposition,
  //         infoWindow: InfoWindow(title: "New work"));

  //     _markers
  //       ..clear()
  //       ..add(marker);
  //   });
  // }

  _onSearchChanged(String query) {            // debounce 
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      print("------------query------------------> ${query}");
    });
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        overlayBorderRadius: BorderRadius.circular(20),
        hint: 'Search',
        components: [Component(Component.country, "ind")]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    print('------------------------------------------> ${detail.result}');

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
        ));
    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
    currentlocation = LatLng(lat, lng);
  }

  _handleTap(LatLng point) {
    markersList.clear();
    setState(() {
      markersList.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        // infoWindow: InfoWindow(
        //   title: 'I am a marker',
        // ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
      currentlocation = point;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // centerTitle: true,
        title: Align(
          alignment: Alignment(-1.1.w, 0.w),
          child: Text(
            "Report Location",
            textScaleFactor: 1.0,
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp),
          ),
        ),
      ),
      body: Stack(
        children: [
          // init Google Maps With ApiKey Shared by Suravi
          GoogleMap(
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(target: LatLng(widget.currentPosition!.latitude,widget.currentPosition!.longitude), zoom: 14.0),
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
            onTap:(x)=> _handleTap(x),
          ),
          Positioned(
              top: 15,
              right: 10,
              child: InkWell(
                onTap: _handlePressButton,
                child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(
                            0,
                            3,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.search,
                      size: Checkbox.width,
                      color: AppColors.white,
                    )),
              )),
          Positioned(
              bottom: 60,
              left: 30,
              child: Row(
                children: [
                  InkWell(
                    onTap: currentlocation != null
                        ? () {
                            widget.onStatusChangedSecond(currentlocation!);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Container(
                      height: 50,
                      width: 264,
                      decoration: BoxDecoration(
                          color: currentlocation != null
                              ? primaryColor
                              : AppColors.disableColor,
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
                      _addMarker(googleMapController, widget.currentPosition);
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

          // GoogleMap(
          //   markers: _markers,
          //   initialCameraPosition: initialCameraPosition,
          //   onMapCreated: (GoogleMapController controller) {
          //     googleMapController = controller;
          //   },
          //   onTap:(x)=> _handleTap(x),
          // ),
        ],
      ),
    );
  }
}
