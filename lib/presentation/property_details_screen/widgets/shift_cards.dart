// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../../utils/const.dart';
import '../../shift_details_screen/upcoming_shift_details_screen.dart';

// class ShiftCardModel {
//   final String shiftdate;
//   final String shifttime;
//   ShiftCardModel({
//     required this.shiftdate,
//     required this.shifttime,
//   });
// }

// List<ShiftCardModel> shiftCardsData = [
//   ShiftCardModel(shiftdate: '6/20/22', shifttime: '07:30 AM'),
//   ShiftCardModel(shiftdate: '7/08/22', shifttime: '09:30 AM'),
//   ShiftCardModel(shiftdate: '9/14/22', shifttime: '10:30 AM'),
// ];

class ShiftCards extends StatefulWidget {
  List<Shift>? shifts;
  String? imageBaseUrl;
  ShiftCards({super.key, 
  required this.shifts,this.imageBaseUrl
  });

  @override
  State<ShiftCards> createState() => _ShiftCardsState();
}

class _ShiftCardsState extends State<ShiftCards> {

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.shifts!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  screenNavigator(context, UpcomingShiftDetailsScreen(
                    shifts: widget.shifts![index],
                    imageBaseUrl:widget.imageBaseUrl
                  ));
                },
                child: Container(
                  height: 48,
                  // width: 122,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                       "(${widget.shifts![index].date.toString()})"+'\n'+widget.shifts![index].shiftTime.toString(),
                        // widget.shifts![index].clockIn.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold, overflow: TextOverflow.fade),
                      ),
                      const SizedBox(
                        height: 5,
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
