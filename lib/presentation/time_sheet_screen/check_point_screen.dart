import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sgt/presentation/time_sheet_screen/widgets/check_point_model.dart';
import '../../utils/const.dart';
import '../qr_screen/qr_screen.dart';
import '../settings_screen/cubit/toggle_switch/toggleswitch_cubit.dart';
import 'check_point_map_screen.dart';
import 'widgets/check_points_widget.dart';

class CheckPointScreen extends StatefulWidget {
  const CheckPointScreen({super.key});

  @override
  State<CheckPointScreen> createState() => _CheckPointScreenState();
}

class _CheckPointScreenState extends State<CheckPointScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Checkpoints',
          style: TextStyle(color: black),
          textScaleFactor: 1.0,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: FlutterSwitch(
              switchBorder: Border.all(
                color: primaryColor,
                width: 2.0.w,
              ),
              activeColor: primaryColor,
              inactiveColor: white,
              inactiveToggleColor: primaryColor,
              width: 40.0.w,
              height: 20.0.h,
              toggleSize: 17.0.sp,
              value: BlocProvider.of<ToggleSwitchCubit>(context, listen: true)
                  .state
                  .isSwitched,
              borderRadius: 30.0,
              padding: 2.0,
              onToggle: (val) {
                BlocProvider.of<ToggleSwitchCubit>(context)
                    .changingToggleSwitch();
              },
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const CheckPointMapScreen()));
          //   },
          //   icon: Icon(
          //     Icons.map,
          //     color: black,
          //   ),
          // )
        ],
      ),
      backgroundColor: white,
      body: BlocProvider.of<ToggleSwitchCubit>(context, listen: true)
              .state
              .isSwitched
          ? CheckPointMapScreen()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView.builder(
                itemCount: checkpointData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QrScreen()));
                    },
                    child: CheckPointWidget(
                      title: checkpointData[index].title,
                      imageUrl: checkpointData[index].imageUrl,
                      iscompleted: checkpointData[index].isCompleted,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
