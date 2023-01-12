import 'package:flutter/material.dart';
import '../../../utils/const.dart';
import '../../widgets/custom_circular_image_widget.dart';
import 'property_data_widget.dart';

class PropertyDetailsWidget extends StatelessWidget {
  const PropertyDetailsWidget({super.key});
  final imageUrl =
      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: seconderyLightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomCircularImage.getCircularImage(imageUrl, false, 42, 0, 0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rivi Properties',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  const Text(
                    '1517 South Centelella',
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
                        ' October 24, 10:00 AM ~ 4:00 PM',
                        style: TextStyle(
                          color: black,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 33),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: propertyData
                  //showing property data by map over the data list
                  .map((e) =>
                      PropertyDataWidget(title: e.title, number: e.number))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
