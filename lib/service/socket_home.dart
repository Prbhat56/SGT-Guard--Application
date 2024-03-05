import 'dart:async';
import 'dart:convert';

import 'package:carp_background_location/carp_background_location.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websocket_universal/websocket_universal.dart';

enum LocationStatus { UNKNOWN, INITIALIZED, RUNNING, STOPPED }

class SocketHome extends StatefulWidget {
  const SocketHome({super.key});

  @override
  State<SocketHome> createState() => _SocketHomeState();
}

class _SocketHomeState extends State<SocketHome> {
  TextEditingController my_controller = TextEditingController();

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

  void connectToSocket() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

//ws://appdeveloperpro.online:8090
    textSocketHandler = IWebSocketHandler<String, String>.createClient(
      "ws://arrowtrack-solutions.com:8090",
      textSocketProcessor,
      connectionOptions: connectionOptions,
    );

    /// 2. Listen to webSocket messages:
    textSocketHandler.incomingMessagesStream.listen((inMsg) {
      // print('> webSocket  got text message from server: "$inMsg" '
      //     '[ping: ${textSocketHandler.pingDelayMs}]');
      textMsg = "$inMsg";
    });
    textSocketHandler.outgoingMessagesStream.listen((inMsg) {
      // print('> webSocket sent text message to server: "$inMsg" '
      //     '[ping: ${textSocketHandler.pingDelayMs}]');
      //textMsg = "$inMsg";
    });
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
      "isBackground": true
    };
    final String encodedData = json.encode(myData);

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      textSocketHandler.sendMessage(encodedData);
    });

    setState(() {});
  }

  // Future<void> fetchCurrentLocation() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await textSocketHandler.connect();
  //   if (_isInForeground) {
  // timer = Timer.periodic(Duration(seconds: 3), (timer) async {
  //   await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {

  //     debugPrint(encodedData);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // });
  //   } else {
  //     // var unique = DateTime.now().second.toString();
  //     // await Workmanager().registerPeriodicTask(unique, "get_current_location", frequency: Duration(seconds: 3));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        locationSubscription?.cancel();
        LocationManager().stop();
        _status = LocationStatus.STOPPED;

        textSocketHandler.disconnect('manual disconnect');
        textSocketHandler.close();

        timer!.cancel();
      },
      child: Scaffold(
          appBar: CustomAppBarWidget(appbarTitle: 'Web Socket Demo'),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(22),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 24,
              ),
              Text("Status: ${_status.toString().split('.').last}"),
              Divider(),
              StreamBuilder(
                  stream: textSocketHandler.socketHandlerStateStream,
                  builder: (context, snapshot) {
                    return Text(snapshot.hasData ? "${textMsg}" : "No Data");
                  }),
              Divider(),
              _lastLocation == null
                  ? Text("No location yet")
                  : Text(
                      "${_lastLocation!.latitude}, ${_lastLocation!.longitude} "),
            ]),
          )),
    );
  }

  @override
  void dispose() {
    my_controller.dispose();
    super.dispose();
  }
}
