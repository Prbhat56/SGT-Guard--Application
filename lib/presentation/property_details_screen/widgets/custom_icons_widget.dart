// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../helper/navigator_function.dart';
import '../../../utils/const.dart';
import '../../qr_screen/qr_screen.dart';

//model class for customicon
class CustomIconsDataModel {
  final String iconUrl;
  final String title;
  CustomIconsDataModel({
    required this.iconUrl,
    required this.title,
  });
}

//data list of customicon
List<CustomIconsDataModel> customIconsData = [
  CustomIconsDataModel(iconUrl: 'assets/qr1.svg', title: 'Scan QR'),
  CustomIconsDataModel(iconUrl: 'assets/map.svg', title: 'Checkpoints'),
  CustomIconsDataModel(iconUrl: 'assets/plus.svg', title: 'Report'),
];

//custom-icon widget
class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget(
      {super.key, required this.iconUrl, required this.title});
  final String iconUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            screenNavigator(context, QrScreen());
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
