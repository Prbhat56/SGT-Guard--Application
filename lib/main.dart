import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/cubit/email_checker/email_checker_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/isMediaSelected/isMediaSelected_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/ispasswordmatched/ispasswordmarched_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/password_checker/password_checker_cubit.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/connect_screen/cubit/issearching/issearching_cubit.dart';
import 'package:sgt/presentation/connect_screen/cubit/message_pressed/message_pressed_cubit.dart';
import 'package:sgt/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/onboarding_screen/cubit/islastpage/islastpage_cubit.dart';
import 'package:sgt/presentation/settings_screen/cubit/toggle_switch/toggleswitch_cubit.dart';
import 'package:sgt/presentation/share_location_screen/share_location_screen.dart';
import 'package:sgt/presentation/work_report_screen/cubit/addImage/add_image_cubit.dart';
import 'package:sgt/presentation/work_report_screen/cubit/addpeople/addpeople_cubit.dart';
import 'package:sgt/presentation/work_report_screen/cubit/report_type/report_type_cubit.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:get/route_manager.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:sgt/utils/timer_provider.dart';
import 'presentation/authentication_screen/cubit/isValidPassword/is_valid_password_cubit.dart';
import 'presentation/authentication_screen/cubit/issign_in_valid/issigninvalid_cubit.dart';
import 'presentation/connect_screen/cubit/image_picker_cubit/image_picker_cubit.dart';
import 'presentation/connect_screen/cubit/isSelectedMedia/isSelectedMedia_cubit.dart';
import 'presentation/connect_screen/cubit/islongpressed/islongpress_cubit.dart';
import 'presentation/cubit/timer_on/timer_on_cubit.dart';
import 'presentation/onboarding_screen/onboarding_screen.dart';
import 'presentation/property_details_screen/cubit/showmore/showmore_cubit.dart';
import 'presentation/work_report_screen/cubit/addwitness/addwitness_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    configLoading();
    initOneSignalState();
    // runApp(const MyApp());
    runApp(ChangeNotifierProvider(
      create: (context) => TimerProvider(),
      child: MyApp(),
    ),);
  });
  prefs = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => NavigationCubit()),
              BlocProvider(create: (context) => ObscureCubit()),
              BlocProvider(create: (context) => ToggleSwitchCubit()),
              BlocProvider(create: (context) => IslongpressCubit()),
              BlocProvider(create: (context) => MessagePressedCubit()),
              BlocProvider(create: (context) => IspasswordmarchedCubit()),
              BlocProvider(create: (context) => IsMediaSelectedCubit()),
              BlocProvider(create: (context) => IslastpageCubit()),
              BlocProvider(create: (context) => IssearchingCubit()),
              BlocProvider(create: (context) => ToggleMediaCubit()),
              BlocProvider(create: (context) => ImagePickerCubit()),
              BlocProvider(create: (context) => AddpeopleCubit()),
              BlocProvider(create: (context) => AddImageCubit()),
              BlocProvider(create: (context) => IsValidPasswordCubit()),
              BlocProvider(create: (context) => ShowmoreCubit()),
              BlocProvider(create: (context) => TimerOnCubit()),
              BlocProvider(create: (context) => ReportTypeCubit()),
              BlocProvider(create: (context) => AddwitnessCubit()),
              BlocProvider(create: (context) => EmailCheckerCubit()),
              BlocProvider(create: (context) => PasswordCheckerCubit()),
              BlocProvider(create: (context) => IssigninvalidCubit())
            ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SGT',
              theme: CustomTheme.tabBarTheme,
              // routerConfig: _router,
              home: const SplashScreen(),
              builder: EasyLoading.init(),
            ),
          );
        });
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false;
}

void _initializeFirebase() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For Showing Message Notification',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chats',
    visibility: NotificationVisibility.VISIBILITY_PRIVATE,
    allowBubbles: true,
    enableVibration: true,
    enableSound: true,
    showBadge: true,
  );
  print('\nNotification Channel Result: $result');
}

Future<void> initOneSignalState() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  OneSignal.initialize("17f18f43-3ba6-4058-af3b-8ffb75932a8f");
  OneSignal.Notifications.requestPermission(true);

  OneSignal.User.pushSubscription.addObserver((state) {
    print(OneSignal.User.pushSubscription.optedIn);
    print(OneSignal.User.pushSubscription.id);
    print(OneSignal.User.pushSubscription.token);
    print(state.current.jsonRepresentation());
  });

  OneSignal.Notifications.addPermissionObserver((state) {
    print("Has permission " + state.toString());
  });

  OneSignal.Notifications.addClickListener((event) {
    print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
  });

  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    print(
        'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

    /// Display Notification, preventDefault to not display
    event.preventDefault();

    /// Do async work

    /// notification.display() to display after preventing default
    event.notification.display();
  });

  OneSignal.InAppMessages.addClickListener((event) {
    print(
        "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}");
  });
  OneSignal.InAppMessages.addWillDisplayListener((event) {
    print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
  });
  OneSignal.InAppMessages.addDidDisplayListener((event) {
    print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
  });
  OneSignal.InAppMessages.addWillDismissListener((event) {
    print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
  });
  OneSignal.InAppMessages.addDidDismissListener((event) {
    print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
  });
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Center(
          child: Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sgt_logo.jpg"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(seconds: 1), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('welcome') != null) {
        if (prefs.getString('token') != null) {
          LocationPermission permission;
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            screenNavigator(context, ShareLocationScreen());
            if (permission == LocationPermission.deniedForever) {
              return Future.error('Location Not Available');
            }
          } else {
            if (permission == LocationPermission.always ||
                permission == LocationPermission.whileInUse) {
              // if (prefs.getString('shiftId') != null) {
              //   var map = new Map<String, dynamic>();
              //   map['email'] = prefs.getString('email');
              //   map['password'] = prefs.getString('password');
              //   var apiService = ApiCallMethodsService();
              //   apiService.post(apiRoutes['login']!, map).then((value) async {
              //     apiService.updateUserDetails(value);
              //     Map<String, dynamic> jsonMap = json.decode(value);
              //     String token = jsonMap['token'];
              //     var commonService = CommonService();
              //     commonService.setUserToken(token);
              //   }).onError((error, stackTrace) {
              //     print(error);
              //   });
              //   screenNavigator(context, CheckPointScreen());
              // } else {
                var map = new Map<String, dynamic>();
                map['email'] = prefs.getString('email');
                map['password'] = prefs.getString('password');
                var apiService = ApiCallMethodsService();
                apiService.post(apiRoutes['login']!, map).then((value) async {
                  apiService.updateUserDetails(value);
                  Map<String, dynamic> jsonMap = json.decode(value);
                  String token = jsonMap['token'];
                  var commonService = CommonService();
                  commonService.setUserToken(token);
                }).onError((error, stackTrace) {
                  print(error);
                });
                screenNavigator(context, Home());
              // }
            }
          }
        } else {
          screenReplaceNavigator(context,
              SignInScreen(oneSignalId: OneSignal.User.pushSubscription.id));
        }
      } else {
        screenReplaceNavigator(context,
            OnboardingScreen(oneSignalId: OneSignal.User.pushSubscription.id));
      }
    });
  }
}
