import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';

class UpcomingShiftDetailsScreen extends StatefulWidget {
  Shift shifts;
  UpcomingShiftDetailsScreen({super.key, required this.shifts});

  @override
  State<UpcomingShiftDetailsScreen> createState() => _UpcomingShiftDetailsScreenState();
}

class _UpcomingShiftDetailsScreenState extends State<UpcomingShiftDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Shift details'),
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shift Timing',
                style: CustomTheme.blueTextStyle(17, FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.shifts.dateText.toString(),
                // 'Monday, October 24',
                // shifts
                style: CustomTheme.blackTextStyle(17),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                // '10:00 AM ~ 4:00 PM',
                widget.shifts.clockIn.toString()+'~'+widget.shifts.clockOut.toString(),
                style: CustomTheme.greyTextStyle(13),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guard',
                        style: CustomTheme.blueTextStyle(17, FontWeight.w400),
                      ),
                      Text(
                        // 'Matheus Paolo',
                        widget.shifts.guardDetails!.firstName.toString()+''+widget.shifts.guardDetails!.lastName.toString(),
                        style: CustomTheme.blackTextStyle(17),
                      ),
                      Text(
                        // 'Executive Protection',
                        widget.shifts.guardDetails!.guardPosition.toString(),
                        style: CustomTheme.greyTextStyle(13),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CustomCircularImage.getCircularImage(
                       'https://sgt-inhouse.myclientdemo.us/uploads/guard/',widget.shifts.guardDetails!.avatar.toString(),
                      // 'https://sgt-inhouse.myclientdemo.us/uploads/guard/','10112231701458348.png',
                        false,
                        20,
                        0,
                        0),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Property',
                style: CustomTheme.blueTextStyle(17, FontWeight.w400),
              ),
              Text(
                // 'Rivi Properties',
                widget.shifts.propertyName.toString(),
                style: CustomTheme.blackTextStyle(17),
              ),
              Text(
                'Guard Post Duties',
                style: CustomTheme.greyTextStyle(13),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Job Details',
                style: CustomTheme.blueTextStyle(17, FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 10),
                child: Text(
                  widget.shifts.clockInDesc.toString(), //temporary basis
                  // 'Lorem ipsum dolor sit amet, duo habemus fuisset epicuri ei. No sit tempor populo prodesset, ad cum dicta repudiare. Ex eos probo maluisset, invidunt deseruisse consectetuer id vel, convenire comprehensam et nec. Dico facilisis ut has, quo homero nostro menandri id. Graeco nusquam splendide et vim.',
                  style: CustomTheme.blackTextStyle(13),
                ),
              ),
              SizedBox(
                height: 200.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
