import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/time_sheet_screen/model/assigned_propertieslist_modal.dart';
import 'package:sgt/presentation/time_sheet_screen/model/today_active_model.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen/emergency_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/general_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/maintenance_report_screen.dart';
import 'package:sgt/presentation/work_report_screen/parking_report_screen.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class PropertiesListPicker extends StatefulWidget {
  final VoidCallback onCallback;
  List<AssignedDatum> reportDatum = [];
  String? imageBaseUrl;
  PropertiesListPicker(
      {super.key,
      required this.onCallback,
      required this.reportDatum,
      required this.imageBaseUrl});

  @override
  State<PropertiesListPicker> createState() => _PropertiesListPickerState();
}

class _PropertiesListPickerState extends State<PropertiesListPicker> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.reportDatum.length == 1 ? 72 : 3 * 72,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[4]),
      child: GlowingOverscrollIndicator(
        color: CustomTheme.primaryColor,
        axisDirection: AxisDirection.down,
        child: RawScrollbar(
          minThumbLength: 40,
          thumbColor: CustomTheme.primaryColor,
          radius: Radius.circular(20),
          thickness: 5,
          child: ListView.builder(
            itemCount: widget.reportDatum.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  GeneralReportScreen.of(context)?.propertyName =
                      widget.reportDatum[index].propertyName.toString();
                  GeneralReportScreen.of(context)?.propertyId =
                      widget.reportDatum[index].id.toString();

                  MaintenanceReportScreen.of(context)?.propertyName =
                      widget.reportDatum[index].propertyName.toString();
                  MaintenanceReportScreen.of(context)?.propertyId =
                      widget.reportDatum[index].id.toString();

                  ParkingReportScreen.of(context)?.propertyName =
                      widget.reportDatum[index].propertyName.toString();
                  ParkingReportScreen.of(context)?.propertyId =
                      widget.reportDatum[index].id.toString();

                  EmergencyReportScreen.of(context)?.propertyName =
                      widget.reportDatum[index].propertyName.toString();
                  EmergencyReportScreen.of(context)?.propertyId =
                      widget.reportDatum[index].id.toString();
                  widget.onCallback();
                },
                leading: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                        imageUrl: widget.imageBaseUrl.toString() +
                            '/' +
                            widget.reportDatum[index].propertyAvatars!.first
                                .propertyAvatar
                                .toString(),
                        fit: BoxFit.fill,
                        width: 50,
                        height: 50,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                              strokeCap: StrokeCap.round,
                            ),
                        errorWidget: (context, url, error) => Image.asset(
                              'assets/sgt_logo.jpg',
                              fit: BoxFit.fill,
                            )),
                  ),
                  radius: 30,
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  widget.reportDatum[index].propertyName.toString(),
                  style: CustomTheme.blackTextStyle(17),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'Last Report on: ',
                      style: CustomTheme.greyTextStyle(12),
                    ),
                    Text(widget.reportDatum[index].lastReportOn.toString(),
                        style:
                            CustomTheme.blueTextStyle(12, FontWeight.normal)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
