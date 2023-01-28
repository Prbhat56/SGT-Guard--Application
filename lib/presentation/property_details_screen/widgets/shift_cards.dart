// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';

import '../../../utils/const.dart';
import '../../shift_details_screen/upcoming_shift_details_screen.dart';

class ShiftCardModel {
  final String shiftdate;
  final String shifttime;
  ShiftCardModel({
    required this.shiftdate,
    required this.shifttime,
  });
}

List<ShiftCardModel> shiftCardsData = [
  ShiftCardModel(shiftdate: '6/20/22', shifttime: '07:30 AM'),
  ShiftCardModel(shiftdate: '7/08/22', shifttime: '09:30 AM'),
  ShiftCardModel(shiftdate: '9/14/22', shifttime: '10:30 AM'),
];

class ShiftCards extends StatelessWidget {
  const ShiftCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        height: 50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shiftCardsData.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  screenNavigator(context, UpcomingShiftDetailsScreen());
                },
                child: Container(
                  height: 48,
                  width: 122,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: seconderyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        shiftCardsData[index].shiftdate,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        shiftCardsData[index].shifttime,
                        style: TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
