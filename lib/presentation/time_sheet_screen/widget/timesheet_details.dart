import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/property_details_screen/cubit/showmore/showmore_cubit.dart';
import 'package:sgt/presentation/property_details_screen/widgets/job_details_widget.dart';
import 'package:sgt/presentation/property_details_screen/widgets/map_card_widget.dart';
import 'package:sgt/presentation/time_sheet_screen/model/timesheet_details_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/your_report_screen.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TimeSheetDetailsWidet extends StatefulWidget {
  String propId = '';
  String propName = '';
  TimeSheetDetailsWidet(
      {super.key, required this.propId, required this.propName});

  @override
  State<TimeSheetDetailsWidet> createState() => _TimeSheetDetailsWidetState();
}

TimeSheetData detailsData = TimeSheetData();
String imgBaseUrl = '';

class _TimeSheetDetailsWidetState extends State<TimeSheetDetailsWidet> {
  Future<TimeSheetDetailsModel> getTimeSheetList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + 'guard/duty-details/${widget.propId}';
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    if (response.statusCode == 201) {
      final TimeSheetDetailsModel responseModel =
          timeSheetDetailsModelFromJson(response.body);
      detailsData = responseModel.data!;

      imgBaseUrl = responseModel.propertyImageBaseUrl ?? '';
      return responseModel;
    } else {
      return TimeSheetDetailsModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: widget.propName),
      body: FutureBuilder(
        future: getTimeSheetList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.all(15),
                      height: 140,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: seconderyMediumColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                  imageUrl: (imgBaseUrl.toString() +
                                      '/' +
                                      detailsData
                                          .propertyAvatars!.first.propertyAvatar
                                          .toString()),
                                  fit: BoxFit.fill,
                                  width: 100,
                                  height: 100,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                        strokeCap: StrokeCap.round,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        'assets/sgt_logo.jpg',
                                        fit: BoxFit.fill,
                                      )),
                            ),
                            radius: 50,
                            backgroundColor: Colors.transparent,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              top: 40,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.propName,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    'Shift Time: ${detailsData.shifts!.isEmpty ? null : detailsData.shifts!.first.clockIn.toString()} - ${detailsData.shifts!.isEmpty ? null : detailsData.shifts!.first.clockOut.toString()}',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldHeaderWidget(title: 'Completed Checkpoints:'),
                        TextFieldHeaderWidget(title: '5')
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldHeaderWidget(title: 'Missed Checkpoints:'),
                        TextFieldHeaderWidget(title: '5')
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldHeaderWidget(title: 'Clock In Time:'),
                        TextFieldHeaderWidget(
                            title: detailsData.shifts!.isEmpty
                                ? ''
                                : detailsData.shifts!.first.clockIn.toString())
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldHeaderWidget(title: 'Clock Out Time:'),
                        TextFieldHeaderWidget(
                            title: detailsData.shifts!.isEmpty
                                ? ''
                                : detailsData.shifts!.first.clockOut.toString())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        screenNavigator(context, YourReportScreen());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: primaryColor)),
                        child: Text(
                          "View Reports",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 2.0,
                    child: DecoratedBox(
                      decoration:
                          BoxDecoration(color: Colors.grey.withAlpha(50)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldHeaderWidget(title: 'Job Details'),
                            const SizedBox(height: 10),
                            JobDetailsWidget(jobDetails: detailsData.jobDetails)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 2.0,
                    child: DecoratedBox(
                      decoration:
                          BoxDecoration(color: Colors.grey.withAlpha(50)),
                    ),
                  ),
                  //const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldHeaderWidget(title: 'Description'),
                        const SizedBox(height: 10),
                        // Text(
                        //   detailsData.propertyDescription.toString(),
                        //   maxLines:
                        //       context.watch<ShowmoreCubit>().state.showmore
                        //           ? 1000
                        //           : 3,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //   ),
                        // ),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 300,
                                  child: Text(
                                    detailsData.propertyDescription.toString(),
                                    maxLines: context
                                            .watch<ShowmoreCubit>()
                                            .state
                                            .showmore
                                        ? 1000
                                        : 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                context.watch<ShowmoreCubit>().state.showmore
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          context
                                              .read<ShowmoreCubit>()
                                              .showMore();
                                          print(context
                                              .read<ShowmoreCubit>()
                                              .state
                                              .showmore);
                                        },
                                        child: Text(
                                          'more',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: primaryColor),
                                        ),
                                      )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 2.0,
                    child: DecoratedBox(
                      decoration:
                          BoxDecoration(color: Colors.grey.withAlpha(50)),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldHeaderWidget(title: 'Location'),
                        const SizedBox(height: 10),
                        Text(
                          detailsData.location.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 20),
                        MapCardWidget(
                          currentlocation: LatLng(
                              double.parse(detailsData.latitude.toString())
                                  .toDouble(),
                              double.parse(detailsData.longitude.toString())
                                  .toDouble()),
                        ), //showing map card
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
