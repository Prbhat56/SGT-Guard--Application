import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/navigator_function.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';
import '../../map_screen/map_screen.dart';

class MapCardWidget extends StatelessWidget {
  const MapCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: CustomTheme.mapCardShadow),
            height: 231,
            width: 339.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MapScreen(),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () {
              screenNavigator(context, MapScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.near_me,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
