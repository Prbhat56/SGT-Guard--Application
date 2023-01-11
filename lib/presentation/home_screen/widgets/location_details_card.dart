import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_functions.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../../utils/const.dart';
import '../../property_details_screen/property_details_screen.dart';
import 'location_details_model.dart';

class LocationDetailsCard extends StatefulWidget {
  const LocationDetailsCard({super.key});

  @override
  State<LocationDetailsCard> createState() => _LocationDetailsCardState();
}

class _LocationDetailsCardState extends State<LocationDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          screenNavigator(context, PropertyDetailsScreen());
        },
        child: Container(
          //giving listview height accrding to the number of
          //location we have in the data model
          height: 290 * locationData.length.toDouble(),
          child: ListView.builder(
              itemCount: locationData.length,
              //using physics to stop the default scrolling behaviour of listview
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 204,
                        decoration: CustomTheme.locationCardStyle(
                            locationData[index].imageUrl),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locationData[index].title,
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            locationData[index].duty,
                            style: TextStyle(fontSize: 17, color: primaryColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryColor,
                            size: 15,
                          ),
                          Text(
                            locationData[index].subtitle,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          locationData[index].address,
                          style: TextStyle(fontSize: 13, color: black),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
