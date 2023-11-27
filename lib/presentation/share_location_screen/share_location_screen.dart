import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/constant/constant.dart';
import '../../utils/const.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sgt/service/globals.dart';

var user = userDetail;

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({super.key});

  @override
  _ShareLocationScreenState createState() => new _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {

  @override
 void initState() {
    super.initState();
 }

  

  Future<Position> _determinePosition(context) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if(permission== LocationPermission.always || permission== LocationPermission.whileInUse){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          // print("position ====> $position");
          var map = new Map<String,dynamic>();
          map['latitude']= position.latitude.toString();
          map['longitude']=position.longitude.toString();
          var apiService = ApiCallMethodsService();
          apiService.post(apiRoutes['profileUpdate']!,map).then((value) {
            apiService.updateUserDetails(value);
            screenNavigator(context,Home());
          }).onError((error, stackTrace) {
            print(error);
          });
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      if(permission== LocationPermission.always || permission== LocationPermission.whileInUse){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          print("position ====> $position");
          var map = new Map<String,dynamic>();
          map['latitude']= position.latitude.toString();
          map['longitude']=position.longitude.toString();
          var apiService = ApiCallMethodsService();
          apiService.post(apiRoutes['profileUpdate']!,map).then((value) {
            apiService.updateUserDetails(value);
            screenNavigator(context,Home());
          }).onError((error, stackTrace) {
            print(error);
          });
      }
      else{
        throw Exception('Error');
      }
    }
  return await Geolocator.getCurrentPosition();
}

  @override
  Widget build(BuildContext context) {
    
    // print(userDetail.runtimeType);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset('assets/icon_marker.png'),
                  const SizedBox(height: 20),
                  const Text(
                    'Hello,and\nWelcome',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Share your location to get started with your services',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'We only access your location while you are using this incredible app',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: CupertinoButton(
                        
                        disabledColor: seconderyColor,
                        padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 5),
                        color: primaryColor,
                        child: ListTile(
                          leading: Icon(
                            Icons.near_me,
                            color: white,
                          ),
                          title: Text(
                            'Share location',
                            style: TextStyle(fontSize: 17, color: white),
                          ),
                        ),
                        onPressed: () {
                            // screenNavigator(context,Home());
                          _determinePosition(context);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const Home();
                          // }));
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}