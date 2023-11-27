import 'package:flutter/material.dart';
import '../../../../theme/custom_theme.dart';
import '../../../widgets/custom_circular_image_widget.dart';

class RecentReportCardWidget extends StatelessWidget {
  const RecentReportCardWidget({super.key});
  final imageUrl =
      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recents Reports',
            style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 120,
          child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 105,
                  margin: EdgeInsets.only(right: 14),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: CustomTheme.seconderyColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    CustomCircularImage.getCircularImage(
                        '',imageUrl, false, 20, 0, 0),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Maintenance\nReport 12',
                      textAlign: TextAlign.center,
                      style: CustomTheme.blueTextStyle(10, FontWeight.w400),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 17,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'View',
                        style: TextStyle(color: CustomTheme.white, fontSize: 7),
                      ),
                    )
                  ]),
                );
              }),
        )
      ],
    );
  }
}
