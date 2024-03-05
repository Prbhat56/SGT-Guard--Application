import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/timesheet_details.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/utils/const.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timeSheet_model.dart';

class CompletedWidgetTab extends StatefulWidget {
  List<Completed> completedData = [];
  String imageBaseUrl;
  CompletedWidgetTab(
      {super.key, required this.completedData, required this.imageBaseUrl});

  @override
  State<CompletedWidgetTab> createState() => _CompletedWidgetTabState();
}

class _CompletedWidgetTabState extends State<CompletedWidgetTab> {
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
    return widget.completedData.isEmpty
        ? SizedBox(
            child: Center(
              child: Text(
                'No Complete Timesheet Found',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Container(
              //       width: 120,
              //       child: Image.asset(
              //         'assets/no_upcoming_shifts.png',
              //         fit: BoxFit.contain,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 24,
              //     ),
              //     Text(
              //       'No Completed Shifts',
              //       style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color:Colors.grey.withOpacity(0.6)),
              //     ),
              //   ],
              // ),
            ),
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: widget.completedData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        screenNavigator(
                            context,
                            TimeSheetDetailsWidget(
                              shiftDate:widget.completedData[index].shifts!.first.date.toString(),
                              shiftId:widget.completedData[index].shifts!.first.id.toString(),
                              propId: widget.completedData[index].id.toString(),
                              propName: widget.completedData[index].propertyName
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
                                  widget.completedData[index].propertyAvatars!
                                      .first.propertyAvatar
                                      .toString(),
                                  false)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.completedData[index].propertyName
                                      .toString(),
                                  style: const TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  widget.completedData[index].shifts!.first
                                              .date !=
                                          ""
                                      ? DateFormat.MMMEd().format(
                                          DateTime.parse(widget
                                              .completedData[index]
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
                                  //'${widget.completedData[index].shifts!.first.clockIn} - ${widget.completedData[index].shifts!.first.clockOut}',
                                  '${widget.completedData[index].shifts!.isEmpty ? "" : widget.completedData[index].shifts!.first.clockIn.toString()} - ${widget.completedData[index].shifts!.isEmpty ? "" : widget.completedData[index].shifts!.first.clockOut.toString()}',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            getDifference(
                                    '${widget.completedData[index].shifts!.isEmpty ? "" : widget.completedData[index].shifts!.first.clockIn}',
                                    '${widget.completedData[index].shifts!.isEmpty ? "" : widget.completedData[index].shifts!.first.clockOut}')
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

/*FutureBuilder<TimeSheetModel>(
        future: getTimeSheetList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.completed!.length,
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
                                  child:
                                      CustomCircularImage.getlgCircularImage(
                                          snapshot.data!.toString(),
                                          snapshot.data!.completed![index]
                                              .shifts![index]
                                              .toString(),
                                          // '',
                                          // '',
                                          false
                                          // '',dummytimeSheetData[index].imageUrl, false
                                          )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    snapshot.data!.completed![index]
                                        .shifts![index]
                                        .toString(),
                                    // '',
                                    // dummytimeSheetData[index].title,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    snapshot.data!.completed![index]
                                        .shifts![index]
                                        .toString(),
                                    // 'date',
                                    // dummytimeSheetData[index].date,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data!.completed![index]
                                        .shifts![index].clockIn
                                        .toString(),
                                    // '',
                                    // dummytimeSheetData[index].time,
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              // Text(
                              //   "${dummytimeSheetData[index].shiftTime} Ago",
                              //   style: TextStyle(fontSize: 11, color: primaryColor),
                              // ),
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
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        }); */