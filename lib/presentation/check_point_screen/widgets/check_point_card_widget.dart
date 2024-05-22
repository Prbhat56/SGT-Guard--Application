import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';
import 'package:http/http.dart' as http;

//card data class
// class CardDetails {
//   final IconData icon;
//   final String data;
//   CardDetails({
//     required this.icon,
//     required this.data,
//   });
// }

// //list of card data
// List<CardDetails> data = [
//   CardDetails(icon: Icons.schedule_outlined, data: '6 Hours Duty'),
//   CardDetails(icon: Icons.edit_note_outlined, data: '13 Checkpoints'),
//   CardDetails(icon: Icons.person_outlined, data: 'Surveillance')
// ];

class CheckPointCardsWidget extends StatefulWidget {
  Property? property;
  String? propertyImageBaseUrl;
  List<Checkpoint>? checkPointLength;
  int? countdownseconds;
  CheckPointCardsWidget(
      {super.key,
      this.property,
      this.propertyImageBaseUrl,
      this.checkPointLength,
      this.countdownseconds});

  @override
  State<CheckPointCardsWidget> createState() => _CheckPointCardsWidgetState();
}

String formatSeconds(int seconds) {
  int hours = seconds ~/ 3600;
  int remainingSeconds = seconds % 3600;
  int minutes = remainingSeconds ~/ 60;
  int secondsOutput = remainingSeconds % 60;

  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = secondsOutput.toString().padLeft(2, '0');

  return '${hoursStr} Hrs ${minutesStr} Min ${secondsStr} Secs';
}

class _CheckPointCardsWidgetState extends State<CheckPointCardsWidget> {
  @override
  Widget build(BuildContext context) {
    int totalSeconds = widget.countdownseconds!;
    String formattedTime = formatSeconds(totalSeconds);
    return Container(
      height: 128,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 171, 171, 171),
            offset: Offset(0, 5),
            blurRadius: 20,
            spreadRadius: 0.1,
          ),
        ],
        border: Border.all(color: seconderyColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10.w,
          ),
          // widget.property!.propertyAvatars != null
          //     ? CircleAvatar(
          //         backgroundColor: grey,
          //         backgroundImage: NetworkImage(
          //             widget.propertyImageBaseUrl.toString() +
          //                 '' +
          //                 widget.property!.propertyAvatars!.first.propertyAvatar
          //                     .toString()))
          //     : CircleAvatar(
          //         backgroundColor: grey,
          //         backgroundImage: AssetImage('assets/sgt_logo.jpg')),
          // SizedBox(
          //   width: 10,
          // ),
          Expanded(
            child: Container(
              // height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                            // 'Rivi Properties',
                            widget.property!.propertyName.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: black)),
                      ),
                      Text(
                        // '1517 South Centelella',
                        widget.property!.type.toString(),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Route Name : ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: black)),
                      Text(
                        widget.checkPointLength!.first.route!.routeNumber
                            .toString(),
                        style: CustomTheme.blueTextStyle(12, FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('remaining_shift_time'.tr+': ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: black)),
                      Icon(
                        Icons.timer,
                        color: CustomTheme.primaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      widget.countdownseconds != 0
                          ? Text(
                              formattedTime,
                              // widget.countdownseconds.toString(),
                              style: CustomTheme.blueTextStyle(
                                  12, FontWeight.w400),
                            )
                          : Text(
                              "Shift Time Over",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.property!.shift!.totalDutyHours.toString()} Duty",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Icon(
                        Icons.edit_note,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.checkPointLength!.length.toString()}'+ 'checkpoint'.tr,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 45,
          ),
          // Container(
          //   height: 52,
          //   child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: data
          //           .map(
          //             (e) => Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 2),
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Icon(
          //                     e.icon,
          //                     color: Colors.grey,
          //                     size: 13,
          //                   ),
          //                   SizedBox(
          //                     width: 2,
          //                   ),
          //                   Text(
          //                     e.data,
          //                     style: CustomTheme.blackTextStyle(10),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           )
          //           .toList()),
          // )
        ],
      ),
    );
  }
}
