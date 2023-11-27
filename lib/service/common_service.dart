import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
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


  setTempUserEmailAndPassword(String email,String password) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
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

 Future<String> getUserDetail() async{
    await Future.delayed(Duration(seconds: 8));
    return Future.value(userProfileDetail);
  }

  clearLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  logDataClear() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> openSnackBar(String message,context, {int durationInSeconds = 2}) async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
    );
  }
}
