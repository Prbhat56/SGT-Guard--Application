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
import 'package:sgt/presentation/widgets/bottom_navigation_bar_model.dart';
import 'package:sgt/presentation/widgets/should_pop_alert_dialog.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen/home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? timerStatus;
  int hour = 00;
  int minute = 00;
  int second = 00;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    checkTimerStatus();
    _selectedIndex = 0;

    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  void checkTimerStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      timerStatus = prefs.getString('isTimer');
      timerStatus == '1' ? context.read<TimerOnCubit>().turnOnTimer() : context.read<TimerOnCubit>().turnOffTimer();
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
    //  Container(),
    const ConnectScreen(),
    const NotificationScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      context.read<NavigationCubit>().changeIndex(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    checkTimerStatus();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return ShouldPopAlertDialog(); //will show a alert dialog if user want to close the app
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
                      _selectedIndex], //context.watch<NavigationCubit>().state.selectedIndex
                  Positioned(
                    top: 595.h,
                    left: 30.w,
                    right: 30.w,
                    child: (timerStatus == null || timerStatus == '1' || timerStatus == 'null' || timerStatus == '')
                        ? context.watch<TimerOnCubit>().state.istimerOn
                            ? TimerWidget()
                            : Container()
                        : Container()
                  )
                ],
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: seconderyColor),
                ),
                child: BottomNavigationBar(
                    elevation: 20,
                    currentIndex:
                        _selectedIndex, //context.watch<NavigationCubit>().state.selectedIndex,
                    selectedItemColor: primaryColor,
                    selectedLabelStyle:
                        TextStyle(color: primaryColor, fontSize: 12),
                    type: BottomNavigationBarType.fixed,
                    // onTap: (index) => context.read<NavigationCubit>().changeIndex(index),
                    onTap: _onItemTapped,
                    items: bottmNavigationItemData.map((e) {
                      return BottomNavigationBarItem(
                        activeIcon: e.label == 'Connect'
                            ? FaIcon(
                                e.icon,
                                size: 28,
                                color: primaryColor,
                              )
                            : Icon(
                                e.icon,
                                size: 28,
                                color: primaryColor,
                              ),
                        icon: Icon(
                          e.icon,
                          size: 28,
                          color: Colors.grey,
                        ),
                        label: e.label,
                      );
                    }).toList()),
              )),
        ),
      ),
    );
  }
}
