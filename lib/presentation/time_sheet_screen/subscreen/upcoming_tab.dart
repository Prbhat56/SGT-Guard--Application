import 'package:flutter/material.dart';
import 'package:sgt/presentation/property_details_screen/property_details_screen.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/time_sheet_model.dart';
import '../../../helper/navigator_function.dart';
import '../../../utils/const.dart';
import '../../widgets/custom_circular_image_widget.dart';

class UpcomingWidgetTab extends StatelessWidget {
  const UpcomingWidgetTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dummytimeSheetData.length,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: CustomCircularImage.getlgCircularImage(
                              '',dummytimeSheetData[index].imageUrl, false)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dummytimeSheetData[index].title,
                            style: const TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            dummytimeSheetData[index].date,
                            style: const TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            dummytimeSheetData[index].time,
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        dummytimeSheetData[index].shiftTime,
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
