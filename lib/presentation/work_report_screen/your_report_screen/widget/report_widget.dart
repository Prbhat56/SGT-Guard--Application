import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/custom_theme.dart';
import '../../../widgets/custom_circular_image_widget.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({super.key});
  final imageUrl =
      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55 * 2,
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      CustomCircularImage.getCircularImage(
                          '',imageUrl, false, 20, 0, 0),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Report title',
                            style:
                                CustomTheme.blueTextStyle(15, FontWeight.w400),
                          ),
                          Text(
                            'report_type'.tr,
                            style: CustomTheme.blackTextStyle(12),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: CustomTheme.seconderyColor,
                )
              ],
            );
          }),
    );
  }
}
