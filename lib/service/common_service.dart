import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonService {
  final ValueNotifier<bool> open = ValueNotifier<bool>(false);
  final ValueNotifier<bool> userLoggedIn = ValueNotifier<bool>(false);
  final ValueNotifier<bool> userLoggedOut = ValueNotifier<bool>(false);

  String? userProfileDetail;

  setUserToken(String userToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', userToken);
  }

  setTempUserEmailAndPassword(String id, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', id);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  setTempUserImageAndName(String name, String dp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('profile_image', dp);
  }

  Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  getWelcomeClicked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('welcome');
  }

  setUserDetail(String userDetail) {
    userProfileDetail = userDetail;
  }

  Future<String> getUserDetail() async {
    await Future.delayed(Duration(seconds: 8));
    return Future.value(userProfileDetail);
  }

  clearLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  logDataClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  setTimerDetails(String formattedTime,
  bool dottedTime,
  int countdownseconds,) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('formattedTime',formattedTime);
        prefs.setInt('countdownseconds',countdownseconds);
        prefs.setBool('dottedTime',dottedTime);
  }

  Future<void> openSnackBar(String message, context,
      {int durationInSeconds = 2}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static fieldFocusChnage(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  setProperty_owner_id(String userToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('property_owner_id', userToken);
  }

  setUserProfile(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile', user);
  }
}

class MyDateUtil {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: primaryColor,
        behavior: SnackBarBehavior.floating));
  }

  // for getting formatted time from milliSecondsSinceEpochs String
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String getChatMsgTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String month = _getMonth(time);

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return '$formattedTime';  // return 'Today at $formattedTime';
    // } else if ((now.difference(time).inHours / 24).round() == 1) {     // For 12 Hour Format
    } else if ((now.difference(time).inHours).round() == 1) {
      return 'Yesterday at $formattedTime';
    // } else if ((now.difference(time).inHours / 24).round() == 0) {     // For 12 Hour Format
    } else if ((now.difference(time).inHours).round() == 0) {
      return 'Yesterday at $formattedTime';
    } else {
      return '${time.day} $month, $formattedTime';
    }
  }

  // for getting formatted time for sent & read
  static String getMessageTime(
      {required BuildContext context, required String time}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    final formattedTime = TimeOfDay.fromDateTime(sent).format(context);
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return formattedTime;
    }

    return now.year == sent.year
        ? '$formattedTime - ${sent.day} ${_getMonth(sent)}'
        : '$formattedTime - ${sent.day} ${_getMonth(sent)} ${sent.year}';
  }

  //get last message time (used in chat user card)
  static String getLastMessageTime(
      {required BuildContext context,
      required String time,
      bool showYear = false}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }

    return showYear
        ? '${sent.day} ${_getMonth(sent)} ${sent.year}'
        : '${sent.day} ${_getMonth(sent)}';
  }

  //get formatted last active time of user in chat screen
  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Last seen not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = _getMonth(time);

    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  // get month name from month no. or index
  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }
}



// class MyLiveLocationInit {
//    final IMessageProcessor<String, String> textSocketProcessor =
//       SocketSimpleTextProcessor();

//   final connectionOptions = SocketConnectionOptions(
//     pingIntervalMs: 3000, // send Ping message every 3000 ms
//     timeoutConnectionMs: 4000, // connection fail timeout after 4000 ms
//     skipPingMessages: false,
//     pingRestrictionForce: false,
//   );
//  String textMsg = "";

//   Timer? timer;

//   LocationDto? _lastLocation;
//   StreamSubscription<LocationDto>? locationSubscription;
//   LocationStatus _status = LocationStatus.UNKNOWN;

//   Future<bool> isLocationAlwaysGranted() async =>
//       await Permission.locationAlways.isGranted;

//   Future<bool> askedLocationAlwaysPermission() async {
//     bool granted = await Permission.locationAlways.isGranted;

//     if (!granted) {
//       granted =
//           await Permission.locationAlways.request() == PermissionStatus.granted;
//     }
//     return granted;
//   }
   
//    LocationManager().interval = 10;
//     LocationManager().distanceFilter = 0;
//     LocationManager().notificationTitle = 'CARP Location Example';
//     LocationManager().notificationMsg = 'CARP is tracking your location';

//     _status = LocationStatus.INITIALIZED;

//     startBackgroundLocation();

//      void startBackgroundLocation() async {
//     if (!await isLocationAlwaysGranted()) {
//       await askedLocationAlwaysPermission();
//     }

//     locationSubscription?.cancel();
//     locationSubscription = LocationManager().locationStream.listen(onData);
//     await LocationManager().start();

//     setState(() {
//       _status = LocationStatus.RUNNING;
//     });
//   }

//    void onData(LocationDto location) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     firstCheckpointId = widget.checkpoint!.first.id.toString();
//     routeId = widget.checkpoint!.first.routeId.toString();
//     _lastLocation = location;
//     await textSocketHandler.connect();
//     prefs.setString('latitude', _lastLocation!.latitude.toString());
//     prefs.setString('longitude', _lastLocation!.longitude.toString());
//     String? shift_id = prefs.getString('shiftId');
//     String? property_id = prefs.getString('propertyId');
//     print("latitude ==> ${_lastLocation!.latitude.toString()}");
//     // print("longitude ==> ${_lastLocation!.longitude.toString()}");
//     // print("shift_id ==> ${shift_id.toString()}");
//     // print("firstCheckpointId ==> ${firstCheckpointId.toString()}");
//     // print("routeId ==> ${routeId.toString()}");
//     await FirebaseHelper.createGuardLocation(
//         _lastLocation!.latitude.toString(),
//         _lastLocation!.longitude.toString(),
//         shift_id.toString(),
//         firstCheckpointId.toString(),
//         routeId.toString(),
//         property_id.toString());
//     // Map<String, dynamic> myData = {
//     //   "from_user_id": "${prefs.getString("user_id")}",
//     //   "isGeofencing": true,
//     //   "latitude": "${_lastLocation!.latitude.toString()}",
//     //   "longitude": "${_lastLocation!.longitude.toString()}",
//     //   "type": "guard",
//     //   "user_email": "${prefs.getString("email")}",
//     //   "isBackground": true
//     // };
//     // final String encodedData = json.encode(myData);
//     // timer = Timer.periodic(Duration(seconds: 20), (timer) {
//     //   textSocketHandler.sendMessage(encodedData);
//     // });
//   }
// }
