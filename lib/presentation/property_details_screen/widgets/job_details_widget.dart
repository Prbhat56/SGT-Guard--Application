import 'package:flutter/material.dart';
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
  JobDetailsModel(title: 'Gaurd Name:', titleValue: ' Matheus Paolo'),
  JobDetailsModel(title: 'Position:', titleValue: ' Superviser'),
  JobDetailsModel(title: 'Shift Time:', titleValue: ' 10:00 AM - 04:00 PM'),
];

class JobDetailsWidget extends StatelessWidget {
  const JobDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30 * jobData.length.toDouble(),
      child: ListView.builder(
          itemCount: jobData.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyleWidget1(
                  title: jobData[index].title,
                  titleValue: jobData[index].titleValue,
                  fontsize: 15,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            );
          }),
    );
  }
}
