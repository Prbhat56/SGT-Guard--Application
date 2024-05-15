// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:sgt/presentation/account_screen/model/guard_details_model.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/share_location_screen/share_location_screen.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/cubit/email_checker/email_checker_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/password_checker/password_checker_cubit.dart';
import 'package:sgt/presentation/authentication_screen/forgot_password_screen.dart';
import 'package:sgt/presentation/authentication_screen/widget/error_widgets.dart';
import 'package:sgt/presentation/authentication_screen/widget/language_change_oprion_widget.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_underline_textfield_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';
import 'cubit/issign_in_valid/issigninvalid_cubit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


class SignInScreen extends StatefulWidget {
  String? oneSignalId;
  SignInScreen({super.key,this.oneSignalId});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _deviceId;
  var uuid = Uuid();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    initPlatformState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    String? deviceId;
    try {
      if (Platform.isIOS) {
        deviceId = await PlatformDeviceId.getDeviceId;
      } else if (Platform.isAndroid) {
        var uiid = await PlatformDeviceId.getDeviceId;
        deviceId = uuid.v5(Uuid.NAMESPACE_URL, uiid).toUpperCase();
        print("deviceId ===========> ${deviceId}");
      }
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
    });
  }

  final _formKey = GlobalKey<FormState>();
  var commonService = CommonService();
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  LanguageChangeOptionWidget(), //language change optionwidget
                  SizedBox(
                    height: 44.h,
                  ),
                  Center(
                    child: Text(
                      'welcome'.tr,
                      textScaleFactor: 1.0,
                      style: CustomTheme.blackTextStyle(25),
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Center(
                    child: Text(
                        textScaleFactor: 1.0,
                        'sign_in'.tr,
                        style: CustomTheme.greyTextStyle(17)),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomUnderlineTextFieldWidget(
                    bottomPadding: 7,
                    textfieldTitle: 'email'.tr,
                    hintText: 'enter_email'.tr,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autoCorrect: false,
                    onChanged: (value) {
                      // print(value);
                      context.read<EmailCheckerCubit>().checkEmail(value);
                    },
                  ),
                  context.watch<EmailCheckerCubit>().state.isemailValid
                      ? Container()
                      : CustomErrorWidget.emailError(),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomUnderlineTextFieldWidget(
                    bottomPadding: 7,
                    textfieldTitle: 'password'.tr,
                    hintText: 'enter_password'.tr,
                    controller: _passwordController,
                    autoCorrect: false,
                    obscureText: context.watch<ObscureCubit>().state.isObscure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<ObscureCubit>().changeVisibility();
                      },
                      icon: context.watch<ObscureCubit>().state.isObscure
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black,
                              size: 20,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                    ),
                    onChanged: (value) {
                      context.read<PasswordCheckerCubit>().checkPassword(value);
                      context.read<IssigninvalidCubit>().checkSignIn(context
                              .read<EmailCheckerCubit>()
                              .state
                              .isemailValid &&
                          context.read<PasswordCheckerCubit>().state.password);
                    },
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      context.watch<PasswordCheckerCubit>().state.password
                          ? Container()
                          : CustomErrorWidget.passwordError(),
                      InkWell(
                        onTap: () {
                          screenNavigator(context, ForgotPasswordScreen());
                        },
                        child: Text(
                          'forget_password'.tr,
                          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  context.watch<IssigninvalidCubit>().state.issigninValid
                      ? CustomButtonWidget(
                          isValid: context
                              .watch<IssigninvalidCubit>()
                              .state
                              .issigninValid,
                          buttonTitle: 'sign_in_text'.tr,
                          onBtnPress: () {
                            if (_emailController.text.isEmpty) {
                              // commonService.openSnackBar(
                              //     'Please enter registered email', context);
                              EasyLoading.showInfo(
                                  'Please enter registered email');
                            } else if (_passwordController.text.isEmpty) {
                              // commonService.openSnackBar(
                              //     'Please enter password', context);
                              EasyLoading.showInfo('Please enter password');
                            } else {
                              handle_SignIn(_emailController.text.toString(),
                                  _passwordController.text.toString());
                            }
                          })
                      : CustomButtonWidget(
                          isValid: context
                              .watch<IssigninvalidCubit>()
                              .state
                              .issigninValid,
                          buttonTitle: 'Sign In',
                          onBtnPress: () {
                            if (_emailController.text.isEmpty) {
                              // commonService.openSnackBar(
                              //     'Please enter registered email', context);
                              EasyLoading.showInfo(
                                  'Please enter registered email');
                            } else if (_passwordController.text.isEmpty) {
                              // commonService.openSnackBar(
                              //     'Please enter password', context);
                              EasyLoading.showInfo('Please enter password');
                            }
                          }),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handle_SignIn(String email, String password) async {
    EasyLoading.show();

    print("deviceId->$_deviceId");

    try {
      String apiUrl = baseUrl + apiRoutes['login']!;
      Map<String, dynamic> myJsonBody = {
        'email': email,
        'password': password,
        'one_signal':OneSignal.User.pushSubscription.id !=null ? OneSignal.User.pushSubscription.id : _deviceId.toString(),
      };
      print(myJsonBody.toString());
      final response = await post(Uri.parse(apiUrl), body: myJsonBody);
      var data = jsonDecode(response.body.toString());
      print(data);

      var apiService = ApiCallMethodsService();
      apiService.updateUserDetails(data);

      if (response.statusCode == 200) {
        String userDetails = jsonEncode(GuardDetails.fromJson(data));
        commonService.setUserProfile(userDetails);
        commonService.setUserToken(data['token'].toString());
        commonService.setProperty_owner_id(
            data['user_details']['property_owner_id'].toString());
        commonService.setTempUserEmailAndPassword(
            "${data['user_details']['id'].toString()}", email, password);
        print("${data['user_details']['id'].toString()}");

        commonService.setTempUserImageAndName(
            "${data['user_details']['first_name'].toString()} ${data['user_details']['last_name'].toString()}",
            "${data['image_base_url'].toString()}${data['user_details']['avatar'].toString()}");
        //commonService.openSnackBar(data['message'], context);
        EasyLoading.showSuccess(data['message'],
            duration: Duration(seconds: 2));

        LocationPermission permission;
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          FirebaseHelper.signUp(email: email, password: password)
              .then((result) {
            if (result == null) {
              EasyLoading.show();
              FirebaseHelper.signIn(email: email, password: password)
                  .then((result) async {
                if (result == null) {
                  if (await FirebaseHelper.userExists()) {
                    EasyLoading.dismiss();
                    screenNavigator(context, ShareLocationScreen());
                  } else {
                    await FirebaseHelper.createPropertyOwner().then((value) {
                      EasyLoading.dismiss();
                      screenNavigator(context, ShareLocationScreen());
                    });
                  }
                } else {
                  //commonService.openSnackBar(result, context);
                  EasyLoading.showInfo(result);
                }
              });
            } else {
              //commonService.openSnackBar(result, context);
              EasyLoading.showInfo(result);
            }
            EasyLoading.dismiss();
          });

          if (permission == LocationPermission.deniedForever) {
            return Future.error('Location Not Available');
          }
        } else {
          if (permission == LocationPermission.always ||
              permission == LocationPermission.whileInUse) {
            FirebaseHelper.signUp(email: email, password: password)
                .then((result) {
              if (result == null) {
                EasyLoading.show();
                FirebaseHelper.signIn(email: email, password: password)
                    .then((result) async {
                  if (result == null) {
                    if (await FirebaseHelper.userExists()) {
                      EasyLoading.dismiss();
                      screenNavigator(context, Home());
                    } else {
                      await FirebaseHelper.createPropertyOwner().then((value) {
                        EasyLoading.dismiss();
                        screenNavigator(context, Home());
                      });
                    }
                  } else {
                    //commonService.openSnackBar(result, context);
                    EasyLoading.showInfo(result);
                  }
                });
              } else {
                //commonService.openSnackBar(result, context);
                EasyLoading.showInfo(result);
              }
              EasyLoading.dismiss();
            });
          }
        }
      } else if (response.statusCode == 400) {
        EasyLoading.dismiss();
        //commonService.openSnackBar(data['message'] ?? data['error'], context);
        EasyLoading.showInfo(data['message'] ?? data['error']);
      } else {
        EasyLoading.dismiss();
        //commonService.openSnackBar(data['message'] ?? data['error'], context);
        EasyLoading.showInfo(data['message'] ?? data['error']);
      }
    } catch (e) {
      EasyLoading.dismiss();
      //commonService.openSnackBar(e.toString(), context);
      EasyLoading.showError(e.toString());
    }

    /*var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    var apiService = ApiCallMethodsService();
    apiService.post(apiRoutes['login']!, map).then((value) async {
      apiService.updateUserDetails(value);
      Map<String, dynamic> jsonMap = json.decode(value);
      // Map<String, dynamic> userDetails = jsonMap['user_details'];
      String token = jsonMap['token'];

      commonService.setUserToken(token);
      commonService.setTempUserEmailAndPassword(email, password);
      commonService.openSnackBar(jsonMap['message'], context);
      // apiService.updateUserDetails(userDetails);
      // screenNavigator(context, Home());
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        Navigator.of(context).pop();
        screenNavigator(context, ShareLocationScreen());
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      } else {
        if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          Navigator.of(context).pop();
          screenNavigator(context, Home());
        }
      }
    }).onError((error, stackTrace) {
      Navigator.of(context).pop();
      print(error);
    });
    */
  }
}