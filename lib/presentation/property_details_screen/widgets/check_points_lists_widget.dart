// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../../utils/const.dart';

class CheckPointListsWidget extends StatelessWidget {
  const CheckPointListsWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    // required this.iscompleted,
    required this.checkpointNo,
    required this.date,
  }) : super(key: key);
  final String title;
  final String imageUrl;
  // final String iscompleted;
  final String date;
  final int checkpointNo;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCircularImage.getCircularImage('',imageUrl, false, 35, 0, 0),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomTheme.blackTextStyle(15),
                ),
                Text(
                  date,
                  style: CustomTheme.blackTextStyle(13),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 10,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      // Text(iscompleted,
                      //     style:
                      //         CustomTheme.blueTextStyle(10, FontWeight.w400)),
                      VerticalDivider(
                        color: primaryColor,
                      ),
                      // Text("$checkpointNo Checkpoints",
                      //     style:
                      //         CustomTheme.blueTextStyle(10, FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: primaryColor,
        )
      ],
    );
  }
}
