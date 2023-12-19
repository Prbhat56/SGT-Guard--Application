import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'cubit/issign_in_valid/issigninvalid_cubit.dart';
import 'package:geolocator/geolocator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
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

  final _formKey = GlobalKey<FormState>();
  var commonService = CommonService();
  @override
  Widget build(BuildContext context) {
    //   var myObj = {
    //   "name": "kaham",
    //   "last": "das"
    // };
    // print(myObj);
    // print(myObj['name']);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
                      'Welcome back',
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
                        'Sign in to continue',
                        style: CustomTheme.greyTextStyle(17)),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomUnderlineTextFieldWidget(
                    bottomPadding: 7,
                    textfieldTitle: 'Email',
                    hintText: 'Enter Email',
                    controller: _emailController,
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
                    textfieldTitle: 'Password',
                    hintText: 'Enter Password',
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
                          'Forgot password',
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
                          buttonTitle: 'Sign In',
                          onBtnPress: () {
                            if (_emailController.text.isEmpty) {
                              commonService.openSnackBar(
                                  'Please enter registered email', context);
                            } else if (_passwordController.text.isEmpty) {
                              commonService.openSnackBar(
                                  'Please enter password', context);
                            } else {
                              handle_SignIn(_emailController.text.toString(),
                                  _passwordController.text.toString());
                            }
                            // screenNavigator(context, Home());
                          })
                      : CustomButtonWidget(
                          isValid: context
                              .watch<IssigninvalidCubit>()
                              .state
                              .issigninValid,
                          buttonTitle: 'Sign In',
                          onBtnPress: () {
                            if (_emailController.text.isEmpty) {
                              commonService.openSnackBar(
                                  'Please enter registered email', context);
                            } else if (_passwordController.text.isEmpty) {
                              commonService.openSnackBar(
                                  'Please enter password', context);
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
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));

    try {
      String apiUrl = baseUrl + apiRoutes['login']!;
      Map<String, dynamic> myJsonBody = {'email': email, 'password': password};
      Response response = await post(Uri.parse(apiUrl), body: myJsonBody);
      var data = jsonDecode(response.body.toString());
      print(data);

      var apiService = ApiCallMethodsService();
      apiService.updateUserDetails(data);

      if (response.statusCode == 200) {
        commonService.setUserToken(data['token'].toString());
        commonService.setTempUserEmailAndPassword(email, password);
        commonService.openSnackBar(data['message'], context);

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
      } else if (response.statusCode == 400) {
        Navigator.of(context).pop();
        commonService.openSnackBar(data['message'] ?? data['error'], context);
      } else {
        Navigator.of(context).pop();
        commonService.openSnackBar(data['message'] ?? data['error'], context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      commonService.openSnackBar(e.toString(), context);
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
