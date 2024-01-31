import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/presentation/check_point_screen/widgets/curve_design_widget.dart';
import 'package:sgt/presentation/check_point_screen/widgets/timeline_details_widget.dart';
import 'package:sgt/presentation/check_point_screen/widgets/check_point_time_line.dart';
import 'package:sgt/presentation/qr_screen/check_out_points_scanning_screen.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'dart:async';
import 'dart:convert';

import 'package:carp_background_location/carp_background_location.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websocket_universal/websocket_universal.dart';

enum LocationStatus { UNKNOWN, INITIALIZED, RUNNING, STOPPED }

class CheckPointWidget extends StatefulWidget {
  Property? property;
  String? propertyImageBaseUrl;
  List<Checkpoint>? checkpoint;

  CheckPointWidget(
      {super.key, this.property, this.propertyImageBaseUrl, this.checkpoint});

  @override
  State<CheckPointWidget> createState() => _CheckPointWidgetState();
}

class _CheckPointWidgetState extends State<CheckPointWidget> {
  final IMessageProcessor<String, String> textSocketProcessor =
      SocketSimpleTextProcessor();

  final connectionOptions = SocketConnectionOptions(
    pingIntervalMs: 3000, // send Ping message every 3000 ms
    timeoutConnectionMs: 4000, // connection fail timeout after 4000 ms
    skipPingMessages: false,
    pingRestrictionForce: false,
  );

  var textSocketHandler = IWebSocketHandler<String, String>.createClient(
      "ws://arrowtrack-solutions.com:8090", SocketSimpleTextProcessor());
  // var textSocketHandler = IWebSocketHandler<String, String>.createClient(
  // "ws://appdeveloperpro.online:8090", SocketSimpleTextProcessor());

  String textMsg = "";

  Timer? timer;

  LocationDto? _lastLocation;
  StreamSubscription<LocationDto>? locationSubscription;
  LocationStatus _status = LocationStatus.UNKNOWN;

  Future<bool> isLocationAlwaysGranted() async =>
      await Permission.locationAlways.isGranted;

  Future<bool> askedLocationAlwaysPermission() async {
    bool granted = await Permission.locationAlways.isGranted;

    if (!granted) {
      granted =
          await Permission.locationAlways.request() == PermissionStatus.granted;
    }
    return granted;
  }

  @override
  void initState() {
    super.initState();
    connectToSocket();

    LocationManager().interval = 3;
    LocationManager().distanceFilter = 0;
    LocationManager().notificationTitle = 'CARP Location Example';
    LocationManager().notificationMsg = 'CARP is tracking your location';

    _status = LocationStatus.INITIALIZED;

    startBackgroundLocation();
  }

  void startBackgroundLocation() async {
    if (!await isLocationAlwaysGranted()) {
      await askedLocationAlwaysPermission();
    }

    locationSubscription?.cancel();
    locationSubscription = LocationManager().locationStream.listen(onData);
    await LocationManager().start();

    setState(() {
      _status = LocationStatus.RUNNING;
    });
  }

  void connectToSocket() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    textSocketHandler = IWebSocketHandler<String, String>.createClient(
      // "ws://appdeveloperpro.online:8090",
      "ws://arrowtrack-solutions.com:8090",
      textSocketProcessor,
      connectionOptions: connectionOptions,
    );

    /// 2. Listen to webSocket messages:
    // textSocketHandler.incomingMessagesStream.listen((inMsg) {
    //   print('> webSocket  got text message from server: "$inMsg" '
    //       '[ping: ${textSocketHandler.pingDelayMs}]');
    //   textMsg = "$inMsg";
    // });
    textSocketHandler.outgoingMessagesStream.listen((inMsg) {
      print('> webSocket sent text message to server: "$inMsg" '
          '[ping: ${textSocketHandler.pingDelayMs}]');
      textMsg = "$inMsg";
    });
  }

  void onData(LocationDto location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('>> Background ${location.latitude}, ${location.longitude}');

    _lastLocation = location;
    await textSocketHandler.connect();

    Map<String, dynamic> myData = {
      "from_user_id": "${prefs.getString("user_id")}",
      "isGeofencing": true,
      "latitude": "${_lastLocation!.latitude.toString()}",
      "longitude": "${_lastLocation!.longitude.toString()}",
      "type": "guard",
      "user_email": "${prefs.getString("email")}",
      "background_task": 1
    };
    final String encodedData = json.encode(myData);

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      textSocketHandler.sendMessage(encodedData);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurveDesignWidget(
            property: widget.property,
            propertyImageBaseUrl: widget.propertyImageBaseUrl,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 26),
                child: CheckPointTimeLineWidget(
                    checkPointLength: widget.checkpoint),
              ),
              Expanded(child: TimeLineDetailsWidget())
            ],
          ),
          Center(
            child: CustomButtonWidget(
                buttonTitle: 'Clock Out',
                onBtnPress: () {
                  // screenNavigator(context, ClockOutErrorScreen());
                  locationSubscription?.cancel();
                  LocationManager().stop();
                  _status = LocationStatus.STOPPED;

                  textSocketHandler.disconnect('manual disconnect');
                  textSocketHandler.close();

                  timer!.cancel();
                  screenNavigator(context, CheckPointOutScanningScreen());
                  // screenNavigator(context, ClockOutScreen());
                }),
          ),
          // SizedBox(
          //   height: 30,
          // )
        ],
      ),
    );
  }
}
