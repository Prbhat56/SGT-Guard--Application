import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/check_points_list.dart';
import 'package:sgt/presentation/work_report_screen/work_report_screen.dart';
import '../../../helper/navigator_function.dart';
import '../../../utils/const.dart';
import '../../qr_screen/scanning_screen.dart';

//model class for customicon
class CustomIconsDataModel {
  final String iconUrl;
  final String title;
  final Widget widget;
  CustomIconsDataModel({
    required this.iconUrl,
    required this.title,
    required this.widget,
  });
}

//data list of customicon
List<CustomIconsDataModel> customIconsData = customIconsData = [
  CustomIconsDataModel(
      iconUrl: 'assets/qr1.svg', title: 'scan_qr'.tr, widget: ScanningScreen()),
  CustomIconsDataModel(
      iconUrl: 'assets/map.svg',
      title: 'checkpoint'.tr,
      widget: CheckPointListsScreen(
        // checkPoint: [],
        imageBaseUrl: '',
      )),
  CustomIconsDataModel(
      iconUrl: 'assets/plus.svg', title: 'report'.tr, widget: WorkReportScreen()),
];

//custom-icon widget
class CustomIconWidget extends StatelessWidget {
  CustomIconWidget(
      {super.key,
      required this.iconUrl,
      required this.title,
      required this.widget,
      this.checkpoint,
      this.imgUrl});
  final String iconUrl;
  final String title;
  final Widget widget;
  List<CheckPoint>? checkpoint;
  final String? imgUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            screenNavigator(context, widget);
          },
          child: Container(
            height: 32,
            width: 32,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey)),
            child: SvgPicture.asset(
              iconUrl,
              height: 20,
              width: 20,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: primaryColor),
        ),
      ],
    );
  }
}
