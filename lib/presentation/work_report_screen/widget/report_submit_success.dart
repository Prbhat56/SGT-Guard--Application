import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/theme/custom_theme.dart';

class ReportSubmitSuccess extends StatefulWidget {
  const ReportSubmitSuccess({super.key});

  @override
  State<ReportSubmitSuccess> createState() => _ReportSubmitSuccessState();
}

class _ReportSubmitSuccessState extends State<ReportSubmitSuccess> {
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
          Text('Done',
              textAlign: TextAlign.center,
              style: CustomTheme.blackTextStyle(25)),
          SizedBox(
            height: 20,
          ),
          Text('Report has been sent\n successfully!',
              textAlign: TextAlign.center,
              style: CustomTheme.blackTextStyle(17))
        ],
      )),
    );
  }
}
