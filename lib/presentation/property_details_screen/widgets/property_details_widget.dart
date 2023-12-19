import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import '../../widgets/custom_circular_image_widget.dart';
import 'property_data_widget.dart';
import 'package:http/http.dart' as http;

class PropertyDetailsWidget extends StatefulWidget {
  InactiveDatum? activeData = InactiveDatum();
  String? imageBaseUrl;
  int? propertyId;
  PropertyDetailsWidget(
      {super.key, this.activeData, this.imageBaseUrl, this.propertyId});

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
                        widget.activeData!.propertyAvatars!.first.propertyAvatar.toString(),
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
                            widget.activeData!.propertyName.toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.activeData!.location.toString(),
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Last Shift:',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.activeData!.shifts!.last.clockIn
                                        .toString() +
                                    '~' +
                                    widget.activeData!.shifts!.last.clockOut
                                        .toString(),
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
              //SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    PropertyDataWidget(
                        title: 'Guards',
                        number: widget.activeData!.assignStaff.toString()),
                    PropertyDataWidget(
                        title: 'Points',
                        number:
                            widget.activeData!.checkPoints!.length.toString()),
                    PropertyDataWidget(
                        title: 'Sqft',
                        number: widget.activeData!.area.toString())
                  ]

                      /*propertyData
                      //showing property data by map over the data list
                      .map((e) =>
                          PropertyDataWidget(title: e.title, number: e.number))
                      .toList(),*/
                      ),
                ),
              ),
              SizedBox(height: 20),
            ],
          )),
    );
  }
}
