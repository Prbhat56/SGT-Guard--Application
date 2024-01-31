import 'package:flutter/material.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timesheet_details_model.dart';
import 'package:sgt/theme/custom_theme.dart';

class JobDetailsWidget extends StatefulWidget {
  JobDetails? jobDetails;
  JobDetailsWidget({
    super.key,
    required this.jobDetails,
  });

  @override
  State<JobDetailsWidget> createState() => _JobDetailsWidgetState();
}

class _JobDetailsWidgetState extends State<JobDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Guard Name: ', style: CustomTheme.blackTextStyle(15)),
            Text(
              "${widget.jobDetails!.firstName.toString()} ${widget.jobDetails!.lastName.toString()}",
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
      ],
    );
  }
}
