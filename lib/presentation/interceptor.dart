import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
    
    class ErrorInterceptor implements InterceptorContract {
      @override
      Future<RequestData> interceptRequest({required RequestData data}) async {
        return data;
      }
    
      @override
      Future<ResponseData> interceptResponse({required ResponseData data}) async {
        if(data.statusCode == 401) {
          print('Unauthorized request');
          // Handle unauthorized request
            var apiService = ApiCallMethodsService();
      apiService.updateUserDetails('');
      var commonService = CommonService();
      FirebaseHelper.signOut();
      FirebaseHelper.auth = FirebaseAuth.instance;
      commonService.logDataClear();
      commonService.clearLocalStorage();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('welcome', '1');
      Navigator.of(context as BuildContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (route) => false,
      );
        }
        return data;
      }
    }