// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/property_details_screen/model/checkPointsList_model.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../../utils/const.dart';

class CheckPointListsWidget extends StatefulWidget {
  CheckPointListsWidget({
    super.key,
    this.title,
    this.imageUrl,
    // this.iscompleted,
    this.imageBaseUrl,
    this.checkpointNo,
    this.date,
    required this.time,
  });
  String? title;
  String? imageUrl;
  String? imageBaseUrl;
  // String iscompleted;
  String? date;
  String time;
  int? checkpointNo;

  @override
  State<CheckPointListsWidget> createState() => _CheckPointListsWidgetState();
}

class _CheckPointListsWidgetState extends State<CheckPointListsWidget> {
  @override
  Widget build(BuildContext context) {
    // print("=============> ${widget.imageUrl}");
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.imageUrl == ''
                ? CircleAvatar(
                    radius: 35,
                    backgroundColor: grey,
                    backgroundImage: AssetImage('assets/sgt_logo.jpg'),
                  )
                : CustomCircularImage.getCircularImage(
                    widget.imageBaseUrl.toString(),
                    widget.imageUrl.toString(),
                    false,
                    35,
                    0,
                    0),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)
                    // style: CustomTheme.blackTextStyle(15),
                    ),
                Text(widget.time.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.normal)
                    // style: CustomTheme.blackTextStyle(15),
                    ),
                Text(
                  widget.date.toString(),
                  style: TextStyle(
                      color: CustomTheme.primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   height: 10,
                //   alignment: Alignment.center,
                //   child: Row(
                //     children: [
                //       Text(iscompleted,
                //           style:
                //               CustomTheme.blueTextStyle(10, FontWeight.w400)),
                //       VerticalDivider(
                //         color: primaryColor,
                //       ),
                //       Text("$checkpointNo Checkpoints",
                //           style:
                //               CustomTheme.blueTextStyle(10, FontWeight.w400)),
                //     ],
                //   ),
                // ),
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
