import 'package:flutter/material.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../widgets/custom_text_widget.dart';

class JobDetailsModel {
  JobDetailsModel({
    required this.title,
    required this.titleValue,
  });
  final String title;
  final String titleValue;
}

List<JobDetailsModel> jobData = [
  JobDetailsModel(title: 'Guard Name:', titleValue: 'Matheus Paolo'),
  JobDetailsModel(title: 'Position:', titleValue: 'Superviser'),
  JobDetailsModel(title: 'Shift Time:', titleValue: ' 10:00 AM - 04:00 PM'),
];

class JobDetailsWidget extends StatefulWidget {
  JobDetailsWidget({super.key, required this.jobDetails});
  JobDetailsClass? jobDetails;

  @override
  State<JobDetailsWidget> createState() => _JobDetailsWidgetState();
}

class _JobDetailsWidgetState extends State<JobDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.jobDetails?.firstName.toString());
    return Container(
      height: 30 * jobData.length.toDouble(),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: jobData.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Guard Name: ', style: CustomTheme.blackTextStyle(15)),
                    Text(
                      widget.jobDetails!.firstName.toString() +
                          '' +
                          widget.jobDetails!.lastName.toString(),
                      style: CustomTheme.blueTextStyle(15, FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Position: ', style: CustomTheme.blackTextStyle(15)),
                    Text(
                      widget.jobDetails!.guardPosition.toString(),
                      style: CustomTheme.blueTextStyle(15, FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Shift Time: ', style: CustomTheme.blackTextStyle(15)),
                    Text(
                      widget.jobDetails!.shiftTime.toString(),
                      style: CustomTheme.blueTextStyle(15, FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // TextStyleWidget1(
                //   title: jobData[index].title,
                //   titleValue: jobData[index].titleValue,
                //   fontsize: 15,
                // ),
                SizedBox(
                  height: 5,
                ),
              ],
            );
          }),
    );
  }
}
