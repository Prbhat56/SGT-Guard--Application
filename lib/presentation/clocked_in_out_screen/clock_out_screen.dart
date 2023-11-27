import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/clocked_in_out_screen/widget/clock_out_total_time_widget.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';
import '../home.dart';
import '../shift_details_screen/widgets/time_details_widget.dart';
import 'widget/check_point_count_widget.dart';

class ClockOutScreen extends StatefulWidget {
  const ClockOutScreen({super.key});

  @override
  State<ClockOutScreen> createState() => _ClockOutScreenState();
}

final imageUrl =
    'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

class _ClockOutScreenState extends State<ClockOutScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Clocked Out'),
        body: Center(
          child: Column(children: [
            const SizedBox(height: 25),
            SvgPicture.asset('assets/green_tick.svg'),
            const SizedBox(height: 10),
            Text(
              'You are currently clocked\n out from shift!',
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
                        '',imageUrl, false, 30, 0, 0),
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
                    Center(child: TimeDetailsWidget(isClockOutScreen: true)),
                    const SizedBox(height: 6),
                    Center(
                        child: CheckPointCountWidget(
                      completedCheckPoint: '13',
                      remainningCheckPoint: '0',
                    )),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(color: primaryColor),
                    ),
                    const SizedBox(height: 20),
                    Center(child: TotalTimeWidget()),
                    const SizedBox(height: 20),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 105,
            ),
            CustomButtonWidget(
                buttonTitle: 'Home',
                onBtnPress: () {
                  screenReplaceNavigator(context, Home());
                }),
          ]),
        ),
      ),
    );
  }
}
