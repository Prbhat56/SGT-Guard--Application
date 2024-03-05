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
