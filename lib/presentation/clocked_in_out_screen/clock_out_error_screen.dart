import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import '../../utils/const.dart';
import '../cubit/timer_on/timer_on_cubit.dart';
import 'clock_out_screen.dart';
import 'widget/check_point_count_widget.dart';
import 'widget/clock_out_total_time_widget.dart';

class ClockOutErrorScreen extends StatefulWidget {
  String? clockOutQrData;
  ClockOutErrorScreen({super.key, this.clockOutQrData});

  @override
  State<ClockOutErrorScreen> createState() => _ClockOutErrorScreenState();
}

class _ClockOutErrorScreenState extends State<ClockOutErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 120, left: 30, right: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  // Center(child: TotalTimeWidget()),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Center(
                  //     child: CheckPointCountWidget(
                  //   completedCheckPoint: '4',
                  //   remainningCheckPoint: '3',
                  // )),
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
                  CustomButtonWidget(
                      buttonTitle: 'Back',
                      btnColor: seconderyColor,
                      onBtnPress: () {
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButtonWidget(
                      buttonTitle: 'Clock Out',
                      onBtnPress: () {
                        context.read<TimerOnCubit>().state.istimerOn
                            ? context.read<TimerOnCubit>().turnOffTimer()
                            : null ;
                        screenNavigator(context, ClockOutScreen(clockOutQrData:widget.clockOutQrData));
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
