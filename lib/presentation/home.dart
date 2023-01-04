import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgt/presentation/account_screen/account_screen.dart';
import 'package:sgt/presentation/connect_screen/connect_screen.dart';
import 'package:sgt/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/presentation/notification_screen/notification_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/time_sheet_screen.dart';
import 'package:sgt/presentation/timer/timer.dart';
import 'package:sgt/utils/const.dart';
import 'home_screen/home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int hour = 00;
  int minute = 00;
  int second = 00;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  void updateTime() {
    setState(() {
      var currentTime = DateTime.now();
      hour = currentTime.hour;
      minute = currentTime.minute;
      second = currentTime.second;
    });
  }

  List<Widget> currentWidget = [
    const HomeScreen(),
    const TimeSheetScreen(),
    const ConnectScreen(),
    const NotificationScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to go close the app?',
                    textScaleFactor: 1.0),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      height: 30,
                      width: 40,
                      padding: const EdgeInsets.only(
                        top: 6,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        "No",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      height: 30,
                      width: 40,
                      padding: const EdgeInsets.only(
                        top: 6,
                        left: 8,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        "Yes",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            body: Stack(
              children: [
                currentWidget[
                    BlocProvider.of<NavigationCubit>(context, listen: true)
                        .state
                        .selectedIndex],
                Positioned(
                  top: 595.h,
                  left: 30.w,
                  right: 30.w,
                  child: context.watch<TimerOnCubit>().state.istimerOn
                      ? TimerWidget()
                      : Container(),
                )
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: BottomNavigationBar(
                elevation: 20,
                currentIndex: BlocProvider.of<NavigationCubit>(context)
                    .state
                    .selectedIndex,
                selectedItemColor: primaryColor,
                selectedLabelStyle:
                    TextStyle(color: primaryColor, fontSize: 13),
                type: BottomNavigationBarType.fixed,
                onTap: (index) => BlocProvider.of<NavigationCubit>(context)
                    .changeIndex(index),
                items: [
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.home,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: const Icon(
                      Icons.home,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.receipt_long_rounded,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: const Icon(
                      Icons.receipt_long_rounded,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Time Sheet',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: FaIcon(
                      FontAwesomeIcons.solidComment,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: const FaIcon(
                      FontAwesomeIcons.solidComment,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Connect',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.notifications,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: const Icon(
                      Icons.notifications,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.person,
                      size: 28,
                      color: primaryColor,
                    ),
                    icon: Icon(
                      Icons.person,
                      size: 28,
                      color: Colors.grey,
                    ),
                    label: 'Account',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
