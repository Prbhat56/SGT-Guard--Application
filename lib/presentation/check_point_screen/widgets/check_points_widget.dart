import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/presentation/check_point_screen/utils/countdown_timer.dart';
import 'package:sgt/presentation/check_point_screen/widgets/curve_design_widget.dart';
import 'package:sgt/presentation/check_point_screen/widgets/timeline_details_widget.dart';
import 'package:sgt/presentation/check_point_screen/widgets/check_point_time_line.dart';
import 'package:sgt/presentation/qr_screen/check_out_points_scanning_screen.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'dart:async';
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
  String? statusOfCheckpoints;
  String? checkpointVisitedStatus;
  String? latestCheckpointId;
  String? routeId;
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
    String timeString = widget.property!.shift!.clockOutFull!.toString();
    DateTime dateTime = DateTime.parse(timeString);
    DateTime currentTime = DateTime.now();
    int differenceInSeconds = dateTime.difference(currentTime).inSeconds;
    initTimerOperation(differenceInSeconds.toInt());
    super.initState();
    // connectToSocket();

    LocationManager().interval = 10;
    LocationManager().distanceFilter = 0;
    LocationManager().notificationTitle = 'CARP Location Example';
    LocationManager().notificationMsg = 'CARP is tracking your location';

    _status = LocationStatus.INITIALIZED;

    startBackgroundLocation();
  }

  @override
void dispose() {
  timer!.cancel();
  super.dispose();
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

  // void connectToSocket() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();

  //   textSocketHandler = IWebSocketHandler<String, String>.createClient(
  //     // "ws://appdeveloperpro.online:8090",
  //     "ws://arrowtrack-solutions.com:8090",
  //     textSocketProcessor,
  //     connectionOptions: connectionOptions,
  //   );

  //   /// 2. Listen to webSocket messages:
  //   textSocketHandler.incomingMessagesStream.listen((inMsg) {
  //     print('> webSocket  got text message from server: "$inMsg" '
  //         '[ping: ${textSocketHandler.pingDelayMs}]');
  //     // textMsg = "$inMsg";
  //   });
  //   // textSocketHandler.outgoingMessagesStream.listen((inMsg) {
  //   //   print('> webSocket sent text message to server: "$inMsg" '
  //   //       '[ping: ${textSocketHandler.pingDelayMs}]');
  //   //   textMsg = "$inMsg";
  //   // });
  // }

  void onData(LocationDto location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    latestCheckpointId = prefs.getString('Cp');
    routeId = prefs.getString('routeId');
    _lastLocation = location;
    await textSocketHandler.connect();
    prefs.setString('latitude', _lastLocation!.latitude.toString());
    prefs.setString('longitude', _lastLocation!.longitude.toString());
    String? shift_id = prefs.getString('shiftId');
    String? property_id = prefs.getString('propertyId');
    print("latitude ==> ${_lastLocation!.latitude.toString()}");
    print("longitude ==> ${_lastLocation!.longitude.toString()}");
    print("shift_id ==> ${shift_id.toString()}");
    print("latestCheckpointId ==> ${latestCheckpointId.toString()}");
    print("routeId ==> ${routeId.toString()}");
    await FirebaseHelper.createGuardLocation(
        _lastLocation!.latitude.toString(),
        _lastLocation!.longitude.toString(),
        shift_id.toString(),
        latestCheckpointId.toString(),
        routeId.toString(),
        property_id.toString());
    // Map<String, dynamic> myData = {
    //   "from_user_id": "${prefs.getString("user_id")}",
    //   "isGeofencing": true,
    //   "latitude": "${_lastLocation!.latitude.toString()}",
    //   "longitude": "${_lastLocation!.longitude.toString()}",
    //   "type": "guard",
    //   "user_email": "${prefs.getString("email")}",
    //   "isBackground": true
    // };
    // final String encodedData = json.encode(myData);
    // timer = Timer.periodic(Duration(seconds: 20), (timer) {
    //   textSocketHandler.sendMessage(encodedData);
    // });
    // setState(() {});
  }


  late int countdownSeconds; //total timer limit in seconds
  late CountdownTimer countdownTimer;
  bool isTimerRunning = false;
  
  

  void initTimerOperation( int countdownseconds) async{
    
    //timer callbacks
    countdownSeconds = countdownseconds;
    countdownTimer = CountdownTimer(
      seconds: countdownSeconds,
      onTick: (seconds) {
        isTimerRunning = true;
        // countdownSeconds = seconds;
        setState(() {
          countdownSeconds = seconds; //this will return the timer values
        });
      },
      onFinished: () {
        stopTimer();
        // Handle countdown finished
      },
    );

     SharedPreferences prefs = await SharedPreferences.getInstance();
     print("countdownSeconds -----------------${countdownSeconds}" );
     countdownSeconds == 0 && countdownSeconds == "0" ? prefs.setString('isTimer', '0') : '';

    //native app life cycle
    SystemChannels.lifecycle.setMessageHandler((msg) {
      // On AppLifecycleState: paused
      if (msg == AppLifecycleState.paused.toString()) {
        if (isTimerRunning) {
          countdownTimer.pause(countdownSeconds); //setting end time on pause
        }
      }

      // On AppLifecycleState: resumed
      if (msg == AppLifecycleState.resumed.toString()) {
        if (isTimerRunning) {
          countdownTimer.resume();
        }
      }
      return Future(() => null);
    });

    //starting timer
    isTimerRunning = true;
    countdownTimer.start();
  }

   void stopTimer() {
    isTimerRunning = false;
    countdownTimer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurveDesignWidget(
                countdownseconds:countdownSeconds,
                checkPointLength: widget.checkpoint,
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
                  CheckPointTimeLineWidget(
                      checkPointLength: widget.checkpoint),
                  Expanded(child: TimeLineDetailsWidget(
                    onStatusChanged: (checkPointStatus) {
                      statusOfCheckpoints = checkPointStatus;
                    },
                    onCheckpointVisitedStatusChanged : (visitedIndex) {
                      checkpointVisitedStatus = visitedIndex;
                    }
                    ))
                ],
              ),
              Center(
                child: CustomButtonWidget(
                    buttonTitle: 'Clock Out',
                    onBtnPress: () {
                      locationSubscription?.cancel();
                      LocationManager().stop();
                      _status = LocationStatus.STOPPED;
                      // textSocketHandler.disconnect('manual disconnect');
                      // textSocketHandler.close();
                      // timer!.cancel();
                      screenNavigator(
                          context,
                          CheckPointOutScanningScreen(
                              checkPointsStatus: statusOfCheckpoints.toString()));
                      // screenNavigator(context, ClockOutScreen());
                    }),
              ),
              // SizedBox(
              //   height: 30,
              // )
            ],
          ),
        ),
      ],
    );
  }
}
