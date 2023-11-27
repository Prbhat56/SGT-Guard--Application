import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';
import '../map_screen/map_screen.dart';

class InActivePropertyDetailsScreen extends StatefulWidget {
  const InActivePropertyDetailsScreen({super.key});

  @override
  State<InActivePropertyDetailsScreen> createState() =>
      _InActivePropertyDetailsScreenState();
}

class _InActivePropertyDetailsScreenState
    extends State<InActivePropertyDetailsScreen> {
  LatLng currentlocation = const LatLng(22.572645, 88.363892);
  final imageUrl =
      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg';
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: CustomAppBarWidget(appbarTitle: 'Inactive Property'),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCircularImage.getCircularImage(
                          '',imageUrl, false, 42, 0, 0),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rivi Properties',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '1517 South Centelella',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Last Shift: ',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                                Text(
                                  'October 24, 10:00 AM ~ 4:00 PM',
                                  style: TextStyle(fontSize: 12, color: black),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: primaryColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Job Details',
                  style: CustomTheme.textField_Headertext_Style,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Gaurd Name:',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: black),
                    ),
                    Text(
                      ' Matheus Paolo',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Position:',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: black),
                    ),
                    Text(
                      ' Superviser',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Location',
                  style: CustomTheme.textField_Headertext_Style,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '43 Bourke Street, Newbridge NSW 837\nRaffles Place, Boat Band M83',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: CustomTheme.mapCardShadow),
                        height: 231,
                        width: 343.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: currentlocation, zoom: 14)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MapScreen()));
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
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}
