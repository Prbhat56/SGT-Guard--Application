import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/widgets/timeline_details_widget.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timeSheet_model.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/timesheet_details.dart';
import 'package:sgt/presentation/work_report_screen/checkpoint_report_screen.dart';
import '../../../utils/const.dart';
import '../../widgets/custom_circular_image_widget.dart';

class UpcomingWidgetTab extends StatefulWidget {
  List<Completed> upcomingData = [];
  String imageBaseUrl;
  UpcomingWidgetTab(
      {super.key, required this.upcomingData, required this.imageBaseUrl});

  @override
  State<UpcomingWidgetTab> createState() => _UpcomingWidgetTabState();
}

class _UpcomingWidgetTabState extends State<UpcomingWidgetTab> {
  getDifference(String date1, String date2) {
    var dt1 = DateFormat("HH:mm:ss").parse(date1);
    var dt2 = DateFormat("HH:mm:ss").parse(date2);
    Duration duration = dt2.difference(dt1).abs();
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours Hrs $minutes mins';
  }

  @override
  Widget build(BuildContext context) {
    return widget.upcomingData.isEmpty
        ? SizedBox(
            child: Center(
              child: Text(
                'No Upcoming Timesheet Found',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.upcomingData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print(widget.upcomingData[index].id.toString());
                        screenNavigator(
                            context,
                            TimeSheetDetailsWidet(
                              propId: widget.upcomingData[index].id.toString(),
                              propName: widget.upcomingData[index].propertyName
                                  .toString(),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: CustomCircularImage.getlgCircularImage(
                                  widget.imageBaseUrl,
                                  widget.upcomingData[index].propertyAvatars!
                                      .first.propertyAvatar
                                      .toString(),
                                  false)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.upcomingData[index].propertyName
                                      .toString(),
                                  style: const TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  widget.upcomingData[index].shifts!.first
                                              .date !=
                                          ""
                                      ? DateFormat.MMMEd().format(
                                          DateTime.parse(widget
                                              .upcomingData[index]
                                              .shifts!
                                              .first
                                              .date
                                              .toString()))
                                      : "No Date",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${widget.upcomingData[index].shifts!.first.clockIn}-${widget.upcomingData[index].shifts!.first.clockOut}',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            getDifference(
                                    widget.upcomingData[index].shifts!.first
                                        .clockIn
                                        .toString(),
                                    widget.upcomingData[index].shifts!.first
                                        .clockOut
                                        .toString())
                                .toString(),
                            style: TextStyle(fontSize: 11, color: primaryColor),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            });
  }
}

/**FutureBuilder<TimeSheetModel>(
        future: getTimeSheetList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            print(snapshot.data!.upcomming.toString());
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.upcomming!.length,
                // itemCount: snapshot.data!.activeData!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            screenNavigator(context, PropertyDetailsScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: CustomCircularImage.getlgCircularImage(
                                      '',
                                      // dummytimeSheetData[index].imageUrl,
                                      '',
                                      false)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    // dummytimeSheetData[index].title,
                                    '',
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    // dummytimeSheetData[index].date,
                                    '',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    // dummytimeSheetData[index].time,
                                    '',
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                // dummytimeSheetData[index].shiftTime,
                                '',
                                style: TextStyle(
                                    fontSize: 11, color: primaryColor),
                              ),
                            ]),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                });
          }
        }); */