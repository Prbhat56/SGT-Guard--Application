import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sgt/presentation/authentication_screen/cubit/ispasswordmatched/ispasswordmarched_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/connect_screen/cubit/issearching/issearching_cubit.dart';
import 'package:sgt/presentation/connect_screen/cubit/message_pressed/message_pressed_cubit.dart';
import 'package:sgt/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:sgt/presentation/onboarding_screen/cubit/islastpage/islastpage_cubit.dart';
import 'package:sgt/presentation/settings_screen/cubit/toggle_switch/toggleswitch_cubit.dart';
import 'package:sgt/utils/const.dart';
import 'presentation/connect_screen/cubit/islongpressed/islongpress_cubit.dart';
import 'presentation/onboarding_screen/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

//final GoRouter _router = GoRouter(routes: <RouteBase>[
// GoRoute(
//     path: '/',
//     builder: (BuildContext context, GoRouterState state) {
//       return OnboardingScreen();
//     }),
// GoRoute(path: 'timesheet'),
// GoRoute(path: 'connect'),
// GoRoute(path: 'notificaion'),
// GoRoute(path: 'account'),
// ]);

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
              BlocProvider(create: (context) => IslastpageCubit()),
              BlocProvider(create: (context) => IssearchingCubit()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SGT',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              // routerConfig: _router,
              home: const SplashScreen(),
            ),
          );
        });
  }
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
    Timer(const Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}
