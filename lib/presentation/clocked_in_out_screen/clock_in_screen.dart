import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';
import 'clock_out_error_screen.dart';
import '../shift_details_screen/widgets/time_details_widget.dart';
import '../shift_details_screen/widgets/time_stamp_widget.dart';

class ClockInScreen extends StatefulWidget {
  const ClockInScreen({super.key});

  @override
  State<ClockInScreen> createState() => _ClockInScreenState();
}

final imageUrl =
    'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

class _ClockInScreenState extends State<ClockInScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Clocked In'),
        body: Center(
          child: Column(children: [
            const SizedBox(height: 25),
            SvgPicture.asset('assets/green_tick.svg'),
            const SizedBox(height: 10),
            Text(
              'You are currently clocked in\n and ready to go!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: primaryColor),
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, seconderyColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: 300.w,
                  decoration: CustomTheme.clockInCardStyle,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(height: 16),
                    CustomCircularImage.getCircularImage(
                        imageUrl, false, 30, 0, 0),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Matheus Paolo',
                        style: CustomTheme.blackTextStyle(17)),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      'Greylock Security',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Property',
                      style: CustomTheme.blueTextStyle(15, FontWeight.w400),
                    ),
                    const SizedBox(height: 6),
                    Text('Rivi Properties',
                        style: CustomTheme.blackTextStyle(15)),
                    const SizedBox(height: 6),
                    const Text(
                      'Guard Post Duties',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Center(child: TimeDetailsWidget(isClockOutScreen: false)),
                    const SizedBox(height: 6),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(color: primaryColor),
                    ),
                    const SizedBox(height: 20),
                    TimeStampWidget(),
                    const SizedBox(height: 30),
                    CupertinoButton(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(13),
                        child: Text(
                          'Checkpoints',
                          style: TextStyle(color: white, fontSize: 17),
                        ),
                        onPressed: () {
                          screenNavigator(context, CheckPointScreen());
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 57,
            ),
            CustomButtonWidget(
                buttonTitle: 'Clock Out',
                onBtnPress: () {
                  screenNavigator(context, ClockOutErrorScreen());
                }),
          ]),
        ),
      ),
    );
  }
}
