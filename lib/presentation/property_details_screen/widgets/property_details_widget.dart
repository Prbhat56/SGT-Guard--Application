import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';

import '../../../utils/const.dart';
import '../../widgets/custom_circular_image_widget.dart';
import 'property_data_widget.dart';

class PropertyDetailsWidget extends StatefulWidget {
  Data? detailsData = Data();
  String? imageBaseUrl;
  String? checkPoint;
  PropertyDetailsWidget(
      {super.key, this.detailsData, this.imageBaseUrl, this.checkPoint});

  @override
  State<PropertyDetailsWidget> createState() => _PropertyDetailsWidgetState();
}

class _PropertyDetailsWidgetState extends State<PropertyDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: seconderyColor.withAlpha(40),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomCircularImage.getCircularImage(
                        widget.imageBaseUrl.toString(),
                        // '${widget.detailsData!.propertyAvatars!.isEmpty ? null : widget.detailsData!.propertyAvatars!.first.propertyAvatar}',
                        '${widget.detailsData!.propertyAvatars!.first.propertyAvatar}',
                        false,
                        42,
                        0,
                        0),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.detailsData!.propertyName.toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.detailsData!.type.toString(),
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Last Shift: ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              widget.detailsData!.lastShiftTime!.isEmpty ?
                               Text(
                                ' No Shift Available ',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              :  Text(
                                widget.detailsData!.lastShiftTime.toString(),
                                // ' ${widget.detailsData == null ? '' : widget.detailsData!.shifts!.last.clockIn.toString()} ~ ${widget.detailsData!.shifts!.isEmpty ? '' : widget.detailsData!.shifts!.last.clockOut.toString()}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    PropertyDataWidget(
                        title: 'Guards',
                        number: widget.detailsData!.assignStaff.toString()),
                    PropertyDataWidget(
                        title: 'Checkpoints', number: widget.detailsData!.checkpointCount.toString()),
                    PropertyDataWidget(
                        title: 'Sqft',
                        number: widget.detailsData!.area.toString())
                  ]),
                ),
              ),
              SizedBox(height: 20),
            ],
          )),
    );
  }
}
