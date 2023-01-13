import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/presentation/clocked_in_out_screen/clock_in_screen.dart';
import '../../helper/navigator_function.dart';
import '../../utils/const.dart';
import '../settings_screen/cubit/toggle_switch/toggleswitch_cubit.dart';
import '../widgets/custom_appbar_widget.dart';
import '../time_sheet_screen/check_point_map_screen.dart';
import 'widgets/check_points_widget.dart';

class CheckPointScreen extends StatefulWidget {
  const CheckPointScreen({super.key});

  @override
  State<CheckPointScreen> createState() => _CheckPointScreenState();
}

class _CheckPointScreenState extends State<CheckPointScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          appbarTitle: 'Checkpoints',
          widgets: [
            InkWell(
                onTap: () {
                  screenNavigator(context, ClockInScreen());
                },
                child: SvgPicture.asset('assets/clock.svg')),
            IconButton(
                onPressed: () {
                  BlocProvider.of<ToggleSwitchCubit>(context)
                      .changingToggleSwitch();
                },
                icon: Icon(
                  Icons.map,
                  color: primaryColor,
                ))
          ],
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              context.watch<ToggleSwitchCubit>().state.isSwitched
                  ? CheckPointMapScreen()
                  : CheckPointWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
