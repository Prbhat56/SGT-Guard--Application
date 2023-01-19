import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/theme/custom_theme.dart';

class ApplyLeaveSuccess extends StatefulWidget {
  const ApplyLeaveSuccess({super.key});

  @override
  State<ApplyLeaveSuccess> createState() => _ApplyLeaveSuccessState();
}

class _ApplyLeaveSuccessState extends State<ApplyLeaveSuccess> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: SvgPicture.asset(
            'assets/green_tick.svg',
            height: 66,
          )),
          SizedBox(
            height: 15,
          ),
          Text('Sent\nSuccessfully',
              textAlign: TextAlign.center,
              style: CustomTheme.blackTextStyle(25)),
          SizedBox(
            height: 20,
          ),
          Text('Wait for approval!', style: CustomTheme.blackTextStyle(17))
        ],
      )),
    );
  }
}
