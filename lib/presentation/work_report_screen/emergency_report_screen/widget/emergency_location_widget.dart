import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/custom_theme.dart';
import '../../../map_screen/map_screen.dart';
import '../../widget/edit_location.dart';

class EmergencyLocationWidget extends StatelessWidget {
  const EmergencyLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.my_location, color: CustomTheme.primaryColor),
              SizedBox(width: 5),
              Text(
                'Location',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: CustomTheme.black,
                    fontWeight: FontWeight.bold),
                textScaleFactor: 1.0,
              ),
              SizedBox(width: 135),
              InkWell(
                onTap: () {
                  screenNavigator(context, EditLocationScreen());
                },
                child: Text(
                  'Edit Location',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: CustomTheme.primaryColor,
                      fontWeight: FontWeight.bold),
                  textScaleFactor: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Container(height: 150, child: MapScreen()),
        ],
      ),
    );
  }
}
