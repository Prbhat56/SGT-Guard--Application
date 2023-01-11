import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/property_details_screen/property_details_screen.dart';
import 'package:sgt/utils/const.dart';
import '../../property_details_screen/inactive_property_details_screen.dart';
import '../../widgets/custom_circular_image_widget.dart';

class JobsTile extends StatelessWidget {
  const JobsTile({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            isActive
                ? screenNavigator(context, PropertyDetailsScreen())
                : screenNavigator(context, InActivePropertyDetailsScreen());
          },
          child: Row(
            children: [
              CustomCircularImage.getlgCircularImage(
                  'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                  isActive),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Rivi Properties',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 17,
                      ),
                      Text(
                        '1517 South Centelella',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 18.0, top: 6),
                    child: Text(
                      'Guard Post Duties',
                      style: TextStyle(
                          fontSize: 15, color: Color.fromARGB(255, 75, 75, 75)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
