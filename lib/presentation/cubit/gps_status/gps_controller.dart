import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class GPSController extends GetxController {
  final Location _location = Location();
  late Timer _timerCheck;
  bool _isLocationEnabled = false;

@override
  void onInit() {
    super.onInit();
   _timerCheck = Timer.periodic(Duration(seconds: 8), (Timer timer) {
      _checkLocationService(); // Call function to check location service
    });
  }

  void _checkLocationService() async {
    LocationPermission permission;
    bool serviceEnabled = await _location.serviceEnabled();
    permission = serviceEnabled == false
        ? LocationPermission.always
        : LocationPermission.denied;
    print(serviceEnabled);
    if (serviceEnabled == false) {
      print("service");
      print(permission == LocationPermission.always);
      if (permission == LocationPermission.always) {
        print("service location check");
        _location.requestService();
      }
    }
    // setState(() {
    //   _isLocationEnabled = serviceEnabled;
    // });
  }
 
}
