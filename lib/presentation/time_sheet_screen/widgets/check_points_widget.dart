// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/const.dart';
import '../../qr_screen/chack_points_scanning_screen.dart';
import 'check_point_model.dart';

class CheckPointWidget extends StatelessWidget {
  const CheckPointWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105 * checkpointData.length.toDouble(),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: checkpointData.length,
          itemBuilder: (context, index) {
            print(checkpointData[index].isCompleted);
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const CheckPointScanningScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: grey,
                            backgroundImage: NetworkImage(
                              checkpointData[index].imageUrl,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              checkpointData[index].title,
                              style: const TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              checkpointData[index].date,
                              style: const TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              checkpointData[index].isCompleted,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: checkpointData[index].isCompleted ==
                                          'Completed'
                                      ? primaryColor
                                      : Colors.grey),
                            ),
                          ],
                        ),
                        Spacer(),
                        checkpointData[index].isCompleted == 'Completed'
                            ? SvgPicture.asset(
                                'assets/green_tick.svg',
                                width: 27,
                              )
                            : Container(),
                      ]),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            );
          }),
    );

    // return Column(
    //   children: [
    //     Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Container(
    //           margin: const EdgeInsets.symmetric(vertical: 10),
    //           decoration: BoxDecoration(
    //             color: grey,
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //           height: 62,
    //           width: 62,
    //           child: Image.network(
    //             fit: BoxFit.contain,
    //             imageUrl,
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         SizedBox(
    //           width: 138.w,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 title,
    //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    //               ),
    //               Text(
    //                 iscompleted,
    //                 style: const TextStyle(fontSize: 15, color: Colors.grey),
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 50,
    //         ),
    //         IconButton(
    //             onPressed: () {},
    //             icon: iscompleted == 'Complete'
    //                 ? Icon(
    //                     Icons.check_circle,
    //                     color: greenColor,
    //                   )
    //                 : const Icon(
    //                     Icons.arrow_forward_ios,
    //                     color: Colors.grey,
    //                   )),
    //       ],
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 90.0),
    //       child: Divider(
    //         color: Colors.grey,
    //       ),
    //     )
    //   ],
    // );
  }
}
