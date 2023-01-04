import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/time_sheet_screen/check_point_screen.dart';
import '../../utils/const.dart';
import '../cubit/timer_on/timer_on_cubit.dart';

class ClockOutScreen extends StatefulWidget {
  const ClockOutScreen({super.key});

  @override
  State<ClockOutScreen> createState() => _ClockOutScreenState();
}

class _ClockOutScreenState extends State<ClockOutScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 120,
            ),
            Icon(
              Icons.error,
              color: Color.fromARGB(255, 210, 29, 16),
              size: 45,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'You have not completed all checkpoints!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            SizedBox(
              height: 80.h,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total Time:',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '6',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Hours',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '12',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Minutes',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Completed Checkpoints:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '4',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Remaining Checkpoints:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '3',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            Text(
              'You want to clock out without completing your duty?',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            CupertinoButton(
                color: seconderyColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 140, vertical: 20),
                child: Text(
                  'Back',
                  style: TextStyle(color: primaryColor, fontSize: 17),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
                color: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 113.w, vertical: 20),
                child: Text(
                  'Clock Out',
                  style: TextStyle(color: white, fontSize: 17),
                ),
                onPressed: () {
                  context.read<TimerOnCubit>().turnOffTimer();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CheckPointScreen();
                  }));
                }),
          ]),
        ),
      ),
    );
  }
}
