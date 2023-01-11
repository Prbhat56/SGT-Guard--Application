import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/account_screen/account_screen.dart';
import 'package:sgt/presentation/connect_screen/connect_screen.dart';
import 'package:sgt/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:sgt/presentation/cubit/timer_on/timer_on_cubit.dart';
import 'package:sgt/presentation/notification_screen/notification_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/time_sheet_screen.dart';
import 'package:sgt/presentation/timer/timer.dart';
import 'package:sgt/presentation/widgets/should_pop_alert_dialog.dart';
import 'home_screen/home_screen.dart';
import 'widgets/bottom_navigation_bar_widget.dart';

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
                    context.watch<NavigationCubit>().state.selectedIndex],
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
            bottomNavigationBar: BottomNavigationBarItemList(),
          ),
        ),
      ),
    );
  }
}
