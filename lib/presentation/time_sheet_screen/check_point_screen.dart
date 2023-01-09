import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sgt/presentation/shift_details_screen/clock_in_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/widgets/check_point_model.dart';
import '../../utils/const.dart';
import '../qr_screen/chack_points_scanning_screen.dart';
import '../settings_screen/cubit/toggle_switch/toggleswitch_cubit.dart';
import '../shift_details_screen/clock_out_screen.dart';
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: Text(
            'Checkpoints',
            style: TextStyle(color: primaryColor),
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
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const ClockInScreen();
                  }));
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
            //   Padding(
            //     padding: const EdgeInsets.only(right: 15.0, top: 10),
            //     child: Column(
            //       children: [
            //         FlutterSwitch(
            //           switchBorder: Border.all(
            //             color: primaryColor,
            //             width: 2.0.w,
            //           ),
            //           activeColor: primaryColor,
            //           inactiveColor: white,
            //           inactiveToggleColor: primaryColor,
            //           width: 40.0.w,
            //           height: 20.0.h,
            //           toggleSize: 17.0.sp,
            //           value: BlocProvider.of<ToggleSwitchCubit>(context,
            //                   listen: true)
            //               .state
            //               .isSwitched,
            //           borderRadius: 30.0,
            //           padding: 2.0,
            //           onToggle: (val) {
            //             BlocProvider.of<ToggleSwitchCubit>(context)
            //                 .changingToggleSwitch();
            //           },
            //         ),
            //         SizedBox(
            //           height: 2,
            //         ),
            //         context.watch<ToggleSwitchCubit>().state.isSwitched
            //             ? Text(
            //                 "List View",
            //                 style: TextStyle(color: primaryColor, fontSize: 12),
            //               )
            //             : Text(
            //                 "Map View",
            //                 style: TextStyle(color: primaryColor, fontSize: 12),
            //               )
            //       ],
            //     ),
            //   ),
          ],
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //       border: Border.all(color: primaryColor),
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Column(
              //     children: [
              //       Container(
              //         width: 348,
              //         height: 30,
              //         padding: EdgeInsets.symmetric(vertical: 7),
              //         decoration: BoxDecoration(
              //             color: primaryColor,
              //             borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(10),
              //               topRight: Radius.circular(10),
              //             )),
              //         child: Center(
              //           child: Text(
              //             'Your Shift Time',
              //             style: TextStyle(color: white),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         width: 348,
              //         height: 37,
              //         decoration: BoxDecoration(
              //             color: white,
              //             borderRadius: BorderRadius.circular(10)),
              //         child: Center(
              //             child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Text(
              //               '12 Seconds   :   15 Minutes   :   2 Hours',
              //               style: TextStyle(color: primaryColor),
              //             )
              //           ],
              //         )),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 13,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const ClockOutScreen()));
              //   },
              //   child: Container(
              //     width: 200,
              //     height: 33,
              //     decoration: BoxDecoration(
              //         color: primaryColor,
              //         borderRadius: BorderRadius.circular(6)),
              //     child: Center(
              //       child: Text(
              //         'Clock Out',
              //         style: TextStyle(color: white, fontSize: 13),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 25,
              // ),
              context.watch<ToggleSwitchCubit>().state.isSwitched
                  ? CheckPointMapScreen()
                  : CheckPointWidget(),
              // : Container(
              //     margin: EdgeInsets.only(left: 20.w),
              //     height: 105 * checkpointData.length.toDouble(),
              //     child: ListView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       itemCount: checkpointData.length,
              //       itemBuilder: (context, index) {
              //         return InkWell(
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) =>
              //                         const CheckPointScanningScreen()));
              //           },
              //           child: CheckPointWidget(
              //             title: checkpointData[index].title,
              //             imageUrl: checkpointData[index].imageUrl,
              //             iscompleted: checkpointData[index].isCompleted,
              //           ),
              //         );
              //       },
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
