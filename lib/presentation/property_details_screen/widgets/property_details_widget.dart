import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
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
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            widget.detailsData!.type.toString(),
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'last_shift'.tr,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              widget.detailsData!.lastShiftTime!.isEmpty ?
                               Text(
                                ' No Shift Available ',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              :  Text(
                                widget.detailsData!.lastShiftTime.toString(),
                                // ' ${widget.detailsData == null ? '' : widget.detailsData!.shifts!.last.clockIn.toString()} ~ ${widget.detailsData!.shifts!.isEmpty ? '' : widget.detailsData!.shifts!.last.clockOut.toString()}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 11.sp,
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
                padding: EdgeInsets.only(left: 40.w),
                child: Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    PropertyDataWidget(
                        title: 'guard'.tr,
                        number: widget.detailsData!.assignStaff.toString()),
                    PropertyDataWidget(
                        title: 'checkpoint'.tr, number: widget.detailsData!.checkpointCount.toString()),
                    PropertyDataWidget(
                        title: 'sqft'.tr,
                        number: widget.detailsData!.area.toString())
                  ]),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          )),
    );
  }
}
